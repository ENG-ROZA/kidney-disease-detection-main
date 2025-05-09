import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/screens/scan/scan_details.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    String token = CachedData.getFromCache("token");

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Scan Results History",
          style: GoogleFonts.merriweather(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenHeight * 0.025, // Responsive font size
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: ApiManager.getScanResultsHistory(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
              strokeCap: StrokeCap.round,
              strokeWidth: 6,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final scanResult = snapshot.data?.results ?? [];
          if (scanResult.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/empty_scan.png",
                      fit: BoxFit.contain,
                      height: screenHeight * 0.25,
                      width: screenWidth * 0.5,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      textAlign: TextAlign.center,
                      'There is no history yet',
                      style: GoogleFonts.crimsonText(
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.022,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ScanDetails.routeName,
                  arguments: scanResult[index].scanId,
                );
              },
              child: buildResultsHistoryWidget(
                context,
                scanResultImage:
                    scanResult[index].scanFile?.url.toString() ?? "",
                dateOfResult: scanResult[index].createdAt.toString(),
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: screenHeight * 0.01),
            itemCount: scanResult.length,
          );
        },
      ),
    );
  }

  Widget buildResultsHistoryWidget(
    BuildContext context, {
    required String scanResultImage,
    required String dateOfResult,
    required double screenHeight,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
      child: Card(
        color: const Color(0xFFFCFCFC),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Row(
            children: [
              Container(
                height: screenHeight * 0.08,
                width: screenWidth * 0.18,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    scanResultImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Scan result ${dateOfResult.substring(0, 10)}",
                      style: GoogleFonts.crimsonText(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.016,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      dateOfResult.substring(0, 10),
                      style: GoogleFonts.crimsonText(
                        color: const Color(0xFFADADAD),
                        fontWeight: FontWeight.w400,
                        fontSize: screenHeight * 0.014,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}