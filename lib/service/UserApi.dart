import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:leads/model/GetLeadModel.dart';
import 'package:leads/model/SignInModel.dart';
import 'package:leads/model/SourceModel.dart';
import 'package:leads/screens/SignIn.dart';
import 'package:leads/service/CustomSnackBar.dart';
import 'package:leads/service/Preferances.dart';
import '../model/GetLeadEdit.dart';
import '../model/GetStaffModel.dart';
import '../model/LoginModel.dart';
import '../model/ServiceModel.dart';
import '../screens/SubscriptionExpiredScreen.dart';
import 'otherservices.dart';
import 'package:http/http.dart' as http;

class Userapi {
  static String host = "https://leads.synk.in";
  static Future<GetSourceModel?> GetSource(BuildContext context) async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/mysources");
      final res = await get(url, headers: headers);
      if (res.statusCode == 200) {
        print("GetSource Response:${res.body}");
        return GetSourceModel.fromJson(jsonDecode(res.body));
      }else if (res.statusCode == 403) {

        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SubscriptionExpiredScreen();
          },
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ));

      } else if (res.statusCode == 401){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignInWithEmail()));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  static Future<SignInModel?> SignIn(
      String email, String password, BuildContext context) async {
    try {
      Map<String, String> data = {
        "email": email,
        "password": password,
      };
      print("body>>>$data");
      final url = Uri.parse("${host}/api/login");
      final response = await http.post(
        url,
        body: data,
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("SignIn Status: ${response.body}");
        String responseMessage = jsonResponse['message'] ?? 'Login successful!';
        CustomSnackBar.show(context, responseMessage);
        return SignInModel.fromJson(jsonResponse);
      }else if (response.statusCode == 403) {

        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SubscriptionExpiredScreen();
          },
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ));

      } else {
        final jsonResponse = jsonDecode(response.body);
        print("SignIn Status: ${response.body}");
        String responseMessage = jsonResponse['message'];
        CustomSnackBar.show(context, responseMessage ?? '');
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<GetServiceModel?> getService(BuildContext context) async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/myservice");
      final res = await get(url, headers: headers);
      if (res.statusCode == 200){
        print("getService Response:${res.body}");
        return GetServiceModel.fromJson(jsonDecode(res.body));
      }else if (res.statusCode == 403) {

        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SubscriptionExpiredScreen();
          },
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ));

      }else if (res.statusCode == 401){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignInWithEmail()));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  static Future<GetLeadEdit?> getEditData(id, BuildContext context) async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/editleaddata/${id}'");
      final res = await get(url, headers: headers);
      if (res.statusCode == 200) {
        print("getEditData Response:${res.body}");
        return GetLeadEdit.fromJson(jsonDecode(res.body));
      }else if (res.statusCode == 403) {

        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SubscriptionExpiredScreen();
          },
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ));

      }else if (res.statusCode == 401){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignInWithEmail()));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  static Future<GetStaffModel?> getStaff(BuildContext context) async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/mystaff");
      final res = await get(url, headers: headers);
      if (res.statusCode == 200){
        print("getStaff Response:${res.body}");
        return GetStaffModel.fromJson(jsonDecode(res.body));
      }else if (res.statusCode == 403) {

        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SubscriptionExpiredScreen();
          },
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ));

      }else if (res.statusCode == 401){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignInWithEmail()));
      }  else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  static Future<GetLeadData?> getLeads(page, BuildContext context) async {
    if (await CheckHeaderValidity()) {
      try {
        final headers = await getheader();
        final url = Uri.parse("${host}/api/getleaddata?page=${page}");
        final res = await get(url, headers: headers);

        if (res.statusCode==200) {
          final jsonResponse = jsonDecode(res.body);
          final jsonmesage = jsonResponse['message'];

          if (jsonResponse['status'] == false) {
            CustomSnackBar.show(context, jsonmesage ?? '');
          }

          print("getLeads Response:${res.body}");
          return GetLeadData.fromJson(jsonDecode(res.body));
        }else if (res.statusCode == 403) {

          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return SubscriptionExpiredScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ));

        }else if (res.statusCode == 401){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInWithEmail()));
        } else {
          print("Null Response");
          return null;
        }
      } catch (e) {
        debugPrint('Error: $e');
        return null;
      }
    } else {
      debugPrint('Error Occured');
      return null;
    }
  }

  static Future<LeadData?> addLeadData(
    String customerName,
    String companyName,
    String phoneNumber,
    String email,
    String service,
    String leadSource,
    String priority,
    String price,
    String city,
    String remarks,
    String leadOwnerid,BuildContext context
  ) async {
    if (await CheckHeaderValidity()) {
      try {
        final sessionid = await PreferenceService().getString("access_token");
        final url = Uri.parse('${host}/api/addleaddata');
        // final String userid= PreferenceService().getString('user_id') as String;

        var request = http.MultipartRequest('POST', url)
          // ..fields['created_at'] = date
          ..headers['Authorization'] = 'Bearer ${sessionid}'
          ..fields['customer'] = customerName
          ..fields['Orginazation'] = companyName
          ..fields['Title'] = service
          ..fields['Description'] = remarks
          ..fields['mobile'] = phoneNumber
          ..fields['email'] = email
          ..fields['leadsource'] = leadSource
          ..fields['city'] = city
          ..fields['Priotity'] = priority
          ..fields['leadOwnerid'] = leadOwnerid
          ..fields['amount'] = price;

        print("request fields:${request.fields}");
        final response = await request.send();

        if (response.statusCode == 200) {
          final responseString = await response.stream.bytesToString();
          print('addLead Response: $responseString');
          return LeadData.fromJson(jsonDecode(responseString));
        }else if (response.statusCode == 403) {

          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return SubscriptionExpiredScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ));

        }else if (response.statusCode == 401){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInWithEmail()));
        }  else {
          final responseString = await response.stream.bytesToString();
          print('Error: ${response.statusCode}, Message: $responseString');
          return null;
        }
      } catch (e) {
        print('Exception: $e');
        return null;
      }
    } else {
      print('Error Occured');
      return null;
    }
  }

  static Future<LeadData?> UpdateLead(
    id,
    String customerName,
    String companyName,
    String phoneNumber,
    String email,
    String service,
    String leadSource,
    String priority,
    String price,
    String city,
    String remarks,
    String leadOwnerid,BuildContext context,
  ) async {
    if (await CheckHeaderValidity()) {
      try {
        final sessionid = await PreferenceService().getString("access_token");
        final url = Uri.parse('${host}/api/update_lead/${id}');
        var request = http.MultipartRequest('POST', url)
          ..headers['Authorization'] = 'Bearer ${sessionid}'
          ..fields['customer'] = customerName
          ..fields['Orginazation'] = companyName // Make sure this is correct
          ..fields['Title'] = service
          ..fields['Description'] = remarks
          ..fields['mobile'] = phoneNumber
          ..fields['email'] = email
          ..fields['leadsource'] = leadSource
          ..fields['city'] = city
          ..fields['Priotity'] = priority
          ..fields['leadOwnerid'] = leadOwnerid
          ..fields['amount'] = price;

        print("request fields:${request.fields}");
        final response = await request.send();
        if (response.statusCode == 200) {
          final responseString = await response.stream.bytesToString();
          print('addLead Response: $responseString');
          return LeadData.fromJson(jsonDecode(responseString));
        }else if (response.statusCode == 403) {

          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return SubscriptionExpiredScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ));

        }else if (response.statusCode == 401){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInWithEmail()));
        }  else {
          print('Error: ${response.statusCode}');
          return null;
        }
      } catch (e) {
        print('Exception: $e');
        return null;
      }
    } else {
      print('Error Occured');
      return null;
    }
  }

  static Future<SignInModel?> UpdateRefreshToken(refreshToken) async {
    try {
      final url = Uri.parse("${host}/api/refresh");
      Map<String, String> data = {
        "refresh_token": refreshToken,
      };
      final headers = await getheader();
      final response = await http.get(
        url,
        headers: headers,
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("RefreshtokenApi Status:${response.body}");
        return SignInModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred UpdateRefreshToken: $e");
      return null;
    }
  }
}
