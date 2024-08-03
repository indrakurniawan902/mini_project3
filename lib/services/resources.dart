import 'package:dio/dio.dart';
import 'package:indie_commerce/models/user_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Resources {
  /// singleton untukk memastikan bahwa hanya satu instance dari kelas Dio yang akan dipanggil nantinya
  static final Resources instance = Resources._internal();
  Resources._internal();
  factory Resources() {
    return instance;
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: 'https://fakestoreapi.com'),
  );

  Future<UserModel> getUserById() async {
    /// memanggil shared pref (pacakage untuk menyimpan preferensi user)
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /// menyimpan token dalam variabel bernama token yang didapat ketika user telah login
    final String? token = prefs.getString('token');

    /// penggunaan pacakage jwt decoder untuk mendapat userid
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    try {
      // get data dari endpoint api
      final response = await dio.get('/users/${decodedToken['sub']}');
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load data user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
