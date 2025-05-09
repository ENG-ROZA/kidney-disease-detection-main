import 'dart:typed_data'; // Import for Uint8List
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/article_details.dart';
import 'package:graduation_project/models/articles_model.dart';
import 'package:graduation_project/models/doctors_details_model.dart';
import 'package:graduation_project/models/doctors_model.dart';
import 'package:graduation_project/models/get_my_review.dart';
import 'package:graduation_project/models/scan_results_details.dart';

import 'package:graduation_project/models/scan_results_model.dart';
import 'package:graduation_project/models/top_rated_doctors.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/models/user_review.dart';
import 'package:graduation_project/shared/utils/constants.dart';
import 'package:graduation_project/shared/utils/dialogs.dart';
import 'package:dio/dio.dart' as dio;
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ApiManager {
  static final Dio _dio = Dio(
    BaseOptions(
      headers: {"Content-Type": "application/json"},
    ),
  );

  //! Authentication methods
  static Future<Response?> login(
      String email, String password, BuildContext context) async {
    try {
      final response = await _dio.post(
        "${Constants.baseUrl}/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      return response; // Return the entire response
    } on DioException catch (e) {
      final errorMessage = e.response?.data?["message"] ??
          e.message ??
          "An unknown error occurred";
      showError(context, errorMessage);
      return null;
    }
  }

  static Future<Response?> signUp(String email, String password,
      String confirmPassword, String userName, BuildContext context) async {
    try {
      final response = await _dio.post(
        "${Constants.baseUrl}/auth/register",
        data: {
          "userName": userName,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );
      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "Signup failed",
        );
      }
      return response;
    } on DioException catch (e) {
      print(e.message);
      final errorMessage = e.response?.data?["message"] ??
          e.message ??
          "An unknown error occurred";
      showError(context, errorMessage);
      return null;
    }
  }

  static Future<Response?> verifyEmail(
      String email, BuildContext context) async {
    try {
      final response =
          await _dio.patch("${Constants.baseUrl}/auth/forget_code", data: {
        "email": email,
      });
      // "${Constants.baseUrl}/auth/forget_code",
      // data: {
      //   "email": email,

      // },
      // options: Options(
      //   headers: {"Content-Type": "application/json"},
      // ),

      return response; // Return the entire response
    } on DioException catch (e) {
      // final errorMessage = e.response?.data?["message"] ??
      //     e.message ??
      //     "An unknown error occurred";
      // print(e.message);
      String errorMessage = "Network error occurred. Please try again.";

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = "Request timed out. Check your internet connection.";
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              e.response?.data?["message"] ?? "Server error occurred";
          break;
        default:
          errorMessage = "Network error: ${e.message}";
      }
      showError(context, errorMessage);
      return null;
    }
  }

  static Future<Response?> otpCode(
      String email, String code, BuildContext context) async {
    try {
      final response = await _dio.post(
        "${Constants.baseUrl}/auth/verify_code",
        data: {
          "email": email,
          "forgetCode": code,
        },
      );
      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "OTP verification failed",
        );
      }

      return response;
    } on DioException catch (e) {
      String errorMessage = "Network error occurred. Please try again.";

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = "Request timed out. Check your internet connection.";
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              e.response?.data?["message"] ?? "Server error occurred";
          break;
        default:
          errorMessage = "Network error: ${e.message}";
      }
      showError(context, errorMessage);
      return null;
    }
  }

  static Future<Response?> resetAndUpdateOldPassword(String email,
      String password, String confirmPassword, BuildContext context) async {
    try {
      final response = await _dio.patch(
        "${Constants.baseUrl}/auth/reset_password",
        data: {
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );
      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "OTP verification failed",
        );
      }
      return response;
    } on DioException catch (e) {
      String errorMessage = "Network error occurred. Please try again.";

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = "Request timed out. Check your internet connection.";
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              e.response?.data?["message"] ?? "Server error occurred";
          break;
        default:
          errorMessage = "Network error: ${e.message}";
      }
      showError(context, errorMessage);
      return null;
    }
  }

  //? Articles methods
  static Future<ArticlesResponse> getArticles() async {
    try {
      final response = await _dio.get("${Constants.baseUrl}/article/all",
          queryParameters: {"status": "published"});
      if (response.statusCode == 200) {
        // Parse the response using our model
        return ArticlesResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load articles: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<ArticleDetailsResponse> getArticlesDetails(
      String articleId) async {
    try {
      final response = await _dio.get(
        "${Constants.baseUrl}/article/$articleId",
      );
      if (response.statusCode == 200) {
        return ArticleDetailsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load articles: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<ArticlesResponse> getArticlesSearch(String query) async {
    try {
      final response = await _dio.get(
        "${Constants.baseUrl}/article/all",
        queryParameters: {
          "query": query,
        },
      );

      if (response.statusCode == 200) {
        return ArticlesResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load articles: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  //! Account methods
  static Future<Response?> logOut(
      {required BuildContext context, required String token}) async {
    try {
      final response = await _dio.post(
        "${Constants.baseUrl}/auth/logout",
        options: Options(
          headers: {
            "token": "TOKEN__$token",
          },
        ),
      );
      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "Logout failed",
        );
      }

      return response;
    } on DioException catch (e) {
      String errorMessage = "Network error occurred. Please try again.";

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = "Request timed out. Check your internet connection.";
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              e.response?.data?["message"] ?? "Server error occurred";
          break;
        default:
          errorMessage = "Network error: ${e.message}";
      }
      showError(context, errorMessage);
      return null;
    }
  }

  static Future<Response?> deleteAccount(
      {required BuildContext context, required String token}) async {
    try {
      final response = await _dio.delete(
        "${Constants.baseUrl}/auth/delete",
        options: Options(
          headers: {
            "token": "TOKEN__$token",
          },
        ),
      );
      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "delete account failed",
        );
      }

      return response;
    } on DioException catch (e) {
      String errorMessage = "Network error occurred. Please try again.";

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = "Request timed out. Check your internet connection.";
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              e.response?.data?["message"] ?? "Server error occurred";
          break;
        default:
          errorMessage = "Network error: ${e.message}";
      }
      showError(context, errorMessage);
      return null;
    }
  }

  //! Doctors methods
  static Future<DoctorsResponse> getDoctors() async {
    try {
      final response = await _dio.get("${Constants.baseUrl}/doctor/all",
          queryParameters: {"status": "approved"});
      if (response.statusCode == 200) {
        return DoctorsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load Doctors: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<TopRatedDoctors> getTopRatedDoctors() async {
    try {
      final response = await _dio.get(
        "${Constants.baseUrl}/doctor/topRated",
      );
      if (response.statusCode == 200) {
        return TopRatedDoctors.fromJson(response.data);
      } else {
        throw Exception('Failed to load Doctors: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<DoctorsDetailsModel> getDoctorsDetails(String doctorId) async {
    try {
      final response = await _dio.get(
        "${Constants.baseUrl}/doctor/$doctorId",
      );
      if (response.statusCode == 200) {
        return DoctorsDetailsModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load doctors details: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<UserReviewModel> getAllReviews(String doctorId) async {
    try {
      final response = await _dio.get(
        "${Constants.baseUrl}/review/all",
        queryParameters: {"doctorId": doctorId},
      );
      if (response.statusCode == 200) {
        return UserReviewModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load reviews: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<Response?> deleteReview(
      {required BuildContext context,
      required String token,
      required String doctorId}) async {
    try {
      final response = await _dio.delete(
        "${Constants.baseUrl}/review/delete/$doctorId",
        options: Options(
          headers: {
            "token": "TOKEN__$token",
          },
        ),
      );
      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "delete review failed",
        );
      }

      return response;
    } on DioException catch (e) {
      String errorMessage = "Network error occurred. Please try again.";

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = "Request timed out. Check your internet connection.";
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              e.response?.data?["message"] ?? "Server error occurred";
          break;
        default:
          errorMessage = "Network error: ${e.message}";
      }
      showError(context, errorMessage);
      return null;
    }
  }

  static Future<Response?> addDoctorReview(
      {required String token,
      required String comment,
      required double rating,
      required String doctorId,
      required BuildContext context}) async {
    try {
      final response = await _dio.post(
        "${Constants.baseUrl}/review/add",
        data: {
          "doctorId": doctorId,
          "comment": comment,
          "rating": rating,
        },
        options: Options(
          headers: {
            "token": "TOKEN__$token",
          },
        ),
      );

      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "add review failed",
        );
      }

      return response;
    } on DioException catch (e) {
      print(e.message);
      return null;
    }
  }

  // static Future<Response?> updateDoctorReview(
  //     {required String token,
  //     required String comment,
  //     required double rating,
  //     required String reviewId,
  //     required BuildContext context}) async {
  //   try {
  //     final response = await _dio.patch(
  //       "${Constants.baseUrl}/review/update/$reviewId",
  //       data: {
  //         "comment": comment,
  //         "rating": rating,
  //       },
  //       options: Options(
  //         headers: {
  //           "token": "TOKEN__$token",
  //         },
  //       ),
  //     );

  //     if (response.data["success"] != true) {
  //       throw DioException(
  //         requestOptions: response.requestOptions,
  //         response: response,
  //         error: response.data["message"] ?? "update review failed",
  //       );
  //     }

  //     return response;
  //   } on DioException catch (e) {
  //     print(e.message);
  //     return null;
  //   }
  // }

  static Future<Response?> updateProfile(
      {required String token, required BuildContext context}) async {
    try {
      final response = await _dio.post(
        "${Constants.baseUrl}/user/updateProfile",
        options: Options(
          headers: {
            "token": "TOKEN__$token",
          },
        ),
      );

      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "update profile failed",
        );
      }

      return response;
    } on DioException catch (e) {
      print(e.message);
      return null;
    }
  }

  static Future<UserReviewModel> getUserReview(String token) async {
    try {
      final response = await _dio.get("${Constants.baseUrl}/review/userReviews",
          options: Options(
            headers: {
              "token": "TOKEN__$token",
            },
          ));
      if (response.statusCode == 200) {
        return UserReviewModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load scan review : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<GetMyReview> getMyReviewForDoctor(
      String token, String doctorId) async {
    try {
      final response = await _dio.get(
          "${Constants.baseUrl}/review/reviewForDoctor/$doctorId",
          options: Options(
            headers: {
              "token": "TOKEN__$token",
            },
          ));
      if (response.statusCode == 200) {
        return GetMyReview.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load your review : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<UserModel> getUserData(String token) async {
    try {
      final response = await _dio.get("${Constants.baseUrl}/user",
          options: Options(
            headers: {
              "token": "TOKEN__$token",
            },
          ));
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user data: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<ScanResultHistoryModel> getScanResultsHistory(
      String token) async {
    try {
      final response = await _dio.get("${Constants.baseUrl}/user/pastResults",
          options: Options(
            headers: {
              "token": "TOKEN__$token",
            },
          ));
      if (response.statusCode == 200) {
        return ScanResultHistoryModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load scan results : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<ScanResultDetails> getScanResultsDetails(
    String token,
    String scanResultId,
  ) async {
    try {
      final response =
          await _dio.get("${Constants.baseUrl}/user/pastResults/$scanResultId",
              options: Options(
                headers: {
                  "token": "TOKEN__$token",
                },
              ));
      if (response.statusCode == 200) {
        return ScanResultDetails.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load scan results details : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('API call failed: ${e.message}');
    }
  }

  static Future<Response?> postScan({
    required String token,
    required XFile imageFile,
    required BuildContext context,
  }) async {
    try {
      final bytes = await imageFile.readAsBytes();

      FormData formData = FormData.fromMap({
        "scanFile": MultipartFile.fromBytes(
          bytes,
          filename: imageFile.name,
          contentType:
              MediaType.parse('image/${imageFile.name.split('.').last}'),
        ),
      });

      final response = await _dio.post(
        "${Constants.baseUrl}/user/diagnose",
        data: formData,
        options: Options(
          headers: {"token": "TOKEN__$token"},
          contentType: "multipart/form-data",
        ),
      );

      if (response.data["success"] != true) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["message"] ?? "Upload failed",
        );
      }

      return response;
    } on DioException catch (e) {
      String errorMessage = "An error occurred.";

      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final errorData = e.response?.data;

        if (statusCode == 400) {
          errorMessage = errorData?["message"] ?? "Invalid request.";
        } else {
          errorMessage = e.message ?? "An error occurred.";
        }
      } else {
        errorMessage = e.message ?? "Network error. Please try again.";
      }

      if (context.mounted) {
        showErrorMessage(context, errorMessage);
      }
      return null;
    } catch (e) {
      String errorMessage = "Error uploading image: ${e.toString()}";

      if (context.mounted) {
        showErrorMessage(context, errorMessage);
      }
      return null;
    }
  }
}
