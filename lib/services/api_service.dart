// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:chat_gpt/constants/api_consts.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/models'),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );
      print('err33');
      final Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      final List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
      }
      return ModelsModel.modelsFromSnapShot(temp);
    } catch (error) {
      print('error--> $error');
      rethrow;
    }
  }
}
