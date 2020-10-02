import 'package:dio/dio.dart';

abstract class ApiEndpoints {
  static final _dio = Dio();

  static Future<String> getLocationFromCep(String cep) async {
    String formattedCep = cep.replaceFirst('-', '');
    try {
      final response =
          await _dio.get("https://viacep.com.br/ws/$formattedCep/json/");
      print(response);
      return response.data["logradouro"];
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
