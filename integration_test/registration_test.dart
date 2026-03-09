import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mnstrv2/auth/register.dart';
import 'package:mnstrv2/models/user.dart';
import 'package:mnstrv2/providers/session_users.dart';
import 'package:mnstrv2/theme.dart';

// ---------------------------------------------------------------------------
// Mock notifiers — each overrides only the methods exercised by RegisterView
// so tests never hit the network.
// ---------------------------------------------------------------------------

class _SuccessSessionUserNotifier extends SessionUserNotifier {
  @override
  Future<String?> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    state = User(
      id: 'test-user-id',
      email: email,
      displayName: displayName,
      experienceLevel: 1,
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
  }) async =>
      null;
}

class _RegisterFailureNotifier extends SessionUserNotifier {
  @override
  Future<String?> register({
    required String email,
    required String password,
    required String displayName,
  }) async =>
      'There was an error registering the user';
}

class _VerifyFailureNotifier extends SessionUserNotifier {
  @override
  Future<String?> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    state = User(
      id: 'test-user-id',
      email: email,
      displayName: displayName,
    );
    return null;
  }

  @override
  Future<String?> verifyEmail({
    required String id,
    required String code,
  }) async =>
      'There was an error verifying the email';
}

// ---------------------------------------------------------------------------
// Test harness
// ---------------------------------------------------------------------------

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

/// Fills the registration form fields in order:
///   0 – Display Name, 1 – Email, 2 – Password, 3 – Confirm Password
Future<void> _fillRegistrationForm(
  WidgetTester tester, {
  String displayName = 'Test User',
  String email = 'test@example.com',
  String password = 'password123',
  String? confirmPassword,
}) async {
  await tester.enterText(
    find.byType(TextFormField).at(0),
    displayName,
  );
  await tester.enterText(
    find.byType(TextFormField).at(1),
    email,
  );
  await tester.enterText(
    find.byType(TextFormField).at(2),
    password,
  );
  await tester.enterText(
    find.byType(TextFormField).at(3),
    confirmPassword ?? password,
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Registration', () {
    // -----------------------------------------------------------------------
    // Form rendering
    // -----------------------------------------------------------------------

    testWidgets('shows all required fields and navigation links', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const RegisterView(),
          overrides: [
            sessionUserProvider.overrideWith(
              () => _SuccessSessionUserNotifier(),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Registration'), findsOneWidget);
      // Input field labels
      expect(find.text('Display Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      // Action buttons / links
      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Login?'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Form validation
    // -----------------------------------------------------------------------

    testWidgets('shows required-field errors when submitted empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const RegisterView(),
          overrides: [
            sessionUserProvider.overrideWith(
              () => _SuccessSessionUserNotifier(),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Display name is required'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
      expect(find.text('Confirm password is required'), findsOneWidget);
    });

    testWidgets('shows error when passwords do not match', (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const RegisterView(),
          overrides: [
            sessionUserProvider.overrideWith(
              () => _SuccessSessionUserNotifier(),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await _fillRegistrationForm(
        tester,
        password: 'password123',
        confirmPassword: 'differentpassword',
      );
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Successful registration → verification step
    // -----------------------------------------------------------------------

    testWidgets(
      'transitions to email verification form after successful registration',
      (tester) async {
        await tester.pumpWidget(
          _buildTestApp(
            home: const RegisterView(),
            overrides: [
              sessionUserProvider.overrideWith(
                () => _SuccessSessionUserNotifier(),
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        await _fillRegistrationForm(tester);
        await tester.tap(find.text('Register'));
        await tester.pumpAndSettle();

        expect(
          find.text(
            'Verification Code sent to email. Please enter it to verify your email.',
          ),
          findsOneWidget,
        );
        expect(find.text('Verification Code'), findsOneWidget);
        expect(find.text('Verify Email'), findsOneWidget);
        // Registration fields should no longer be visible
        expect(find.text('Display Name'), findsNothing);
      },
    );

    // -----------------------------------------------------------------------
    // Registration API failure
    // -----------------------------------------------------------------------

    testWidgets('shows error banner when registration fails', (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const RegisterView(),
          overrides: [
            sessionUserProvider.overrideWith(
              () => _RegisterFailureNotifier(),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await _fillRegistrationForm(tester);
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(
        find.text('There was an error registering the user'),
        findsOneWidget,
      );
      // Should remain on the registration form
      expect(find.text('Display Name'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Successful verification → login navigation
    // -----------------------------------------------------------------------

    testWidgets(
      'navigates to Login after successful email verification',
      (tester) async {
        await tester.pumpWidget(
          _buildTestApp(
            home: const RegisterView(),
            overrides: [
              sessionUserProvider.overrideWith(
                () => _SuccessSessionUserNotifier(),
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        // Complete registration
        await _fillRegistrationForm(tester);
        await tester.tap(find.text('Register'));
        await tester.pumpAndSettle();

        // Enter verification code and submit
        await tester.enterText(find.byType(TextFormField).first, '123456');
        await tester.tap(find.text('Verify Email'));
        await tester.pumpAndSettle();

        // LoginView shows 'User Login' as its heading
        expect(find.text('User Login'), findsOneWidget);
      },
    );

    // -----------------------------------------------------------------------
    // Verification API failure
    // -----------------------------------------------------------------------

    testWidgets('shows error banner when email verification fails', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestApp(
          home: const RegisterView(),
          overrides: [
            sessionUserProvider.overrideWith(
              () => _VerifyFailureNotifier(),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // Complete registration (succeeds via mock)
      await _fillRegistrationForm(tester);
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      // Submit a wrong verification code
      await tester.enterText(find.byType(TextFormField).first, 'badcode');
      await tester.tap(find.text('Verify Email'));
      await tester.pumpAndSettle();

      expect(
        find.text('There was an error verifying the email'),
        findsOneWidget,
      );
      // Should remain on the verification form
      expect(find.text('Verify Email'), findsOneWidget);
    });
  });
}
