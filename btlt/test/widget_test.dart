import 'package:flutter_test/flutter_test.dart';
import 'package:btlt/Cau10/app/app.dart';

void main() {
  testWidgets('App renders user screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Dashboard Multi APIs'), findsOneWidget);
  });
}
