// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/models/doctors_details_model.dart';
import 'package:graduation_project/models/review_model.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/models/user_review.dart' as UserReview;
import 'package:graduation_project/models/user_review.dart';
import 'package:graduation_project/modules/screens/doctors/details_widget.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/map_image.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';

class DoctorsDetails extends StatefulWidget {
  static const String routeName = 'DoctorsDetails';
  const DoctorsDetails({super.key});

  @override
  State<DoctorsDetails> createState() => _DoctorsDetailsState();
}

class _DoctorsDetailsState extends State<DoctorsDetails> {
  late Future<DoctorsDetailsModel> _doctorsDetailsFuture;
  late Future<UserReviewModel> _getAllReviewsFuture;
  List<UserReview.UserReviewModel>? reviews;

  late String doctorId;
  final reviewFormKey = GlobalKey<FormState>();
  bool _isSubmittingReview = false;
  double _currentUserRating = 0.0;

  void _updateRating(double rating) {
    setState(() {
      _currentUserRating = rating;
    });
  }

  final TextEditingController reviewController = TextEditingController();
  Future<UserModel> userDataFuture() {
    String token = CachedData.getFromCache("token");
    return ApiManager.getUserData(token);
  }

  void _addReview(BuildContext context, double rating) async {
    if (!reviewFormKey.currentState!.validate()) return;

    if (_isSubmittingReview) return;

    if (rating == 0) {
      showErrorMessage(context, "Please add your rating.");
      return;
    }

    final String review = reviewController.text.trim();
    String token = CachedData.getFromCache("token");

    if (token.isEmpty) {
      showErrorMessage(context, "Authentication error. Please log in again.");

      return;
    }

    setState(() {
      _isSubmittingReview = true;
    });

    try {
      final response = await ApiManager.addDoctorReview(
        token: token,
        comment: review,
        rating: rating,
        doctorId: doctorId,
        context: context,
      );

      if (response != null && response.data?["success"] == true) {
        //!added
        showSuccessMessage(context, "Review added successfully!");
        reviewController.clear();
        _updateRating(0);

        setState(() {
          _getAllReviewsFuture = ApiManager.getAllReviews(doctorId);
        });
      } else {
        showErrorMessage(
            context,
            response?.data?["message"] ??
                "your review is already exist");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An unexpected error occurred: $e"),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isSubmittingReview = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    doctorId = ModalRoute.of(context)?.settings.arguments as String;
    _doctorsDetailsFuture = ApiManager.getDoctorsDetails(doctorId);
    _getAllReviewsFuture = ApiManager.getAllReviews(doctorId);
    super.didChangeDependencies();
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
          "Doctor's Information",
          style: GoogleFonts.merriweather(
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: _doctorsDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
              strokeCap: StrokeCap.round,
              strokeWidth: 6,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data?.doctor == null) {
            return const Center(child: Text('Doctor not found'));
          }
          final doctor = snapshot.data?.doctor;
          return buildDoctorDetailsWidget(
            userDataFuture: userDataFuture(),
            isSubmittingReview: _isSubmittingReview,
            doctorId: doctorId,
            context: context,
            doctorNumber: doctor?.phoneNumber ?? "",
            reviewFormKey: reviewFormKey,
            reviewController: reviewController,
            reviewsFuture: _getAllReviewsFuture,
            mapWidget: MapImage(
              latitude: doctor?.mapLocation?.lat ?? "",
              longitude: doctor?.mapLocation?.lng ?? "",
              apiKey: "AIzaSyB2U6ZXe-ombZJIig1q9kk6tYh3yjZ5pu8",
            ),
            doctorAddress: doctor?.address ?? "",
            doctorDescription: doctor?.aboutDoctor ?? "",
            doctorImage: doctor?.image?.url ?? "",
            doctorName: doctor?.name ?? "",
            experienceNumber: doctor?.experience ?? 0,
            doctorRate: doctor?.avgRating ?? 0,
            currentUserRating: _currentUserRating,
            onRatingChanged: _updateRating,
            send: (context) => _addReview(context, _currentUserRating),
          );
        },
      ),
    );
  }
}
