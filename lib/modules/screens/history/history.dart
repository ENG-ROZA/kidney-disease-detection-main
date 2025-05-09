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
            fontSize: 20,
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/empty_scan.png",
                      scale: 5,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      'There is no history yet',
                      style: GoogleFonts.crimsonText(
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
                // Navigator.pushNamed(
                //   context,
                //   ScanDetails.routeName,
                //   arguments: scanResult[index].scanId,
                // );
              },
              child: buildResultsHistoryWidget(
                context,
                dateOfResult: scanResult[index].createdAt.toString(),
                scanResultImage:
                    scanResult[index].scanFile?.url.toString() ?? "",
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
            itemCount: scanResult.length,
          );
        },
      ),
    );
  }

  Widget buildResultsHistoryWidget(BuildContext context,
      {required String scanResultImage, required String dateOfResult}) {
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
                        child: Image.network(
                          scanResultImage,
                          fit: BoxFit.cover,
                        )),
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
