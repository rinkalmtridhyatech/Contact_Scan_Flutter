import 'package:contact_scan/view/modules/auth/event_auth.dart';
import 'package:contact_scan/view/modules/contactList/contact_list_screen.dart';
import 'package:contact_scan/view/modules/contactList/contact_options_screen.dart';
import 'package:contact_scan/view/modules/contactList/list_export_screen.dart';
import 'package:contact_scan/view/modules/contactList/notes_screen.dart';
import 'package:contact_scan/view/modules/eventChange/event_change_dialog_screen.dart';
import 'package:contact_scan/view/modules/scanScreen/scan_screen.dart';
import 'package:contact_scan/view/modules/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/modules/scanScreen/error_scan_result_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),

        transition: Transition.downToUp),
    GetPage(
        name: Routes.auth,
        page: () => EventAuth(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.home,
        page: () => ScanScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.changeEventDialog,
        page: () => EventChangeDialogScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.contactList,
        page: () => ContactListScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.errorScanResultScreen,
        page: () => ErrorScanResultScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.contactOptions,
        page: () => ContactOptionsScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.listExport,
        page: () => ListExportScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.notes,
        page: () => NotesScreen(),
        transition: Transition.downToUp),
  ];
}
