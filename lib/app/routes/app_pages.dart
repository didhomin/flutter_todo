import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/todo_details/bindings/todo_details_binding.dart';
import '../modules/todo_details/views/todo_details_view.dart';
import '../modules/todo/bindings/todo_binding.dart';
import '../modules/todo/views/todo_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: '/',
      page: () => RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          // middlewares: [
          //   //only enter this route when not authed
          //   EnsureNotAuthedMiddleware(),
          // ],
          name: _Paths.LOGIN,
          title: 'Login',
          page: () => LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          middlewares: [
            //only enter this route when authed
            EnsureAuthMiddleware(),
          ],
          preventDuplicates: true,
          name: _Paths.HOME,
          page: () => HomeView(),
          bindings: [
            HomeBinding(),
          ],
          title: 'Home',
          children: [
            GetPage(
              name: _Paths.DASHBOARD,
              title: 'Dashboard',
              page: () => DashboardView(),
              binding: DashboardBinding(),
            ),
            GetPage(
              middlewares: [
                //only enter this route when authed
                EnsureAuthMiddleware(),
              ],
              name: _Paths.HISTORY,
              page: () => HistoryView(),
              title: 'History',
              transition: Transition.size,
              binding: HistoryBinding(),
            ),
            GetPage(
              middlewares: [
                //only enter this route when authed
                EnsureAuthMiddleware(),
              ],
              name: _Paths.TODO,
              page: () => TodoView(),
              title: 'Todo',
              transition: Transition.zoom,
              binding: TodoBinding(),
              children: [
                GetPage(
                  name: _Paths.TODO_DETAILS,
                  page: () => TodoDetailsView(),
                  binding: TodoDetailsBinding(),
                  middlewares: [
                    //only enter this route when authed
                    EnsureAuthMiddleware(),
                  ],
                ),
              ],
            ),
          ],
        ),
        GetPage(
          name: _Paths.SETTINGS,
          title: 'Setting',
          page: () => SettingsView(),
          binding: SettingsBinding(),
        ),
      ],
    ),
  ];
}
