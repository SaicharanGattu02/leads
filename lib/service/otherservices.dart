
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
    String currentTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String? refreshToken = await PreferenceService().getString("access_token");
    final int? expiryTimestamp = await PreferenceService().getInt("expire_time");
    if (refreshToken == null || expiryTimestamp == null) {
      return false;
    }

    // Parse expiry timestamp safely
    int expiryTime = expiryTimestamp;
    int currentTime = int.tryParse(currentTimestamp) ?? 0;

    // If token is still valid, return true
    if (currentTime < expiryTime) {
      return true;
    }

    // Token expired, attempt to refresh
    SignInModel? response = await Userapi.UpdateRefreshToken(refreshToken);
    if (response != null && response.accessToken != null) {
      PreferenceService().saveString('access_token', response.accessToken?? "");
      PreferenceService().saveInt('expire_time', response.expiresIn ?? 0);
      return true;
    }
  } catch (e) {
    print("Error in CheckHeaderValidity: $e");
  }

  return false; // If any failure occurs
}






