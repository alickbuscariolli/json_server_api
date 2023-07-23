import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'utils.dart';

const keyData = 'data';
const keyHost = 'host';
const keyPort = 'port';

const defaultHost = '127.0.0.1';
const defaultPort = '1711';

const res404 = '''
{
  "message": "not found"
}
''';

class JsonServerApi {
  final Map<String, dynamic> config;
  late Map<String, dynamic> database;
  bool initialized = false;
  late HttpServer server;

  JsonServerApi({required this.config});

  getConfig(String prop) {
    return config[prop];
  }

  Future init() async {
    // load database from config path
    if (!config.containsKey(keyData)) {
      return Future.error('Missing key `data` in config');
    }

    var dbPath = config[keyData];
    database = jsonDecode(File(dbPath).readAsStringSync());

    if (!config.containsKey(keyHost)) {
      config[keyHost] = defaultHost;
    }

    if (!config.containsKey(keyPort)) {
      config[keyPort] = defaultPort;
    }

    // set init
    initialized = true;
  }

  Future start() async {
    if (!initialized) {
      throw Exception('server is not initialized');
    }

    server = await HttpServer.bind(
      config[keyHost],
      int.parse(config[keyPort]),
      v6Only: false,
    );

    Log.i('Server is started at http://${config[keyHost]}:${config[keyPort]}');

    await for (var request in server) {
      request.response.headers.contentType =
          ContentType('application', 'json', charset: 'utf-8');
      _requestHandler(request);
    }
  }

  _requestHandler(req) async {
    try {
      var apiPath = req.requestedUri.path;

      if (!database.containsKey(apiPath)) {
        req.response.statusCode = HttpStatus.notFound;
        req.response.write(res404);
      } else {
        req.response.write(jsonEncode(database[apiPath]));
      }

      await req.response.close();
    } catch (e) {
      Log.e('$e');
    }
  }
}
