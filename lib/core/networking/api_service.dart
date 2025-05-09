// import 'package:dio/dio.dart';
// import 'package:weather/feature/home_screen/date/model/weather_model.dart';

// class ApiService {
//   final Dio dio;
//   final String baseUrl = "https://api.weatherapi.com/v1";
//   final String apiKey = "4674146fd90c4c37b81143745252401";

//   ApiService(this.dio);

//   Future<WeatherModel> getWeather({required String location}) async {
//     try {
//       Response response =
//           await dio.get("$baseUrl/current.json?key=$apiKey&q=$location");

//       WeatherModel resultWeatherSearch = WeatherModel.fromJson(response.data);

//       return resultWeatherSearch;
//     } on DioException catch (e) {
//       final String errMessage = e.response?.data["error"]["message"] ??
//           "oops there was an error, try later";
//       throw Exception(errMessage);
//     } catch (e) {
//       throw Exception("oops there was an error , try later ");
//     }
//   }
// }
