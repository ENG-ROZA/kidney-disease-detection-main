import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:graduation_project/widgets/shimmer_effects.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graduation_project/models/user_review.dart' as UserReview;
import 'package:graduation_project/modules/screens/doctors/review/reviews_screen.dart';
import 'package:graduation_project/shared/utils/dialogs.dart';

Widget buildDoctorDetailsWidget(
    {required String doctorId,
    required bool isSubmittingReview,
    required String doctorImage,
    required String doctorNumber,
    required BuildContext context,
    required String doctorName,
    required int experienceNumber,
    required String doctorDescription,
    required Widget mapWidget,
    required double doctorRate,
    required Future<UserReview.UserReviewModel>? reviewsFuture,
    required GlobalKey<FormState> reviewFormKey,
    required TextEditingController reviewController,
    required Function(BuildContext) send,
    required double currentUserRating,
    required Function(double) onRatingChanged,
    required Future<UserModel>? userDataFuture,
    required String doctorAddress}) {
  return SafeArea(

    child: LayoutBuilder(

      builder: (context, constraints) {
        
        return SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Image.network(
                      doctorImage,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 14,
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 600,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      doctorName,
                      style: GoogleFonts.merriweather(
                        color: const Color(0xFF2F79E8),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        final whatsappUrl = "https://wa.me/2$doctorNumber";
    
                        if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                          await launchUrl(Uri.parse(whatsappUrl));
                        } else {
                          showErrorMessage(context,
                              "WhatsApp is not installed on your device");
                        }
                      },
                      child: Container(
                          width: 63,
                          height: 33,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F79E8).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          child: Center(
                            child: Image.asset("assets/images/whatsapp_icon.png"),
                          )),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFCB551)),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "$doctorRate",
                          style: GoogleFonts.montserrat(
                              color: const Color(0xFF333333),
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ]),
                  Text(
                    " ${experienceNumber.toInt()} years of experience ",
                    style: GoogleFonts.crimsonText(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 11.5,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.black.withOpacity(0.6),
                        size: 15,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        doctorAddress,
                        style: GoogleFonts.crimsonText(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    "About Doctor",
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    doctorDescription,
                    style: GoogleFonts.crimsonText(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Location",
                    style: GoogleFonts.crimsonText(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  mapWidget,
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Text(
                        "reviews",
                        style: GoogleFonts.crimsonText(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, UserReviewsScreen.routeName,
                              arguments: doctorId);
                        },
                        child: Text(
                          "Your Review",
                          style: GoogleFonts.crimsonText(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: reviewsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return doctorReviewShimmerEffect();
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('SnapShot Error: ${snapshot.error}'));
                        } else if (snapshot.data?.results == null ||
                            snapshot.data!.results.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/no_review.png",
                                  scale: 12,
                                ),
                                Text(
                                  'There is no reviews for this doctor',
                                  style: GoogleFonts.crimsonText(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          final reviews = snapshot.data!.results;
                          return Expanded(
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                scrollDirection: Axis.horizontal,
                                itemCount: reviews.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF4F9FE),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 0.5,
                                          color: const Color(0xFFCFDEF9)),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    width: 214,
                                    height: 80,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 20.0,
                                              backgroundImage: NetworkImage(
                                                reviews[index]
                                                        .user
                                                        ?.profileImage
                                                        ?.url ??
                                                    "",
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  reviews[index].user?.userName ??
                                                      "",
                                                  style: GoogleFonts.crimsonText(
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                SmoothStarRating(
                                                    allowHalfRating: false,
                                                    rating: reviews[index]
                                                        .rating
                                                        .toDouble(),
                                                    starCount: 5,
                                                    size: 15.0,
                                                    color:
                                                        const Color(0xFFFCB551),
                                                    borderColor:
                                                        const Color(0xFFFCB551),
                                                    spacing: 0.0),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              textDirection: TextDirection.rtl,
                                              reviews[index]
                                                  .createdAt
                                                  .substring(0, 10),
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                  fontSize: 6,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 9,
                                        ),
                                        Text(reviews[index].comment,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.crimsonText(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 250,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: userDataFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return reviewsScreensUserDataShimmerEffect();
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('SnapShot Error: ${snapshot.error}'));
                        }
                        final userData = snapshot.data?.results;
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage: NetworkImage(
                                  userData?.user?.profileImage?.url ?? ""),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(userData?.user?.userName ?? "",
                                style: GoogleFonts.crimsonText(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.8),
                                )),
                          ],
                        );
                      }),
                  const SizedBox(
                    width: 19.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SmoothStarRating(
                              allowHalfRating: false,
                              onRatingChanged: (rating) {
                                onRatingChanged(rating);
                              },
                              starCount: 5,
                              rating: currentUserRating,
                              size: 26.0,
                              color: const Color(0xFFFCB551),
                              borderColor: const Color(0xFFFCB551),
                              spacing: 10,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Form(
                              key: reviewFormKey,
                              child: TextFormField(
                                minLines: 1,
                                maxLines: 3,
                                maxLength: 157,
                                textInputAction: TextInputAction.newline,
                                autofocus: true,
                                style: GoogleFonts.crimsonText(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  suffixIcon: Builder(
                                      builder: (BuildContext iconButtonContext) {
                                    if (isSubmittingReview) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.black.withOpacity(0.8),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return IconButton(
                                        onPressed: () => send(iconButtonContext),
                                        icon: Icon(
                                          Icons.send,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      );
                                    }
                                  }),
                                  filled: true,
                                  fillColor: const Color(0XFFF2F2F2),
                                  focusColor: const Color(0XFFF2F2F2),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 12),
                                  hintText: 'Describe your experience',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none),
                                  errorStyle: GoogleFonts.crimsonText(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'You cannot send an empty review';
                                  }
                                  return null;
                                },
                                controller: reviewController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        );
      },
    ),
  );
}
