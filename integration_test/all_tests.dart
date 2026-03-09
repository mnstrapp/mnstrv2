// Single entry point for all integration tests.
//
// Flutter launches and keeps the app alive for the duration of a single test
// file. Running tests via the directory (`flutter test integration_test/`)
// causes the runner to start a brand-new app process for every file, which
// fails on desktop because the previous process hasn't fully torn down yet.
//
// This file calls every suite's main() in sequence so the entire test run
// executes inside one app session — no restarts between suites.
//
// Usage:
//   flutter test integration_test/all_tests.dart --device-id=linux

import 'package:integration_test/integration_test.dart';

import 'registration_test.dart' as registration;
import 'login_logout_test.dart' as login_logout;
import 'forgot_password_test.dart' as forgot_password;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  registration.main();
  login_logout.main();
  forgot_password.main();
}
