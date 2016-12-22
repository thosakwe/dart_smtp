import 'dart:io';
import 'package:smtp/smtp.dart';

main() async {
  var server = new SmtpServer(welcomeMessage: 'Hello, SMTP world!');

  var socket = await server.listen(InternetAddress.LOOPBACK_IP_V4, 0);
  print('Listening on smtp://${socket.address.address}:${socket.port}');
}
