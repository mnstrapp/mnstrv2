import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  final file = File('.env.yaml');
  final yaml = loadYaml(file.readAsStringSync());
  final outputFile = File('lib/config/env.dart');
  outputFile.writeAsStringSync('''
  // Environment configuration
  ''');
}
