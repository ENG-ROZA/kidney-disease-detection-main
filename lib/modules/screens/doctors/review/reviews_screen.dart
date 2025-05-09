// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/models/get_my_review.dart' hide Image;
import 'package:graduation_project/modules/screens/doctors/review/edit_review.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/shared/utils/dialogs.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class UserReviewsScreen extends StatefulWidget {
  static const String routeName = "UserReviews";

  const UserReviewsScreen({super.key});

  @override
  State<UserReviewsScreen> createState() => _UserReviewsScreenState();
}

class _UserReviewsScreenState extends State<UserReviewsScreen> {
  late Future<GetMyReview> _myReviewFuture;

  @override
  void didChangeDependencies() {
    String token = CachedData.getFromCache("token");
    String doctorId = ModalRoute.of(context)?.settings.arguments as String;
    debugPrint('Doctor ID being passed to API: $doctorId');
    _myReviewFuture = ApiManager.getMyReviewForDoctor(token, doctorId);
    //clearReview(context, doctorId);
    super.didChangeDependencies();
  }

  void clearReview(BuildContext context, String reviewId) async {
    String token = CachedData.getFromCache("token");

    Response? response = await ApiManager.deleteReview(
      context: context,
      token: token,
      doctorId: reviewId,
    );

    if (response != null && response.data["success"] == true) {
      showSuccessMessage(context, "Review deleted successfully");

      setState(() {
        _myReviewFuture = ApiManager.getMyReviewForDoctor(token, reviewId);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        title: Text(
          "Your Review",
          style: GoogleFonts.merriweather(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _myReviewFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeCap: StrokeCap.round,
                strokeWidth: 6,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Error: ${snapshot.error}'),
            ));
          }

          final myReview = snapshot.data?.review;
          final reviews = snapshot.data?.review;
          if (myReview == null) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No reviews',
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You have not reviewed this doctor yet',
                    style: GoogleFonts.merriweather(
                      color: const Color(0xFF606770),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Image.asset(
                    "assets/images/no_review.png",
                    scale: 4,
                  ),
                ],
              ),
            ));
          }
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(14),
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F9FE),
                  border: Border.all(width: 1, color: const Color(0xFFCFDEF9)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.network(
                            myReview.user?.profileImage?.url.toString() ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myReview.user?.userName.toString() ?? "",
                              style: GoogleFonts.crimsonText(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SmoothStarRating(
                                rating: myReview.doctor!.avgRating.toDouble(),
                                starCount: 5,
                                size: 15.0,
                                color: const Color(0xFFFCB551),
                                borderColor: const Color(0xFFFCB551),
                                spacing: 0.0),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          myReview.createdAt.toString().substring(0, 10),
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      myReview.comment.toString(),
                      style: GoogleFonts.crimsonText(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          myReview.doctor!.name.toString(),
                          style: GoogleFonts.merriweather(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2F79E8),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            warningDialog(
                              context,
                              "Are you sure you want to delete",
                              "Yes",
                              () {
                                clearReview(
                                    context, reviews?.id.toString() ?? "");
                  
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Color(0xFFFF3B30),
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
