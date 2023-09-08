import 'dart:convert';

import 'package:code_builder/code_builder.dart';
import 'dart:io';

import './beacon_generator.dart';

void main(List<String> arguments) {
  print('\nGenerating icons...\n');

  var beaconsFile = arguments[0];
  var outfile = arguments[1];

  List<String> output = [];

  output.add(
    '/// This is a generated file, please do not edit. \n\n/// ${'=' * 45}\n',
  );

  output.add(BeaconGenerator.generateImports());

  var file = File(beaconsFile);
  if (!file.existsSync()) {
    print('[FAILURE] Cannot find the file "$beaconsFile".');
    return;
  }

  var beaconsJson = file.readAsStringSync();

  List<SymbolIconData> iconData = parseJson(beaconsJson);

  List<Field> fields = [];
  List<String> iconsEntries = [];

  for (var icon in iconData) {
    fields.add(icon.generateSelfField());
    iconsEntries.add(icon.mapEntry);
  }

  print('\nGenerated ${iconData.length} icons.\n');

  var iconsStringToDataMap = Field(
    (f) => f
      ..name = 'icons'
      ..static = true
      ..type = Reference('Map<String, IconData>')
      ..assignment = Code('{ ${iconsEntries.join(',')} }')
      ..modifier = FieldModifier.constant,
  );

  fields.insert(0, iconsStringToDataMap);

  print('Writing to $outfile\n');

  output.add(BeaconGenerator.generateBaseClass(fields));

  File(outfile).writeAsString(output.join('\n'));

  print('Done!');
}

List<SymbolIconData> parseJson(
  String beaconsJson,
) {
  var variables = Map<String, String>.from(json.decode(beaconsJson));

  List<SymbolIconData> iconData = [];

  /// Loop through all variables with `codePoint` values.

  for (var name in variables.keys) {
    var hex = variables[name];
    if (hex != null) {
      try {
        var icon = SymbolIconData(name.trim(), hex.trim());
        iconData.add(icon);
      } on Exception catch (_) {
        print(
          'Ignoring "$name" due to a name collision. This icon will not make it into the Beacons package.',
        );
      }
    }
  }

  return iconData.toSet().toList();
}
