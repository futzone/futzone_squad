import 'dart:typed_data';
import 'dart:convert';
import 'dart:html' as html;

Future<void> savePng(Uint8List pngBytes, String fileName) async {
  final base64 = base64Encode(pngBytes);
  final blob = html.Blob([pngBytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor =
      html.AnchorElement(href: url)
        ..setAttribute("download", "$fileName.png")
        ..click();
  html.Url.revokeObjectUrl(url);
}
