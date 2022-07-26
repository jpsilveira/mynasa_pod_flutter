import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:mynasa_pod_flutter/mynasa_controller.dart';

class ClientMock extends Mock implements Client {}

main() {
//
//
  test('test_get_api_mock_data', () async {
    final client = MockClient((request) async {
      return Response(jsonData, 200);
    });
    final pictures = MyNasaController(client);
    final list = await pictures.getPictures();
    expect(list[1].title, 'Picture Title Test 2');
  });
//
//   test('test_get_api_data', () async {
//     final client = Client();
//     final pictures = MyNasaController(client);
//     final list = await pictures.getPictures();
//     expect(list[1].title, 'Europa and Jupiter from Voyager 1');
//   });
//
}

String jsonData = '''
                    [{
                    "url":"nasa",
                    "date":"2022-07-26",
                    "title":"Picture Title Test",
                    "explanation":"Explanation"
                    },
                    {
                    "url":"nasa",
                    "date":"2022-07-25",
                    "title":"Picture Title Test 2",
                    "explanation":"Explanation2"
                    }]
                    ''';
