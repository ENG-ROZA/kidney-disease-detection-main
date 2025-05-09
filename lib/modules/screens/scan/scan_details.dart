// // ignore_for_file: use_build_context_synchronously

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:graduation_project/models/scan_results_details.dart';
// import 'package:graduation_project/modules/screens/doctors/doctors_screen.dart';
// import 'dart:io';
// import 'package:graduation_project/shared/network/local/cached_data.dart';
// import 'package:graduation_project/shared/network/remote/api_manager.dart';
// import 'package:graduation_project/shared/utils/colors.dart';
// import 'package:graduation_project/widgets/message/messages_methods.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:open_file/open_file.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:html' as html;
// import 'package:http/http.dart' as http;

// class ScanDetails extends StatefulWidget {
//   static const String routeName = 'scan_details';
//   const ScanDetails({super.key});

//   @override
//   State<ScanDetails> createState() => _ScanDetailsState();
// }

// class _ScanDetailsState extends State<ScanDetails> {
//   late String scanResultId;
//   late Future<ScanResultDetails> _scanResultDetailsFuture;
//   bool _isDownloading = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     String token = CachedData.getFromCache("token");
//     scanResultId = ModalRoute.of(context)?.settings.arguments as String;
//     _scanResultDetailsFuture =
//         ApiManager.getScanResultsDetails(token, scanResultId);
//   }

//   Widget _buildSectionText(String headText, String text) {
//     return RichText(
//         text: TextSpan(children: [
//       TextSpan(
//         text: "$headText: ",
//         style: GoogleFonts.merriweather(
//             fontSize: 14,
//             fontWeight: FontWeight.w700,
//             color: Colors.black.withOpacity(0.8)),
//       ),
//       TextSpan(
//         text: text,
//         style: GoogleFonts.poppins(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: const Color(0xFF4B5563)),
//       )
//     ]));
//   }

