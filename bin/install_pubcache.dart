import 'dart:io';

void main() {
  print('Installing pubcache...');
  try {
    final home = Platform.environment['HOME'] ?? '';
    final shell = (Platform.environment['SHELL'] ?? '').split('/').last;
    final pubcache = '\$HOME/.pub-cache/bin';
    final newPath = '$pubcache:\$PATH';
    final shellPath = File('$home/.${shell}rc');
    final shellContent = shellPath.readAsStringSync();
    final installed = shellContent.contains(pubcache);
    if (installed) {
      print('Pubcache already installed');
      return;
    }
    final newShellContent =
        '''
$shellContent
# dart add .pub-cache to PATH
export PATH=$newPath
''';
    shellPath.writeAsStringSync(newShellContent);
    print('Pubcache installed');
  } catch (e) {
    print('Error installing pubcache: $e');
  }
}
