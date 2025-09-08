
import 'dart:async'; // Add this import for StreamSubscription
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/auth_service.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/login_page.dart';
import 'package:myapp/signup_page.dart';
import 'package:myapp/regular_signup_page.dart';
import 'package:myapp/personality_test_page.dart';
import 'package:myapp/personality_summary_page.dart';



final GoRouter router = GoRouter(
  // The router's refreshListenable listens for auth changes
  refreshListenable: GoRouterRefreshStream(AuthService().authStateChanges),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) => const HomePage(),
        ),
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) => const SignUpPage(),
        ),
        GoRoute(
          path: 'regular-signup',
          builder: (BuildContext context, GoRouterState state) => const RegularSignUpPage(),
        ),
        GoRoute(
          path: 'personality-test',
          builder: (BuildContext context, GoRouterState state) {
            return PersonalityTestPage(
              fullName: state.uri.queryParameters['fullName'],
              age: state.uri.queryParameters['age'],
            );
          },
        ),
        GoRoute(
          path: 'summary',
          builder: (BuildContext context, GoRouterState state) {
            return PersonalitySummaryPage(
              personality: state.uri.queryParameters['personality'] ?? "The Social Savorer",
            );
          },
        ),
      ],
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final authService = AuthService();
    final loggedIn = authService.currentUser != null;
    
    // Get the current location
    final location = state.uri.toString();

    // Define routes that are accessible without authentication
    final authRoutes = ['/', '/signup', '/regular-signup'];

    // If the user is not logged in and trying to access a protected route, redirect to login
    if (!loggedIn && !authRoutes.contains(location)) {
      return '/';
    }

    // If the user is logged in and trying to access an authentication route, redirect to home
    if (loggedIn && authRoutes.contains(location)) {
      return '/home';
    }

    // No redirect needed
    return null;
  },
);

// This helper class listens to a Stream and notifies GoRouter to refresh.
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
