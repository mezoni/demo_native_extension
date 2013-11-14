// This script executed automatically by PackageInstaller
import 'dart:io';
import 'package:path/path.dart' as pathos;
import 'package:demo_native_extension/src/build.dart';

void main(List<String> args) {
  new Program().run(args);
}

class Program {
  Map _options;

  void run(List<String> args) {
    _process();
  }

  void _process() {
    var file = new File(_getConfigFileName());
    if(!file.existsSync()) {
      _install();
    }
  }

  bool _checkAlreadyInstalled() {
    return new File(_getConfigFileName()).existsSync();
  }

  void _install() {
    if(_checkAlreadyInstalled()) {
      return;
    }

    var path = Platform.script.path;
    path = pathos.dirname(path);
    path = pathos.dirname(path);
    var project = new Project();
    if(project.run(path) == 0) {
      _markAsAlreadyInstalled();
    } else {
      exitCode = -1;
    }
  }

  String _getConfigFileName() {
    var script = Platform.script.path;
    var path = pathos.dirname(script);
    return pathos.join(path, "installed.txt");
  }

  void _markAsAlreadyInstalled() {
    new File(_getConfigFileName()).writeAsStringSync("Installed at ${new DateTime.now()}");
  }
}
