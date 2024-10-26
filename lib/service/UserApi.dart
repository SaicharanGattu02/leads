import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:leads/model/SourceModel.dart';
import '../model/ServiceModel.dart';
import 'otherservices.dart';

class Userapi {

  static String host = "https://app.synk.in";

  static Future<GetSourceModel?> GetSource() async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/myservices");
      final res = await get(url, headers: headers);
      if (res != null) {
        print("GetSource Response:${res.body}");
        return GetSourceModel.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
