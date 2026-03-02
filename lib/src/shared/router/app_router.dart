import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/globalClass.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/splash_screen.dart';
import '../../features/mainShell/ui/collections/collection_add_screen.dart';
import '../../features/mainShell/ui/collections/collection_list_screen.dart';
import '../../features/mainShell/ui/dashboard_screen.dart';
import '../../features/mainShell/ui/insurance/insurance_detail_screen.dart';
import '../../features/mainShell/ui/insurance/insurance_list_screen.dart';
import '../../features/mainShell/ui/patients/patient_detail_screen.dart';
import '../../features/mainShell/ui/patients/patient_history_screen.dart';
import '../../features/mainShell/ui/patients/patient_list_screen.dart';
import '../../features/mainShell/ui/payments/invoice_ledger_screen.dart';
import '../../features/mainShell/ui/payments/payment_entry_screen.dart';
import '../../features/mainShell/ui/payments/settlement_screen.dart';
import '../../features/mainShell/ui/reports/reports_screen.dart';
import '../../features/mainShell/ui/tpa/tpa_detail_screen.dart';
import '../../features/mainShell/ui/tpa/tpa_list_screen.dart';
import '../widgets/main_shell.dart';
import 'package:go_router/go_router.dart';

// ── Route name constants ─────────────────────────────────────────────────────
class AppRoutes {
  // Auth
  static const splash       = '/';
  static const login        = '/login';

  // Main shell
  static const dashboard    = '/dashboard';

  // TPA
  static const tpaList      = '/tpa';

  // Collections
  static const collectionList = '/collections';
  static const collectionAdd  = '/collections/add';

  // Payments
  static const invoiceLedger  = '/invoices';
  static const settlements    = '/settlements';

  // Reports
  static const reports        = '/reports';



}
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> authChanges() => _auth.authStateChanges();
}

final authService = AuthService();

