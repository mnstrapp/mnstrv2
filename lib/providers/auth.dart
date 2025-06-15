import 'package:riverpod/riverpod.dart';
import '../models/auth.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, Auth?>(
  () => AuthNotifier(),
);

class AuthNotifier extends AsyncNotifier<Auth?> {
  @override
  Future<Auth?> build() async {
    return null;
  }
}
