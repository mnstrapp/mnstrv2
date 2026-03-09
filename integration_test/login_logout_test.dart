import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mnstrv2/auth/login.dart';
import 'package:mnstrv2/home/home.dart';
import 'package:mnstrv2/models/auth.dart';
import 'package:mnstrv2/models/user.dart';
import 'package:mnstrv2/providers/auth.dart';
import 'package:mnstrv2/providers/session_users.dart';
import 'package:mnstrv2/providers/sync.dart';
import 'package:mnstrv2/theme.dart';

// ---------------------------------------------------------------------------
// Mock notifiers — no network calls are made.
// ---------------------------------------------------------------------------

/// Bypasses the refresh HTTP call that MonsterXpBar triggers on init.
class _MockSessionUserNotifier extends SessionUserNotifier {
  @override
  Future<String?> refresh() async => null;
}

/// Login always succeeds and populates auth + session user state.
class _SuccessAuthNotifier extends AuthNotifier {
  @override
  Future<String?> login(String email, String password) async {
    final auth = Auth(id: 'session-id', token: 'test-token');
    state = auth;
    ref.read(sessionUserProvider.notifier).setUser(
      User(
        id: 'user-id',
        email: email,
        displayName: 'Test User',
        experienceLevel: 1,
        experiencePoints: 0,
        experienceToNextLevel: 100,
        coins: 0,
      ),
    );
    return null;
  }
}

/// Login always returns an error.
class _LoginFailureAuthNotifier extends AuthNotifier {
  @override
  Future<String?> login(String email, String password) async =>
      'There was an error logging in';
}

/// Starts already authenticated. Logout clears state and succeeds.
class _AuthenticatedAuthNotifier extends AuthNotifier {
  _AuthenticatedAuthNotifier()
    : super(auth: Auth(id: 'session-id', token: 'test-token'));

  @override
  Future<String?> logout() async {
    state = null;
    return null;
  }
}

/// Starts already authenticated. Logout clears state but returns an error
/// (simulates the remote call failing after local state is cleared).
class _LogoutFailureAuthNotifier extends AuthNotifier {
  _LogoutFailureAuthNotifier()
    : super(auth: Auth(id: 'session-id', token: 'test-token'));

  @override
  Future<String?> logout() async {
    state = null;
    return 'There was an error logging out';
  }
}

/// Prevents HomeView from triggering a real sync on init.
class _NoOpSyncNotifier extends SyncNotifier {
  @override
  Future<String?> sync({bool onlyPush = true}) async => null;
}

// ---------------------------------------------------------------------------
// Test harness helpers
// ---------------------------------------------------------------------------

/// Standard overrides for any test that starts at LoginView.
List<Override> _loginOverrides(AuthNotifier Function() authFactory) => [
  authProvider.overrideWith(authFactory),
  sessionUserProvider.overrideWith(() => _MockSessionUserNotifier()),
  syncProvider.overrideWith(() => _NoOpSyncNotifier()),
  // Mark as previously synced so HomeView won't trigger _sync() on init.
  previouslySyncedProvider.overrideWith(
    () => PreviouslySyncedNotifier(previouslySynced: true),
  ),
];

/// Standard overrides for any test that starts at HomeView already authenticated.
List<Override> _authenticatedOverrides(AuthNotifier Function() authFactory) => [
  authProvider.overrideWith(authFactory),
  sessionUserProvider.overrideWith(() => _MockSessionUserNotifier()),
  syncProvider.overrideWith(() => _NoOpSyncNotifier()),
  previouslySyncedProvider.overrideWith(
    () => PreviouslySyncedNotifier(previouslySynced: true),
  ),
];

Widget _buildTestApp({
  required Widget home,
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: home,
      theme: theme,
      debugShowCheckedModeBanner: false,
    ),
  );
}

