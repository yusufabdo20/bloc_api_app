import 'dart:developer';

import 'package:bloc_apiapp/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      log(response.data.toString());
      var resultList = response.data['results'];
      return resultList;
    } catch (error) {
      print("There are some ERRORS : $error");
      return [];
    }
  }
}
