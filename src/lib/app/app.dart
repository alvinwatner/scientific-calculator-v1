import 'package:scientific_calc/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:scientific_calc/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:scientific_calc/features/home/home_view.dart';
import 'package:scientific_calc/features/startup/startup_view.dart';
import 'package:scientific_calc/features/calculator/calculator_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CalculatorView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: CalculatorService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
