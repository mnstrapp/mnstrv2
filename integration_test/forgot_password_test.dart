import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mnstrv2/auth/forgot_password.dart';
import 'package:mnstrv2/providers/session_users.dart';
import 'package:mnstrv2/theme.dart';

// ---------------------------------------------------------------------------
// Mock notifiers — each covers a specific failure point in the 3-step wizard.
// No network calls are made in any of them.
//
// Wizard steps:
//   1. Email  → forgotPassword()  → transitions to Code form
//   2. Code   → verifyCode()      → transitions to Reset form
//   3. Reset  → resetPassword()   → navigates to LoginView
// ---------------------------------------------------------------------------

/// All three steps succeed.
class _SuccessForgotPasswordNotifier extends ForgotPasswordNotifier {
  @override
  Future<String?> forgotPassword({required String email}) async {
    state = 'test-user-id';
    return null;
  }

  @override
  Future<String?> verifyCode({required String code}) async => null;

  @override
  Future<String?> resetPassword({required String password}) async => null;
}

/// Step 1 fails; steps 2 and 3 are never reached.
class _ForgotPasswordFailureNotifier extends ForgotPasswordNotifier {
  @override
  Future<String?> forgotPassword({required String email}) async =>
      'There was an error resetting the password';
}

/// Step 1 succeeds; step 2 fails.
class _VerifyCodeFailureNotifier extends ForgotPasswordNotifier {
  @override
  Future<String?> forgotPassword({required String email}) async {
    state = 'test-user-id';
    return null;
  }

  @override
  Future<String?> verifyCode({required String code}) async =>
      'There was an error verifying the code';
}

/// Steps 1 and 2 succeed; step 3 fails.
class _ResetPasswordFailureNotifier extends ForgotPasswordNotifier {
  @override
  Future<String?> forgotPassword({required String email}) async {
    state = 'test-user-id';
    return null;
  }

  @override
  Future<String?> verifyCode({required String code}) async => null;

  @override
  Future<String?> resetPassword({required String password}) async =>
      'There was an error resetting the password';
}

// ---------------------------------------------------------------------------
// Test harness
// ---------------------------------------------------------------------------

Widget _buildTestApp({
  required ForgotPasswordNotifier Function() notifierFactory,
}) {
  return ProviderScope(
    overrides: [
      forgotPasswordProvider.overrideWith(notifierFactory),
    ],
    child: MaterialApp(
      home: const ForgotPasswordView(),
      theme: theme,
      debugShowCheckedModeBanner: false,
    ),
  );
}

/// Advances from the Email step to the Code step using a successful mock.
Future<void> _completeEmailStep(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
  await tester.tap(find.text('Check For User'));
  await tester.pumpAndSettle();
}

