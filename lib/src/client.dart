import 'dart:async';
import 'dart:io';
import 'protocol.dart';

class SmtpClient {
  Future<SmtpClient> connect(host, [int port = 25]) async {
    var address = await InternetAddress.lookup(host);
  }
}
