import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/rating.dart';

Widget createStar() => MaterialApp(
  home: Scaffold(
    body: RatingStar(count: 5)
  )
);

void main() {
  testWidgets('Testing if rating star shows up', (WidgetTester tester) async {
    await tester.pumpWidget(createStar());
    expect(find.byType(Icon), findsNWidgets(5));
  });
}