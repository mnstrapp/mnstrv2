const String wsHost = String.fromEnvironment(
  'WS_HOST',
  defaultValue: 'wss://api.mnstrapp.com',
);
const String apiHost = String.fromEnvironment(
  'API_HOST',
  defaultValue: 'api.mnstrapp.com',
);
const int apiPort = int.fromEnvironment(
  'API_PORT',
  defaultValue: 50051,
);
const String baseUrl = apiHost;
const String wsUrl = '$wsHost/ws';
