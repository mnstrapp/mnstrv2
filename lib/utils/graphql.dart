import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

//graphql - helper method that is used to submit any qraphql request (query, mutation) to the server
Future<Map<String, dynamic>> graphql({
  required String url,
  required String query,
  Map<String, dynamic> variables = const {},
  Map<String, String> headers = const {},
}) async {
  final finalHeaders = {'Content-Type': 'application/json', ...headers};
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: finalHeaders,
      body: jsonEncode({
        'query': query,
        'variables': variables,
      }),
    );

    if (response.statusCode == HttpStatus.ok) {
      try {
        return jsonDecode(response.body);
      } catch (e, stackTrace) {
        throw Exception(
          'Failed to parse response: ${response.statusCode}, ${response.body}, $e',
        );
      }
    } else {
      throw Exception(
        'Failed to load data: ${response.statusCode}, ${response.body}',
      );
    }
  } catch (e, stackTrace) {
    throw Exception(
      'Failed to load data: $e $stackTrace',
    );
  }
}
