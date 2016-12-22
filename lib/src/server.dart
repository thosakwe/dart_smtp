import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'protocol.dart';

class SmtpServer {
  ServerSocket _socket;

  final StreamController<Socket> _onConnect = new StreamController<Socket>();
  final StreamController<Socket> _onDisonnect = new StreamController<Socket>();

  /// Fired whenever a new client connects.
  Stream<Socket> get onConnect => _onConnect.stream;

  /// Fired whenever a client disconnects.
  Stream<Socket> get onDisonnect => _onDisonnect.stream;

  /// The encoding to expect incoming messages in.
  ///
  /// Default: `UTF8`
  final Encoding encoding;

  /// The [ServerSocket] currently accepting requests.
  ServerSocket get socket => _socket;

  /// Sent to users on connection.
  final String welcomeMessage;

  SmtpServer({this.encoding: UTF8, this.welcomeMessage: 'Hello!'});

  /// Starts listening for new requests.
  Future<ServerSocket> listen(host, [int port = 25]) async {
    var address =
        host is InternetAddress ? host : await InternetAddress.lookup(host);
    var socket = await ServerSocket.bind(address, port);
    return _socket = socket..listen(handleClient);
  }

  /// Closes the server by closing its underlying [socket].
  Future close() async {
    await _socket.close();
  }

  /// Handles a client connection.
  Future handleClient(Socket socket) async {
    socket.writeln('220 $welcomeMessage');

    socket.transform(encoding.decoder).listen((str) {
      print('Packet: $str');
    });
  }
}
