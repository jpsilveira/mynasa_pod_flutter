import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'picture_model.dart';

class MyNasaController {
  final String apiKey = '5XOZvHZE4LLFGIg50ByU1BRbjJjre3dDRUygGGQa';
  final String urlNasa = 'https://api.nasa.gov/planetary/apod';

  final String startDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 30)));
  final String endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late http.Client client;

  MyNasaController([http.Client? myClient]) {
    if (myClient == null) {
      client = http.Client();
    } else {
      client = myClient;
    }
  }

  Future<List<PictureModel>> getPictures() async {
    const String fileName = 'nasa.json';
    List<PictureModel> pictures = [];
    final dir = await getTemporaryDirectory();

    final queryUri = Uri.parse(
        '$urlNasa?api_key=$apiKey&start_date=$startDate&end_date=$endDate');

    File file = File("${dir.path}/$fileName");

    final http.Response res = await client.get(queryUri);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      data.forEach((element) {
        pictures.add(PictureModel.fromJson(element));
      });

      file.writeAsStringSync(res.body);
      return pictures;
    }
    return pictures;
  }

  Future<List<PictureModel>> getCachedPictures() async {
    const String fileName = 'nasa.json';
    List<PictureModel> pictures = [];
    final dir = await getTemporaryDirectory();

    File file = File("${dir.path}/$fileName");

    if (file.existsSync()) {
      final res = file.readAsStringSync();
      final data = json.decode(res);
      data.forEach((element) {
        pictures.add(PictureModel.fromJson(element));
      });
    }
    return pictures;
  }
}
