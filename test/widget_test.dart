// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cyr/app.dart';

import 'package:cloudbase_core/cloudbase_core.dart';

final String _env = "cyr-8ggh10pv6acc355c";
final String _androidAccessKey = "b440148ed71d399c1f0ee933058f8ffd";


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  //初始化CloudBase环境
  CloudBaseCore core = CloudBaseCore.init({
    'env': _env,
    'appAccess': {'key': _androidAccessKey, 'version': "1"},
    'timeout': 3000
  });
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
