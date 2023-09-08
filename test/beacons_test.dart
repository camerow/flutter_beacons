import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../lib/beacons.dart' show Beacons, Beacon;

void main() {
  test('Uses correct fontFamily and package', () {
    expect(Beacons.family, 'Beacons');
    expect(Beacons.pkg, 'flutter_beacons');
  });

  testWidgets('Uses default font size of 24', (WidgetTester tester) async {
    await tester.pumpWidget(Container(child: Beacon.crypto('btc')));
    final Icon widget = tester.widget(find.byType(Icon));
    expect(widget.size, 24);
  });

  testWidgets('Correctly inherits from IconTheme', (WidgetTester tester) async {
    await tester.pumpWidget(
      Container(
        child: IconTheme(
          child: Beacon.crypto('btc'),
          data: IconThemeData(
            color: Colors.blue,
            size: 18,
          ),
        ),
      ),
    );
    final Icon widget = tester.widget(find.byType(Icon));
    expect(widget.color, Colors.blue);
    expect(widget.size, 18);
  });

  testWidgets('Overrides IconTheme', (WidgetTester tester) async {
    await tester.pumpWidget(
      Container(
        child: IconTheme(
          child: Beacon.crypto(
            'btc',
            color: Colors.red,
            size: 80,
          ),
          data: IconThemeData(
            color: Colors.blue,
            size: 18,
          ),
        ),
      ),
    );
    final Icon widget = tester.widget(find.byType(Icon));
    expect(widget.color, Colors.red);
    expect(widget.size, 80);
  });
}
