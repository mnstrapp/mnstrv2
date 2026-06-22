enum Env {
  local,
  development,
  production;

  static Env fromEnvironment() {
    final env = String.fromEnvironment(
      'ENV',
      defaultValue: 'local',
    );
    return Env.values.firstWhere(
      (e) => e.name == env,
      orElse: () => Env.local,
    );
  }
}

final Env env = Env.fromEnvironment();