/// Advances from the Code step to the Reset step using a successful mock.
Future<void> _completeCodeStep(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField).first, '123456');
  await tester.tap(find.text('Verify Code'));
  await tester.pumpAndSettle();
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Forgot Password', () {
    // -----------------------------------------------------------------------
    // Step 1 — Email form (initial state)
    // -----------------------------------------------------------------------

    group('Email step', () {
      testWidgets('shows email form with all fields and navigation links', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Forgot Password'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Check For User'), findsOneWidget);
        expect(find.text('Login?'), findsOneWidget);
        expect(find.text('Register?'), findsOneWidget);
      });

      testWidgets('shows validation error when email is empty', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Check For User'));
        await tester.pumpAndSettle();

        expect(find.text('Email is required'), findsAtLeast(1));
      });

      testWidgets('transitions to code form after successful email lookup', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);

        expect(find.text('Code'), findsOneWidget);
        expect(find.text('Verify Code'), findsOneWidget);
        // Email form is gone
        expect(find.text('Check For User'), findsNothing);
      });
    });

    // -----------------------------------------------------------------------
    // Step 2 — Code verification form
    // -----------------------------------------------------------------------

    group('Code verification step', () {
      testWidgets('shows code form with all fields and navigation links', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);

        expect(find.text('Code'), findsOneWidget);
        expect(find.text('Verify Code'), findsOneWidget);
        expect(find.text('Login?'), findsOneWidget);
        expect(find.text('Register?'), findsOneWidget);
      });

      testWidgets('shows validation error when code is empty', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);

        await tester.tap(find.text('Verify Code'));
        await tester.pumpAndSettle();

        expect(find.text('Code is required'), findsAtLeast(1));
      });

      testWidgets(
        'transitions to reset form after successful code verification',
        (
          tester,
        ) async {
          await tester.pumpWidget(
            _buildTestApp(
              notifierFactory: () => _SuccessForgotPasswordNotifier(),
            ),
          );
          await tester.pumpAndSettle();

          await _completeEmailStep(tester);
          await _completeCodeStep(tester);

          expect(find.text('Password'), findsOneWidget);
          expect(find.text('Confirm Password'), findsOneWidget);
          expect(find.text('Reset'), findsOneWidget);
          // Code form is gone
          expect(find.text('Verify Code'), findsNothing);
        },
      );
    });

    // -----------------------------------------------------------------------
    // Step 3 — Reset password form
    // -----------------------------------------------------------------------

    group('Reset password step', () {
      testWidgets('shows reset form with all fields and navigation links', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);
        await _completeCodeStep(tester);

        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Confirm Password'), findsOneWidget);
        expect(find.text('Reset'), findsOneWidget);
        expect(find.text('Login?'), findsOneWidget);
        expect(find.text('Register?'), findsOneWidget);
      });

      testWidgets('shows validation errors when password fields are empty', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);
        await _completeCodeStep(tester);

        await tester.tap(find.text('Reset'));
        await tester.pumpAndSettle();

        expect(find.text('Password is required'), findsOneWidget);
        expect(find.text('Confirm password is required'), findsOneWidget);
      });

      testWidgets('shows validation error when passwords do not match', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);
        await _completeCodeStep(tester);

        await tester.enterText(find.byType(TextFormField).at(0), 'password123');
        await tester.enterText(
          find.byType(TextFormField).at(1),
          'differentpassword',
        );
        await tester.tap(find.text('Reset'));
        await tester.pumpAndSettle();

        expect(find.text('Passwords do not match'), findsOneWidget);
      });

      testWidgets('shows error banner when resetPassword API fails', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _ResetPasswordFailureNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);
        await _completeCodeStep(tester);

        await tester.enterText(find.byType(TextFormField).at(0), 'password123');
        await tester.enterText(find.byType(TextFormField).at(1), 'password123');
        await tester.tap(find.text('Reset'));
        await tester.pumpAndSettle();

        expect(
          find.text('There was an error resetting the password'),
          findsOneWidget,
        );
        // Remains on the reset form
        expect(find.text('Reset'), findsOneWidget);
      });

      testWidgets('navigates to LoginView after successful password reset', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);
        await _completeCodeStep(tester);

        await tester.enterText(find.byType(TextFormField).at(0), 'newpass123');
        await tester.enterText(find.byType(TextFormField).at(1), 'newpass123');
        await tester.tap(find.text('Reset'));
        await tester.pumpAndSettle();

        // LoginView shows 'User Login' as its heading
        expect(find.text('User Login'), findsOneWidget);
      });
    });

    // -----------------------------------------------------------------------
    // Navigation links available on every step
    // -----------------------------------------------------------------------

    group('Navigation links', () {
      testWidgets('Login? link navigates to LoginView from email step', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Login?'));
        await tester.pumpAndSettle();

        expect(find.text('User Login'), findsOneWidget);
      });

      testWidgets('Login? link navigates to LoginView from code step', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);

        await tester.tap(find.text('Login?'));
        await tester.pumpAndSettle();

        expect(find.text('User Login'), findsOneWidget);
      });

      testWidgets('Login? link navigates to LoginView from reset step', (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestApp(
            notifierFactory: () => _SuccessForgotPasswordNotifier(),
          ),
        );
        await tester.pumpAndSettle();

        await _completeEmailStep(tester);
        await _completeCodeStep(tester);

        await tester.tap(find.text('Login?'));
        await tester.pumpAndSettle();

        expect(find.text('User Login'), findsOneWidget);
      });
    });
  });
}
