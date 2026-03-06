// Widget tests for register, login, forgot password, and logout.
// Uses mocked auth/session/forgot-password providers (no real API calls).
// Run: flutter test test/auth_flow_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/app.dart';
import 'package:mnstrv2/models/auth.dart';
import 'package:mnstrv2/models/user.dart';
import 'package:mnstrv2/providers/auth.dart';
import 'package:mnstrv2/providers/session_users.dart';

void main() {
  group('Auth flow tests', () {
    late List<Override> overrides;

    setUp(() {
      overrides = [
        authProvider.overrideWith(() => _MockAuthNotifier()),
        sessionUserProvider.overrideWith(() => _MockSessionUserNotifier()),
        forgotPasswordProvider.overrideWith(
          () => _MockForgotPasswordNotifier(),
        ),
      ];
    });

    testWidgets(
      'Login flow: open login, enter credentials, submit, land on home',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(overrides: overrides, child: const App()),
        );
        await tester.pumpAndSettle();

        // Home shows Login when not authenticated
        expect(find.text('Login'), findsOneWidget);
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();

        // On login screen
        expect(find.text('User Login'), findsOneWidget);
        await tester.enterText(
          find.byType(TextField).first,
          'test@example.com',
        );
        await tester.enterText(find.byType(TextField).at(1), 'password123');
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();

        // After login we should be on Home (Login/Register buttons gone, Logout present)
        expect(find.text('Logout'), findsOneWidget);
        expect(find.text('Login'), findsNothing);
      },
    );

    testWidgets(
      'Logout flow: when logged in, tap logout, land on home with Login',
      (tester) async {
        // Start with auth already set (simulate logged-in state)
        final mockAuth = _MockAuthNotifier();
        overrides = [
          authProvider.overrideWith(() => mockAuth),
          sessionUserProvider.overrideWith(() => _MockSessionUserNotifier()),
          forgotPasswordProvider.overrideWith(
            () => _MockForgotPasswordNotifier(),
          ),
        ];
        // Pre-set logged-in state by running login once
        await tester.pumpWidget(
          ProviderScope(overrides: overrides, child: const App()),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byType(TextField).first,
          'test@example.com',
        );
        await tester.enterText(find.byType(TextField).at(1), 'pass');
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();

        expect(find.text('Logout'), findsOneWidget);
        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();

        // Back on home, unauthenticated
        expect(find.text('Login'), findsOneWidget);
        expect(find.text('Logout'), findsNothing);
      },
    );

    testWidgets(
      'Register flow: open register, fill form, submit, see verification step',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(overrides: overrides, child: const App()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Register'), findsOneWidget);
        await tester.tap(find.text('Register'));
        await tester.pumpAndSettle();

        expect(find.text('Registration'), findsOneWidget);
        await tester.enterText(find.byType(TextFormField).first, 'Test User');
        await tester.enterText(
          find.byType(TextFormField).at(1),
          'newuser@example.com',
        );
        await tester.enterText(find.byType(TextFormField).at(2), 'secret123');
        await tester.enterText(find.byType(TextFormField).at(3), 'secret123');
        await tester.tap(find.text('Register'));
        await tester.pumpAndSettle();

        // After register, mock leaves us on register screen with verification code step
        expect(find.text('Verification Code'), findsOneWidget);
        expect(find.text('Verify Email'), findsOneWidget);
      },
    );

    testWidgets(
      'Forgot password flow: open forgot, enter email, see code step',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(overrides: overrides, child: const App()),
        );
        await tester.pumpAndSettle();

        // Forgot password is on Login screen; open Login first
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Forgot password?'));
        await tester.pumpAndSettle();

        expect(find.text('Forgot Password'), findsOneWidget);
        await tester.enterText(
          find.byType(TextFormField).first,
          'user@example.com',
        );
        await tester.tap(find.text('Check For User'));
        await tester.pumpAndSettle();

        // After forgotPassword, we see code form
        expect(find.text('Code'), findsOneWidget);
        expect(find.text('Verify Code'), findsOneWidget);
      },
    );

    testWidgets(
      'Forgot password full flow: email -> code -> reset -> login screen',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(overrides: overrides, child: const App()),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Forgot password?'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byType(TextFormField).first,
          'user@example.com',
        );
        await tester.tap(find.text('Check For User'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).first, '123456');
        await tester.tap(find.text('Verify Code'));
        await tester.pumpAndSettle();

        // Reset password form
        await tester.enterText(find.byType(TextFormField).first, 'newpass123');
        await tester.enterText(find.byType(TextFormField).at(1), 'newpass123');
        await tester.tap(find.text('Reset'));
        await tester.pumpAndSettle();

        // Should land on login screen
        expect(find.text('User Login'), findsOneWidget);
      },
    );

    testWidgets('Navigate from login to register and back', (tester) async {
      await tester.pumpWidget(
        ProviderScope(overrides: overrides, child: const App()),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(find.text('User Login'), findsOneWidget);

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();
      expect(find.text('Registration'), findsOneWidget);

      await tester.tap(find.text('Login?'));
      await tester.pumpAndSettle();
      expect(find.text('User Login'), findsOneWidget);
    });
  });
}

// --- Mock notifiers (extend real notifiers, no API calls) ---

class _MockAuthNotifier extends AuthNotifier {
  _MockAuthNotifier() : super(auth: null);

  @override
  Future<String?> login(String email, String password) async {
    state = Auth(
      id: 'session-1',
      token: 'mock-token',
      userID: 'user-1',
      expiresAt: DateTime.now().add(const Duration(days: 1)),
    );
    ref
        .read(sessionUserProvider.notifier)
        .setUser(
          User(
            id: 'user-1',
            displayName: 'Test User',
            email: email,
            experienceLevel: 1,
            experiencePoints: 0,
            experienceToNextLevel: 100,
            coins: 0,
          ),
        );
    return null;
  }

  @override
  Future<String?> logout() async {
    state = null;
    await ref.read(sessionUserProvider.notifier).logout();
    return null;
  }
}

class _MockSessionUserNotifier extends SessionUserNotifier {
  _MockSessionUserNotifier() : super(user: null);

  @override
  Future<String?> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    state = User(
      id: 'user-1',
      displayName: displayName,
      email: email,
      experienceLevel: 0,
      experiencePoints: 0,
      experienceToNextLevel: 100,
      coins: 0,
    );
    return null;
  }

  @override
  Future<String?> verifyEmail({
    required String id,
    required String code,
  }) async => null;

  @override
  Future<void> logout() async {
    state = null;
  }
}

class _MockForgotPasswordNotifier extends ForgotPasswordNotifier {
  @override
  Future<String?> forgotPassword({required String email}) async {
    state = 'user-1';
    return null;
  }

  @override
  Future<String?> verifyCode({required String code}) async => null;

  @override
  Future<String?> resetPassword({required String password}) async {
    state = null;
    return null;
  }
}
