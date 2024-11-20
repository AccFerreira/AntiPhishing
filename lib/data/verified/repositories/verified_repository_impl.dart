import 'dart:convert';

import 'package:antiphishing/data/verified/repositories/keys/keys.dart';
import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:http/http.dart' as http;

class VerifiedRepositoryImpl extends VerifiedRepository {
  static const apiSafeBrowsingUrl = 'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=$apiKey';
  static const apiLanguageToolUrl = 'https://api.languagetool.org/v2/check';

  @override
  Future<bool> hasOrthographyMistakes(String text) async {
    final response = await http.post(
      Uri.parse(apiLanguageToolUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'text': text,
        'language': 'pt-BR',
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['matches'].isEmpty) {
        return false;
      }
      if (result['matches'].length == 1 && result['matches'].first['rule']['id'] == 'UPPERCASE_SENTENCE_START') {
        return false;
      }
      return true;
    } else {
      throw Exception('Erro ao verificar texto: ${response.statusCode}');
    }
  }

  @override
  Future<bool> doesUrlExist(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode >= 200 && response.statusCode < 400;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isASafeUrl(String url) async {
    final body = {
      "client": {"clientId": "anti_phishing", "clientVersion": "1.0"},
      "threatInfo": {
        "threatTypes": ["MALWARE", "SOCIAL_ENGINEERING", "POTENTIALLY_HARMFUL_APPLICATION"],
        "platformTypes": ["ANY_PLATFORM"],
        "threatEntryTypes": ["URL"],
        "threatEntries": [
          {"url": url}
        ]
      }
    };

    final response = await http.post(
      Uri.parse(apiSafeBrowsingUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['matches'] == null;
    } else {
      throw Exception('Erro ao verificar URL: ${response.statusCode}');
    }
  }
}
