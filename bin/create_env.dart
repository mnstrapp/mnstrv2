import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  final file = File('.env.yaml');
  final yaml = loadYaml(file.readAsStringSync());
  final outputFile = File('lib/config/env.dart');
  outputFile.writeAsStringSync('''
  const String wiredashApiKey = '${yaml['wiredash']['secret']}';
  const String wiredashProjectId = '${yaml['wiredash']['id']}';
  ''');
}
