import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/features/home/view/home_page.dart';
import 'package:payments_application/features/others/view/others_page.dart';
import 'package:payments_application/features/otp_based/view/otp_based_page.dart';
import 'package:payments_application/features/payments/view/payments_page.dart';
import 'package:payments_application/features/payments/view/re_initiate/view/re_initiate_page.dart';
import 'package:payments_application/features/sbi/view/sbi_page.dart';
import '../../../features/home/view/shell/main_shell.dart';
import 'app_route_name.dart';
import 'app_route_path.dart';

class AppRoutes {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  late final GoRouter appRouter;

  AppRoutes() {
    appRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: RoutesPath.home,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return MainShell(child: child);
          },
          routes: [
            GoRoute(
              name: RoutesName.home,
              path: RoutesPath.home,
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const HomePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
              routes: [
                GoRoute(
                  name: RoutesName.payments,
                  path: 'payments',
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: const PaymentsPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  ),
                  routes: [
                    GoRoute(
                      name: RoutesName.reInitiate,
                      path: 're_initiate/:userId/:userName',
                      pageBuilder: (context, state) {
                        final userId = int.tryParse(state.pathParameters['userId'] ?? '') ?? 0;
                        final userName = state.pathParameters['userName'] ?? '';
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: ReInitiatePage(userId: userId, userName: userName),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                        );
                      },
                    ),

                  ]
                ),
                GoRoute(
                  name: RoutesName.others,
                  path: 'others',
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: const OthersPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  ),
                ),
                GoRoute(
                  name: RoutesName.otp_based,
                  path: 'otp_based',
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: const OtpBasedPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  ),
                ),
                GoRoute(
                  name: RoutesName.sbi,
                  path: 'sbi',
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: const SbiPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
