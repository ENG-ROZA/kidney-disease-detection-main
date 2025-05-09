import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/models/doctors_model.dart';
import 'package:graduation_project/models/top_rated_doctors.dart';
import 'package:graduation_project/modules/screens/acccount/pages/profile_page.dart';
import 'package:graduation_project/modules/screens/articles/articles_screen.dart';
import 'package:graduation_project/modules/screens/doctors/doctors_details.dart';
import 'package:graduation_project/modules/screens/egfr/egfr.dart';
import 'package:graduation_project/modules/screens/scan/scan_screen.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/widgets/shimmer_effects.dart';
import '../../../widgets/home_component.dart';
import '../doctors/doctors_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    return baseSize *
        (screenWidth / 414); //* 414 is a reference width (iPhone 12 Pro Max)
  }

  late Future<TopRatedDoctors> _doctorsFuture;

  @override
  void initState() {
    _doctorsFuture = ApiManager.getTopRatedDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String token = CachedData.getFromCache("token");
    Widget buildLeadingWidget(BuildContext context,
        {required String userName,
        required String userEmail,
        required String userImage}) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 9,
          bottom: 7,
          left: 5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(userImage,scale: 6),
            ),
            const SizedBox(
              width: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName,
                    style: GoogleFonts.crimsonText(
                        fontWeight: FontWeight.w700,
                        fontSize: getResponsiveFontSize(context, 10),
                        color: Colors.white)),
                Text(userEmail.substring(0, userEmail.indexOf("@")),
                    style: GoogleFonts.crimsonText(
                        fontWeight: FontWeight.w400,
                        fontSize: getResponsiveFontSize(context, 8),
                        color: const Color(0xFFD2D2D2)))
              ],
            )
          ],
        ),
      );
    }

    Widget homeButton() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: MaterialButton(
            elevation: 3.5,
            animationDuration: const Duration(seconds: 2),
            color: const Color(0xFF2F79E8).withOpacity(0.82),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.file_upload,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "Upload Your Kidney Image",
                  style: GoogleFonts.merriweather(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: getResponsiveFontSize(context, 10)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, screenHeight * 0.22),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          shape: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(28),
              bottomLeft: Radius.circular(28),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Renalyze",
            style: GoogleFonts.protestRevolution(
                textStyle: GoogleFonts.protestRevolution(
              textStyle: TextStyle(
                fontSize: getResponsiveFontSize(context, 33),
                fontWeight: FontWeight.normal,
                color: const Color(0xFFFFFFFF).withOpacity(0.62),
              ),
            )),
          ),
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2F79E8),
                    Color(0xFF9AD7F1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(28),
                  bottomLeft: Radius.circular(28),
                )),
            child: Image.asset(
              "assets/images/authlogo.png",
              scale: 2.5,
            ),
          ),
          leading: FutureBuilder(
              future: ApiManager.getUserData(token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return homeUserDataShimmerEffect();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final userData = snapshot.data?.results;
                return InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, ProfilePage.routeName),
                  child: buildLeadingWidget(
                      userImage:
                          userData?.user?.profileImage?.url.toString() ?? "",
                      userName: userData?.user?.userName.toString() ?? "",
                      userEmail: userData?.user?.email.toString() ?? "",
                      context),
                );
              }),
          leadingWidth: screenWidth * 0.3,
          actions: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: IconButton(
                icon: const Icon(
                  Icons.dark_mode_sharp,
                  color: Colors.white,
                  //? For light mode  Icons.brightness_4_outlined,
                  //* For dark mode  Icons.brightness_5_outlined,
                ),
                iconSize: 29,
                onPressed: () {
                  //! Theme Toggle
                },
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.08,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: const Color(0xFF2949C7).withOpacity(0.25),
                    )),
                child: homeButton(),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Sections",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.crimsonText(
                        color: Colors.black,
                        fontSize: getResponsiveFontSize(context, 14),
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: screenHeight * 0.004),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorsScreen()));
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: kidnyResultWidget(
                        containerHeight: screenHeight * 0.12,
                        containerWidth: screenWidth * 0.65,
                        context,
                        containerIcon: "assets/images/home_doctor_icon.png",
                        containerText: Text("Doctors",
                            style: GoogleFonts.merriweather(
                                color: const Color(0xFF2F79E8),
                                fontSize: getResponsiveFontSize(context, 18),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Egfr()));
                        },
                        child: kidnyResultWidget(
                          containerHeight: screenHeight * 0.12,
                          containerWidth: screenWidth * 0.25,
                          context,
                          containerIcon: "assets/images/home_egfr_icon.png",
                          containerText: Text("Egfr",
                              style: GoogleFonts.crimsonText(
                                  color: const Color(0xFF2F79E8),
                                  fontSize: getResponsiveFontSize(context, 12),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //! Navigate To Community .
                      },
                      child: kidnyResultWidget(
                        containerHeight: screenHeight * 0.1,
                        containerWidth: screenWidth * 0.48,
                        context,
                        containerIcon: "assets/images/home_community_icon.png",
                        containerText: Text("Community",
                            style: GoogleFonts.crimsonText(
                                color: const Color(0xFF2F79E8),
                                fontSize: getResponsiveFontSize(context, 12),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArticlesScreen()),
                        );
                      },
                      child: kidnyResultWidget(
                        containerHeight: screenHeight * 0.1,
                        containerWidth: screenWidth * 0.48,
                        context,
                        containerIcon: "assets/images/home_article_icon.png",
                        containerText: Text("articles",
                            style: GoogleFonts.crimsonText(
                                color: const Color(0xFF2F79E8),
                                fontSize: getResponsiveFontSize(context, 12),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  Text("Top Rated Doctors",
                      style: GoogleFonts.crimsonText(
                          color: Colors.black,
                          fontSize: getResponsiveFontSize(context, 14),
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorsScreen(),
                          ));
                    },
                    child: Text("See all",
                        style: GoogleFonts.crimsonText(
                            color: Colors.grey.shade600,
                            fontSize: getResponsiveFontSize(context, 12),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.022),
              FutureBuilder(
                future: _doctorsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return homeDoctorWidgetShimmerEffect(
                        screenHeight, screenWidth);
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final doctors = snapshot.data?.results ?? [];
                  return doctors.isEmpty
                      ? const Center(child: Text('No doctors found'))
                      : SizedBox(
                          height: screenHeight * 0.2,
                          child: Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: screenWidth * 0.002),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: doctors.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DoctorsDetails.routeName,
                                      arguments: doctors[index].id,
                                    );
                                  },
                                  child: doctorhomeWidget(
                                    context,
                                    doctorImage:
                                        doctors[index].image?.url ?? "",
                                    doctorName: doctors[index].name ?? "",
                                    rating:
                                        (doctors[index].avgRating ?? 0).toInt(),
                                    numberOfRating:
                                        doctors[index].avgRating.toString(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