/// Enters [email] and [password] into the two TextFields of LoginView.
Future<void> _fillLoginForm(
  WidgetTester tester, {
  String email = 'test@example.com',
  String password = 'password123',
}) async {
  await tester.enterText(find.byType(TextField).at(0), email);
  await tester.enterText(find.byType(TextField).at(1), password);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // =========================================================================
  // Login
  // =========================================================================

  group('Login', () {
    // -----------------------------------------------------------------------
    // Form rendering
    // -----------------------------------------------------------------------

    testWidgets('shows all required fields and navigation links', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const LoginView(),
          overrides: _loginOverrides(() => _LoginFailureAuthNotifier()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('User Login'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Validation — LoginView uses imperative checks, not form validators
    // -----------------------------------------------------------------------

    testWidgets('shows error banner when email is empty', (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const LoginView(),
          overrides: _loginOverrides(() => _LoginFailureAuthNotifier()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('shows error banner when password is empty', (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const LoginView(),
          overrides: _loginOverrides(() => _LoginFailureAuthNotifier()),
        ),
      );
      await tester.pumpAndSettle();

      // Provide email only, leave password empty
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Password is required'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // API failure
    // -----------------------------------------------------------------------

    testWidgets('shows error banner when login API fails', (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const LoginView(),
          overrides: _loginOverrides(() => _LoginFailureAuthNotifier()),
        ),
      );
      await tester.pumpAndSettle();

      await _fillLoginForm(tester, password: 'wrongpassword');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('There was an error logging in'), findsOneWidget);
      // Remains on the login screen
      expect(find.text('User Login'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Successful login → HomeView
    // -----------------------------------------------------------------------

    testWidgets(
      'navigates to HomeView and shows Logout button after successful login',
      (tester) async {
        await tester.pumpWidget(
          _buildTestApp(
            home: const LoginView(),
            overrides: _loginOverrides(() => _SuccessAuthNotifier()),
          ),
        );
        await tester.pumpAndSettle();

        await _fillLoginForm(tester);
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();

        // HomeView shows authenticated navigation — Logout present, Login absent
        expect(find.text('Logout'), findsOneWidget);
        expect(find.text('User Login'), findsNothing);
      },
    );
  });

  // =========================================================================
  // Logout
  // =========================================================================

  group('Logout', () {
    // -----------------------------------------------------------------------
    // Precondition: authenticated HomeView
    // -----------------------------------------------------------------------

    testWidgets('shows Logout button when user is authenticated', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const HomeView(),
          overrides: _authenticatedOverrides(() => _AuthenticatedAuthNotifier()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Logout'), findsOneWidget);
      // Login / Register buttons are hidden when authenticated
      expect(find.text('Login'), findsNothing);
      expect(find.text('Register'), findsNothing);
    });

    testWidgets('shows Login and Register buttons when not authenticated', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const HomeView(),
          // Default AuthNotifier has null auth — unauthenticated state
          overrides: [
            authProvider.overrideWith(() => AuthNotifier()),
            sessionUserProvider.overrideWith(() => _MockSessionUserNotifier()),
            syncProvider.overrideWith(() => _NoOpSyncNotifier()),
            previouslySyncedProvider.overrideWith(
              () => PreviouslySyncedNotifier(previouslySynced: true),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Logout'), findsNothing);
    });

    // -----------------------------------------------------------------------
    // Successful logout
    // -----------------------------------------------------------------------

    testWidgets(
      'navigates to HomeView with Login/Register buttons after logout',
      (tester) async {
        await tester.pumpWidget(
          _buildTestApp(
            home: const HomeView(),
            overrides: _authenticatedOverrides(
              () => _AuthenticatedAuthNotifier(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Confirm authenticated state before logout
        expect(find.text('Logout'), findsOneWidget);

        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();

        // After logout auth is null — new HomeView shows Login / Register
        expect(find.text('Login'), findsOneWidget);
        expect(find.text('Register'), findsOneWidget);
        expect(find.text('Logout'), findsNothing);
      },
    );

    // -----------------------------------------------------------------------
    // Logout with remote API failure
    // (auth state is still cleared locally; navigation still occurs)
    // -----------------------------------------------------------------------

    testWidgets(
      'still clears session and navigates when logout API fails',
      (tester) async {
        await tester.pumpWidget(
          _buildTestApp(
            home: const HomeView(),
            overrides: _authenticatedOverrides(
              () => _LogoutFailureAuthNotifier(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();

        // Local auth state is cleared even when the remote call fails,
        // so the new HomeView shows unauthenticated buttons.
        expect(find.text('Login'), findsOneWidget);
        expect(find.text('Logout'), findsNothing);
      },
    );
  });
}
