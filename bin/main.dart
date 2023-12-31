import 'package:json_server_api/src/json_server_api.dart';
import 'package:json_server_api/src/utils.dart';
import 'dart:io';
import 'package:args/args.dart';

main(List<String> arguments) async {
  exitCode = 0;

  ArgResults results = parseArgs(arguments);

  final Map<String, String> config = {};
  config['data'] = results['data'];
  config['host'] = results['host'];
  config['port'] = results['port'];

  validateInput(config);

  try {
    final server = JsonServerApi(config: config);
    await server.init();
    await server.start();
  } catch (e) {
    Log.e('$e\n');
    exit(1);
  }
}

ArgResults parseArgs(List<String> args) {
  final parser = ArgParser()
    ..addOption('data', abbr: 'd')
    ..addOption('host', abbr: 'h', defaultsTo: '127.0.0.1')
    ..addOption('port', abbr: 'p', defaultsTo: '1711');
  parser.addFlag('help', negatable: false);

  ArgResults argResults;
  try {
    argResults = parser.parse(args);
  } catch (e) {
    Log.e('invalid input arguments.');
    exit(1);
  }

  // check if 'help'
  if (argResults['help']) {
    printHelp();
    exit(0);
  }

  // validate required arguments
  if (argResults['data'] == null) {
    Log.e('option --data is missing.\n');
    printHelp();
    exit(1);
  }

  return argResults;
}

validateInput(Map<String, String> input) {
  File path = File(input['data'] as String);
  if (!path.existsSync()) {
    Log.e('file does not exist, ${input['data']}\n');
    exit(1);
  }
}

printHelp() {
  var help =
      '''
Launch a JSON API server from a source.
 
Usage: jserver --data <json_file>
  , --help            Print this usage information.
-d, --data            Path to JSON file. Required.
-h, --host            Server address. Default: 127.0.0.1
-p, --port            Specify port to use. Default: 1711

Example:
  \$ jserver --data ~/server/api.json
  \$ jserver -d ~/api.json -h 127.0.0.1 -p 9999
''';
  stdout.write(help);
}