//   Widget _buildResultButton({
//     required String buttonText,
//     required Color backgroundColor,
//     required Color textColor,
//     required double elevation,
//     required double borderRadius,
//     required EdgeInsets padding,
//     required VoidCallback? onPressed,
//   }) {
//     return SizedBox(
//       height: 65,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           foregroundColor: textColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           padding: padding,
//           elevation: elevation,
//         ),
//         child: Text(buttonText,
//             style: GoogleFonts.merriweather(
//               fontSize: 16.0,
//               fontWeight: FontWeight.w700,
//             )),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//            surfaceTintColor: Colors.transparent,
//         scrolledUnderElevation: 0.0,
//         automaticallyImplyLeading: true,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//           ),
//           color: Colors.black,
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body: FutureBuilder(
//           future: _scanResultDetailsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                 strokeCap: StrokeCap.round,
//                 strokeWidth: 6,
//                 color: primaryColor,
//               ));
//             } else if (snapshot.hasError) {
//               return Center(child: Text(snapshot.error.toString()));
//             }
//             final resultDetails = snapshot.data?.result;
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(14.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: Row(children: [
//                         Text(resultDetails?.diagnosis.toString() ?? "",
//                             style: GoogleFonts.merriweather(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w700,
//                                 color: resultDetails?.diagnosis == "Normal"
//                                     ? const Color(0xFF00AB00)
//                                     : (resultDetails?.diagnosis == "Cyst" ||
//                                             resultDetails?.diagnosis ==
//                                                 "Tumor" ||
//                                             resultDetails?.diagnosis == "Stone")
//                                         ? const Color(0xFFFF3B30)
//                                         : const Color(0xFF00AB00))),
//                         const Spacer(),
//                         Text(
//                           "Confidence  ${resultDetails?.confidence.toString() ?? ""}",
//                           style: GoogleFonts.merriweather(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w700,
//                               color: const Color(0xFF263238)),
//                         )
//                       ]),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     _buildSectionText(
//                         "Diagnosis", resultDetails?.diagnosis.toString() ?? ""),
//                     const SizedBox(
//                       height: 26,
//                     ),
//                     _buildSectionText(
//                         "Condition", resultDetails?.condition.toString() ?? ""),
//                     const SizedBox(
//                       height: 26,
//                     ),
//                     _buildSectionText(
//                         "Details", resultDetails?.details.toString() ?? ""),
//                     const SizedBox(
//                       height: 26,
//                     ),
//                     _buildSectionText("Recommendation",
//                         resultDetails?.recommendations.toString() ?? ""),
//                     const SizedBox(
//                       height: 45,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                           ),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           resultDetails?.scanFile?.url.toString() ?? "",
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     _buildResultButton(
//                         buttonText: "Download Full Result",
//                         backgroundColor:
//                             const Color(0xFFDADADA).withOpacity(0.4),
//                         textColor: const Color(0xFF3F3D3D),
//                         elevation: 0.0,
//                         borderRadius: 30,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12.0, horizontal: 24.0),
//                         onPressed: _isDownloading
//                             ? null
//                             : () async {
//                                 final resultDetails = snapshot.data?.result;
//                                 if (resultDetails != null) {
//                                   setState(() {
//                                     _isDownloading = true;
//                                   });
//                                   try {
//                                     await _generateAndSavePdf(resultDetails);
//                                   } catch (e) {
//                                     if (!mounted) return;
//                                     showErrorMessage(context,
//                                         'Failed to generate PDF: ${e.toString()}');
//                                   } finally {
//                                     if (mounted) {
//                                       setState(() {
//                                         _isDownloading = false;
//                                       });
//                                     }
//                                   }
//                                 } else {
//                                   if (!mounted) return;
//                                   showErrorMessage(
//                                       context, 'Result details not available');
//                                 }
//                               }),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     _buildResultButton(
//                         buttonText: "Consult a Specialist Doctor",
//                         backgroundColor: primaryColor,
//                         textColor: Colors.white,
//                         elevation: 0.0,
//                         borderRadius: 30,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         onPressed: () {
//                           Navigator.pushNamed(context, DoctorsScreen.routeName);
//                         }),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }

//   void _showSnackBar(String title, String message, ContentType contentType) {
//     if (!mounted) return;
//     final snackBar = SnackBar(
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//         title: title,
//         message: message,
//         contentType: contentType,
//       ),
//     );

//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }

//   Future<void> _generateAndSavePdf(ScanResult resultDetails) async {
//     final pdf = pw.Document();
//     Uint8List? imageBytes;

//     try {
//       final response = await http.get(Uri.parse(resultDetails.scanFile?.url.toString() ?? ""));
//       if (response.statusCode == 200) {
//         imageBytes = response.bodyBytes;
//       } else {
//         print('Failed to load image: ${response.statusCode}.');
//       }
//     } catch (e) {
//       print('Error loading image: $e');
//     }

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Center(
//                 child: pw.Text('Kidney Scan Diagnosis Report',
//                     style: pw.TextStyle(
//                         fontSize: 24,
//                         fontWeight: pw.FontWeight.bold,
//                         color: PdfColors.blue900)),
//               ),
//               pw.SizedBox(height: 30),
//               pw.Center(
//                 child: pw.Image(
//                   pw.MemoryImage(imageBytes ?? Uint8List(0)),
//                   width: 250,
//                   height: 200,
//                   fit: pw.BoxFit.contain,
//                 ),
//               ),
//               pw.SizedBox(height: 20),
           
//               pw.Text('Diagnosis Result',
//                   style: pw.TextStyle(
//                       fontSize: 18,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.black)),
//               pw.SizedBox(height: 10),
//               pw.Text('Diagnosis: ${resultDetails.diagnosis ?? "N/A"}',
//                   style: const pw.TextStyle(fontSize: 16)),
//               pw.SizedBox(height: 6),
//               pw.Text(
//                   'Confidence: ${resultDetails.confidence?.toString() ?? "N/A"}%',
//                   style: const pw.TextStyle(fontSize: 16)),
//               pw.SizedBox(height: 20),

             
//               pw.Text('Condition Summary',
//                   style: pw.TextStyle(
//                       fontSize: 18,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.black)),
//               pw.SizedBox(height: 10),
//               pw.Text(resultDetails.condition ?? "N/A",
//                   style: const pw.TextStyle(fontSize: 16)),
//               pw.SizedBox(height: 20),

           
//               pw.Text('Detailed Analysis',
//                   style: pw.TextStyle(
//                       fontSize: 18,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.black)),
//               pw.SizedBox(height: 10),
//               pw.Text(resultDetails.details ?? "N/A",
//                   style: const pw.TextStyle(fontSize: 16)),
//               pw.SizedBox(height: 20),

           
//               pw.Text('Medical Recommendations',
//                   style: pw.TextStyle(
//                       fontSize: 18,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.black)),
//               pw.SizedBox(height: 10),
//               pw.Text(resultDetails.recommendations ?? "N/A",
//                   style: const pw.TextStyle(fontSize: 16)),
//               pw.SizedBox(height: 30),

//               pw.Text(
//                 '*This AI-generated report is for informational purposes only and does not replace professional medical advice.*',
//                 style: pw.TextStyle(
//                   fontSize: 12,
//                   fontStyle: pw.FontStyle.italic,
//                   color: PdfColors.red,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     //! Save or Download PDF based on Platform
//     try {
//       final pdfBytes = await pdf.save();

//       final fileName = 'scan_result_${resultDetails.scanId ?? "unknown"}.pdf';

//       if (kIsWeb) {
//         final blob = html.Blob([pdfBytes], 'application/pdf');
//         final url = html.Url.createObjectUrlFromBlob(blob);
//         final anchor = html.AnchorElement(href: url)
//           ..setAttribute("download", fileName)
//           ..click();
//         html.Url.revokeObjectUrl(url);

//         _showSnackBar(
//             'Success', 'PDF download started.', ContentType.success);
//       } else {
//         var status = await Permission.storage.request();
//         if (!status.isGranted) {
//           _showSnackBar(
//               'Permission Denied',
//               'Storage permission is required to save the PDF.',
//               ContentType.failure);
//           return;
//         }

//         //! Get Save Path (Mobile Only)
//         Directory? directory;
//         if (Platform.isAndroid) {
//           directory = await getExternalStorageDirectory();
//         } else if (Platform.isIOS) {
//           directory = await getApplicationDocumentsDirectory();
//         } else {
//           directory = await getApplicationDocumentsDirectory();
//         }

//         if (directory == null) {
//           throw Exception("Could not get directory to save file.");
//         }
//         final path = '${directory.path}/$fileName';
//         final file = File(path);

//         //! Save PDF (Mobile Only)
//         await file.writeAsBytes(pdfBytes);

//         //! Open PDF (Mobile Only)
//         final openResult = await OpenFile.open(path);
//         if (openResult.type != ResultType.done) {
//           _showSnackBar(
//               'Error',
//               'Could not open PDF file: ${openResult.message}',
//               ContentType.failure);
//         } else {
//           _showSnackBar('Success', 'PDF downloaded and opened successfully!',
//               ContentType.success);
//         }
//       }
//     } catch (e) {
//       _showSnackBar('Error', 'Error during PDF process: ${e.toString()}',
//           ContentType.failure);
//     }
//   }
// }
