import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:important_app/constants/strings.dart';
import 'package:important_app/data/models/character_model.dart';

class CharactersWebService {
  late Dio dio;

  CharactersWebService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('/characters');
      print(response.data);

      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharactersQuotes(String author) async {
    try {
      Response response =
          await dio.get('/quote', queryParameters: {'author': author});
      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
