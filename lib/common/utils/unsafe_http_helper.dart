// unsafe_http_helper.dart
import 'dart:io';
import 'package:http/io_client.dart';

IOClient getUnsafeIOClient() {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  return IOClient(httpClient);
}