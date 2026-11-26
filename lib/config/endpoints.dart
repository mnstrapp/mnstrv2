const String apiHost = String.fromEnvironment(
  'API_HOST',
  defaultValue: 'api.mnstrapp.com',
);
const int apiPort = int.fromEnvironment(
  'API_PORT',
  defaultValue: 50051,
);
const String baseUrl = apiHost;
