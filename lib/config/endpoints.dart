const String wsHost = String.fromEnvironment(
  'WS_HOST',
  defaultValue: 'wss://api.mnstrapp.com',
);
const String apiHost = String.fromEnvironment(
  'API_HOST',
  defaultValue: 'https://api.mnstrapp.com',
);
const String baseUrl = '$apiHost/graphql';
const String wsUrl = '$wsHost/ws';
