
import 'package:flutter/material.dart';
import 'package:leads/model/SignInModel.dart';
import 'package:leads/service/UserApi.dart';

import 'Preferances.dart';

Future<Map<String, String>> getheader() async {
  final sessionid = await PreferenceService().getString("access_token");
  print(sessionid);
  String Token = "Bearer ${sessionid}";
  Map<String, String> headers = {
    'Authorization': Token,
    'Content-Type': 'application/json',
  };
  return headers;
}

Future<Map<String, String>> getheader1() async {
  final sessionid = await PreferenceService().getString("access_token");
  print(sessionid);
  String Token = "Bearer ${sessionid}";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  return headers;
}

Future<bool> CheckHeaderValidity() async {
  try {
    final String? refreshToken = await PreferenceService().getString("access_token");
    final int? expiryTimestamp = await PreferenceService().getInt("expiry_time");

    if (refreshToken == null || expiryTimestamp == null) {
      return false;
    }

    final int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (currentTime < expiryTimestamp) {
      return true; // Token is still valid
    }

    // Token expired, attempt to refresh
    final response = await Userapi.UpdateRefreshToken();
    if (response?.accessToken != null) {
      final int newExpiryTimestamp = currentTime + (response?.expiresIn ?? 0);
       PreferenceService().saveString('access_token', response?.accessToken??"");
       PreferenceService().saveInt('expiry_time', newExpiryTimestamp);
      return true;
    }
  } catch (e, stackTrace) {
    print("Error in checkHeaderValidity: $e\n$stackTrace");
  }
  return false;
}