// ── Router ───────────────────────────────────────────────────────────────────
final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  refreshListenable:
  GoRouterRefreshNotifier(authService.authChanges()),



  redirect: _globalRedirect,
  routes: [

    // ── Splash ───────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // ── Login ────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),

    // ── Main Shell (Sidebar layout) ──────────────────────────
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [

        // ── Dashboard ─────────────────────────────────────────
        GoRoute(
          path: AppRoutes.dashboard,
          name: 'dashboard',
          pageBuilder: (context, state) => _fadePage(
            state: state,
            child: const DashboardScreen(),
          ),
        ),

        // ── TPA (nested hierarchy) ────────────────────────────
        GoRoute(
          path: AppRoutes.tpaList,
          name: 'tpa-list',
          pageBuilder: (context, state) => _fadePage(
            state: state,
            child: const TpaListScreen(),
          ),
          routes: [
            // GoRoute(
            //   path: ':tpaId',
            //   name: 'tpa-detail',
            //   pageBuilder: (context, state) => _fadePage(
            //     state: state,
            //     child: TpaDetailScreen(
            //       tpaId: state.pathParameters['tpaId']!,
            //     ),
            //   ),
            //   routes: [
            //
            //     // Insurance Companies under TPA
            //     GoRoute(
            //       path: 'companies',
            //       name: 'insurance-list',
            //       pageBuilder: (context, state) => _fadePage(
            //         state: state,
            //         child: InsuranceListScreen(
            //           tpaId: state.pathParameters['tpaId']!,
            //         ),
            //       ),
            //       routes: [
            //         GoRoute(
            //           path: ':companyId',
            //           name: 'insurance-detail',
            //           pageBuilder: (context, state) => _fadePage(
            //             state: state,
            //             child: InsuranceDetailScreen(
            //               tpaId:     state.pathParameters['tpaId']!,
            //               companyId: state.pathParameters['companyId']!,
            //             ),
            //           ),
            //           routes: [
            //
            //             // Patients under Insurance Company
            //             GoRoute(
            //               path: 'patients',
            //               name: 'patient-list',
            //               pageBuilder: (context, state) => _fadePage(
            //                 state: state,
            //                 child: PatientListScreen(
            //                   tpaId:     state.pathParameters['tpaId']!,
            //                   companyId: state.pathParameters['companyId']!,
            //                 ),
            //               ),
            //               routes: [
            //                 GoRoute(
            //                   path: ':patientId',
            //                   name: 'patient-detail',
            //                   pageBuilder: (context, state) => _fadePage(
            //                     state: state,
            //                     child: PatientDetailScreen(
            //                       tpaId:     state.pathParameters['tpaId']!,
            //                       companyId: state.pathParameters['companyId']!,
            //                       patientId: state.pathParameters['patientId']!,
            //                     ),
            //                   ),
            //                 ),
            //                 GoRoute(
            //                   path: ':patientId/history',
            //                   name: 'patient-history',
            //                   pageBuilder: (context, state) => _fadePage(
            //                     state: state,
            //                     child: PatientHistoryScreen(
            //                       tpaId:     state.pathParameters['tpaId']!,
            //                       companyId: state.pathParameters['companyId']!,
            //                       patientId: state.pathParameters['patientId']!,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //
            //           ],
            //         ),
            //       ],
            //     ),
            //
            //   ],
            // ),
            GoRoute(
              path: ':tpaId',
              name: 'tpa-detail',
              pageBuilder: (context, state) => _fadePage(
                state: state,
                child: TpaDetailScreen(tpaId: state.pathParameters['tpaId']!),
              ),
              routes: [
                GoRoute(
                  path: 'companies/:companyId/patients',
                  name: 'patient-list',
                  pageBuilder: (context, state) => _fadePage(
                    state: state,
                    child: PatientListScreen(
                      tpaId:     state.pathParameters['tpaId']!,
                      companyId: state.pathParameters['companyId']!,
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: ':patientId',
                      name: 'patient-detail',
                      pageBuilder: (context, state) => _fadePage(
                        state: state,
                        child: PatientDetailScreen(
                          tpaId:     state.pathParameters['tpaId']!,
                          companyId: state.pathParameters['companyId']!,
                          patientId: state.pathParameters['patientId']!,
                        ),
                      ),
                    ),
                    GoRoute(
                      path: ':patientId/history',
                      name: 'patient-history',
                      pageBuilder: (context, state) => _fadePage(
                        state: state,
                        child: PatientHistoryScreen(
                          tpaId:     state.pathParameters['tpaId']!,
                          companyId: state.pathParameters['companyId']!,
                          patientId: state.pathParameters['patientId']!,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // ── Collections ───────────────────────────────────────
        GoRoute(
          path: AppRoutes.collectionList,
          name: 'collection-list',
          pageBuilder: (context, state) => _fadePage(
            state: state,
            child: const CollectionListScreen(),
          ),
          routes: [
            GoRoute(
              path: 'add',
              name: 'collection-add',
              pageBuilder: (context, state) => _fadePage(
                state: state,
                child: const CollectionAddScreen(),
              ),
            ),
          ],
        ),

        // Payment Entry (per collection)
        GoRoute(
          path: '/collections/:collectionId/payment',
          name: 'payment-entry',
          pageBuilder: (context, state) => _fadePage(
            state: state,
            child: PaymentEntryScreen(
              collectionId: state.pathParameters['collectionId']!,
            ),
          ),
        ),

        // ── Invoice Ledger ────────────────────────────────────
        GoRoute(
          path: AppRoutes.invoiceLedger,
          name: 'invoice-ledger',
          pageBuilder: (context, state) => _fadePage(
            state: state,
            child: const InvoiceLedgerScreen(),
          ),
        ),

        // ── Settlements ───────────────────────────────────────
        GoRoute(
          path: AppRoutes.settlements,
          name: 'settlements',
          pageBuilder: (context, state) => _fadePage(
            state: state,
            child: const SettlementScreen(),
          ),
        ),

        // ── Reports ───────────────────────────────────────────
        GoRoute(
          path: AppRoutes.reports,
          name: 'reports',
          pageBuilder: (context, state) => _fadePage(
            state: state,
            child: const ReportsScreen(),
          ),
        ),

        // // ── Pre-Auth ──────────────────────────────────────────
        // GoRoute(
        //   path: AppRoutes.preAuth,
        //   name: 'pre-auth',
        //   pageBuilder: (context, state) => _fadePage(
        //     state: state,
        //     child: const PreAuthScreen(),
        //   ),
        // ),
        //
        // // ── Hospitals ─────────────────────────────────────────
        // GoRoute(
        //   path: AppRoutes.hospitals,
        //   name: 'hospitals',
        //   pageBuilder: (context, state) => _fadePage(
        //     state: state,
        //     child: const HospitalScreen(),
        //   ),
        // ),
        //
        // // ── Users ─────────────────────────────────────────────
        // GoRoute(
        //   path: AppRoutes.users,
        //   name: 'users',
        //   pageBuilder: (context, state) => _fadePage(
        //     state: state,
        //     child: const UsersScreen(),
        //   ),
        // ),
        //
        // // ── Notifications ─────────────────────────────────────
        // GoRoute(
        //   path: AppRoutes.notifications,
        //   name: 'notifications',
        //   pageBuilder: (context, state) => _fadePage(
        //     state: state,
        //     child: const NotificationsScreen(),
        //   ),
        // ),
        //
        // // ── Settings ──────────────────────────────────────────
        // GoRoute(
        //   path: AppRoutes.settings,
        //   name: 'settings',
        //   pageBuilder: (context, state) => _fadePage(
        //     state: state,
        //     child: const SettingsScreen(),
        //   ),
        // ),

      ],
    ),
  ],

  // ── 404 error page ─────────────────────────────────────────
  errorBuilder: (context, state) => _ErrorScreen(error: state.error),
);

// ── Global Auth Redirect ─────────────────────────────────────────────────────
String? _globalRedirect(BuildContext context, GoRouterState state) {
  final user = authService.currentUser;

  final location = state.matchedLocation;
  final isLogin = location == AppRoutes.login;
  final isSplash = location == AppRoutes.splash;


  // 🔴 Not logged in
  if (user == null) {
    // allow login & splash only
    return (isLogin || isSplash) ? null : AppRoutes.login;
  }

  // 🟢 Logged in
  if (isLogin || isSplash) {
    return AppRoutes.dashboard;
  }

  return null; // no redirect
}
// ── Fade Transition Helper ───────────────────────────────────────────────────
CustomTransitionPage<void> _fadePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeIn).animate(animation),
        child: child,
      );
    },
  );
}

// ── 404 Error Screen ─────────────────────────────────────────────────────────
class _ErrorScreen extends StatelessWidget {
  final Exception? error;
  const _ErrorScreen({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Color(0xFFADB5BD),
            ),
            const SizedBox(height: 20),
            const Text(
              '404 — Page Not Found',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212529),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              error?.toString() ??
                  'The page you are looking for does not exist.',
              style: const TextStyle(fontSize: 14, color: Color(0xFF495057)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () => context.go(AppRoutes.dashboard),
              icon: const Icon(Icons.home_rounded),
              label: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}