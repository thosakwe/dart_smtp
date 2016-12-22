class SmtpException implements Exception {
  final String message;

  SmtpException(this.message);

  factory SmtpException.malformed() => new SmtpException('Malformed packet.');

  @override
  String toString() => 'SMTP exception: $message';
}
