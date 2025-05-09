import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/screens/scan/scan_details.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/shared/utils/dialogs.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:graduation_project/widgets/scan_animation.dart';
import 'package:graduation_project/widgets/welcome/scan_welcome.dart';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  static const String routeName = "ScanScreen";

  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool showOverlay = true;
  void hideOverlay() {
    setState(() {
      showOverlay = false;
    });
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null && mounted) {
      String token = CachedData.getFromCache("token");

      progressDialog(context);

      try {
        final response = await ApiManager.postScan(
          token: token,
          imageFile: image,
          context: context,
        );

        if (mounted) Navigator.pop(context);

        if (response != null && response.data?["success"] == true && mounted) {
          final scanId = response.data?["results"]?["_id"];
          if (scanId != null) {
            showSuccessMessage(context, "Scan uploaded successfully");

            setState(() {});
          } else {
            showError(context,
                "Upload successful, but couldn't retrieve scan details.");
          }
        }
      } catch (e) {
        if (mounted) Navigator.pop(context);

        if (mounted) {
          showError(context, "An unexpected error occurred: ${e.toString()}");
        }
      }
    }
  }

  Widget _buildScanButton({
    required IconData buttonIcon,
    required Color buttonColor,
    required Color iconColor,
    required String textButton,
  }) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: buttonColor,
          radius: 30,
          child: Icon(
            buttonIcon,
            color: iconColor,
            size: 26,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(textButton,
            style: GoogleFonts.crimsonText(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.8)))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String token = CachedData.getFromCache("token");
    return Stack(children: [
      Scaffold(
        backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
             surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: showOverlay
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Your kidney scan must be a CT scan",
                      style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _pickAndUploadImage(ImageSource.gallery),
                          child: _buildScanButton(
                            buttonColor: const Color(0xFFD0EDFB),
                            buttonIcon: Icons.upload_file_rounded,
                            iconColor: const Color(0xFF2DC0FF),
                            textButton: "Upload file",
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: () => _pickAndUploadImage(ImageSource.gallery),
                          child: _buildScanButton(
                            buttonColor: const Color(0xFFF2F2FE),
                            buttonIcon: Icons.photo_rounded,
                            iconColor: const Color(0xFF5A6CF3),
                            textButton: "Upload image",
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: () => _pickAndUploadImage(ImageSource.camera),
                          child: _buildScanButton(
                            buttonColor: const Color(0xFFFFF1F1),
                            buttonIcon: Icons.camera_alt,
                            iconColor: const Color(0xFFF08F5F),
                            textButton: "Take photo",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Your recent scans",
                        style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FutureBuilder(
                      future: ApiManager.getScanResultsHistory(token),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              heightFactor: 14,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                                strokeCap: StrokeCap.round,
                                strokeWidth: 6,
                              ));
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        final scanResult = snapshot.data?.results ?? [];
                        final recentScanResult = scanResult.take(6).toList();
                        if (scanResult.isEmpty) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Image.asset(
                                "assets/images/empty_scan.png",
                                scale: 4,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "No recent scans yet",
                                style: GoogleFonts.merriweather(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        }
                        return Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   ScanDetails.routeName,
                                //   arguments: recentScanResult[index].scanId,
                                // );
                              },
                              child: buildRecentScanWidget(
                                context,
                                dateOfResult: recentScanResult[index]
                                    .createdAt
                                    .toString(),
                                scanResultImage:
                                    recentScanResult[index].scanFile?.url ?? "",
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            itemCount: recentScanResult.length,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
      if (showOverlay)
        Positioned.fill(
          child: OpacityWelcomScreen(onClose: hideOverlay),
        ),
    ]);
  }

  Widget buildRecentScanWidget(BuildContext context,
      {required String scanResultImage,
      required String dateOfResult,
      String? localImagePath,
      bool uploading = false}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            color: const Color(0xFFFCFCFC),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: localImagePath != null && localImagePath.isNotEmpty
                          ? Image.asset(
                              localImagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            )
                          : scanResultImage.isNotEmpty
                              ? Image.network(
                                  scanResultImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                )
                              : const Icon(Icons.image),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scan result ${dateOfResult.substring(0, 10)}",
                        style: GoogleFonts.crimsonText(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        dateOfResult.substring(0, 10),
                        style: GoogleFonts.crimsonText(
                          color: const Color(0xFFADADAD),
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
