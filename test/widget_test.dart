import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/app.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/main_shell/widgets/add_button.dart';
import 'package:drift/native.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    Get.testMode = true;
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDefaultCategories();
    await database.seedDefaultPaymentAccounts();
    await database.seedDefaultEntities();
  });

  tearDownAll(() async {
    await database.close();
    Get.reset();
  });

  testWidgets('main shell opens add transaction actions', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pump();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Transactions'), findsOneWidget);
    expect(find.text('Planner'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    await tester.tap(find.byType(AddButton));
    await tester.pumpAndSettle();

    expect(find.text('Earn Money'), findsOneWidget);
    expect(find.text('Spend Money'), findsOneWidget);
    expect(find.text('Transfer Money'), findsOneWidget);
    expect(find.text('Receive Money'), findsOneWidget);
    expect(find.text('Give Money'), findsOneWidget);
  });
}
