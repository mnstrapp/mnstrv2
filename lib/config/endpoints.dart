const String apiHost = String.fromEnvironment(
  'API_HOST',
  defaultValue: 'https://api.mnstrapp.com',
);
const String baseUrl = '$apiHost/graphql';
const String wsUrl = '$apiHost/ws';
