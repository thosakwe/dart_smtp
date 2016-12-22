import 'package:charcode/charcode.dart';
import 'package:string_scanner/string_scanner.dart';
import 'exception.dart';
final RegExp _protocolUnit = new RegExp(r'()');

class MailObject {
  final Envelope envelope;

  MailObject(this.envelope);

  factory MailObject.parse(String packet) {
    List<ProtocolUnit> protocolUnits = [];
    var scanner = new StringScanner(packet.trim());

    if (protocolUnits.isEmpty) throw new SmtpException.malformed();

    return new MailObject(new Envelope(protocolUnits: protocolUnits));
  }
}

class Envelope {
  final List<ProtocolUnit> protocolUnits = [];

  Envelope({List<ProtocolUnit> protocolUnits: const []}) {
    if (protocolUnits != null) this.protocolUnits.addAll(protocolUnits);
  }
}

class ProtocolUnit {
  final String name, value;

  ProtocolUnit({this.name, this.value});

  @override
  String toString() => '$name: $value';
}
