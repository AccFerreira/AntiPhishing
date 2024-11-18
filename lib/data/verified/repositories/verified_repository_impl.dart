import 'dart:convert';

import 'package:antiphishing/domain/verified/repository/verified_repository.dart';

class VerifiedRepositoryImpl extends VerifiedRepository {
  static const apiKey = "AIzaSyD4gdHhlJqFAUBQ_Zm5cfZmbp_-gxYQqjI";

  @override
  Future<bool> hasOrthographyMistakes(String text) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isASafeUrl(String url) async {
    const apiUrl = 'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=$apiKey';

    final body = {
      "client": {
        "clientId": "sua_aplicacao",
        "clientVersion": "1.0"
      },
      "threatInfo": {
        "threatTypes": ["MALWARE", "SOCIAL_ENGINEERING", "PHISHING"],
        "platformTypes": ["ANY_PLATFORM"],
        "threatEntryTypes": ["URL"],
        "threatEntries": [
          {"url": url}
        ]
      }
    };

    final response = await http.post(Uri.parse(apiUrl), body: json.encode(body));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['matches'] == null;
    } else {
      throw Exception('Erro ao verificar URL: ${response.statusCode}');
    }
  }

}
