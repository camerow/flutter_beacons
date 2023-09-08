import 'package:dart_style/dart_style.dart';
import 'package:code_builder/code_builder.dart';

const fontFamily = 'Beacons';

const fontPackage = 'flutter_beacons';

final emitter = DartEmitter();

class BeaconGenerator {
  static String generateImports() {
    final library = Library(
      (b) => b.body.addAll([
        Directive.import('package:flutter/widgets.dart'),
      ]),
    );

    return DartFormatter().format('${library.accept(emitter)}');
  }

  static String generateBaseClass(List<Field> fields) {
    final c = Class(
      (b) => b
        ..name = '$fontFamily'
        ..fields.addAll(
          [
            Field(
              (updates) => updates
                ..name = 'family'
                ..static = true
                ..assignment = Code('"$fontFamily"')
                ..modifier = FieldModifier.constant,
            ),
            Field(
              (updates) => updates
                ..name = 'pkg'
                ..static = true
                ..assignment = Code('"$fontPackage"')
                ..modifier = FieldModifier.constant,
            ),
            ...fields,
          ],
        ),
    );
    return DartFormatter().format('${c.accept(emitter)}');
  }
}

Map<String, bool> conflicts = {};

class SymbolIconData {
  late String name;
  late String staticName;
  late String codePoint;

  SymbolIconData(String name, String hex) {
    this.staticName = name.replaceAll('-', '_');
    this.name = _stringToName(name);
    this.codePoint = '0x$hex';
  }

  Code _code() {
    return Code(
      'IconData(${this.codePoint}, fontFamily: family, fontPackage: pkg,)',
    );
  }

  String _stringToName(String name) {
    if (conflicts[name] != null ||
        name.contains('.') ||
        name.contains('\"') ||
        name.contains('\'') ||
        name == 'null') {
      throw Exception(
        'Unavoidable name conflict: incoming: $name conflicts with: ${conflicts[name]}',
      );
    }

    conflicts[name] = true;
    return name;
  }

  String get mapEntry {
    return "'$name': $fontFamily.$staticName";
  }

  Field generateSelfField() {
    return Field(
      (f) => f
        ..static = true
        ..name = staticName
        ..modifier = FieldModifier.constant
        ..assignment = _code(),
    );
  }

  @override
  String toString() {
    return '$name, $staticName, $codePoint';
  }
}
