// import 'dart:html' as html;
// import 'dart:typed_data';

 //!Web-specific implementation for downloading PDF bytes
// void downloadPdfBytes(Uint8List bytes, String fileName) {
//   final blob = html.Blob([bytes], 'application/pdf');
//   final url = html.Url.createObjectUrlFromBlob(blob);
//   final anchor = html.AnchorElement(href: url)
//     ..setAttribute("download", fileName)
//     ..click();
//   html.Url.revokeObjectUrl(url);
// }
