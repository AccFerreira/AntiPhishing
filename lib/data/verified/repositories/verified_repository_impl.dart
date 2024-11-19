import 'dart:convert';

import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:http/http.dart' as http;

class VerifiedRepositoryImpl extends VerifiedRepository {
  static const apiKey = "AIzaSyD4gdHhlJqFAUBQ_Zm5cfZmbp_-gxYQqjI";
  static const apiUrl = 'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=$apiKey';

  @override
  Future<bool> hasOrthographyMistakes(String text) async {
    return false;
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
          {"url": text}
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

  @override
  Future<bool> isASafeUrl(String url) async {
    return true;
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
