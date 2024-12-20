import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:leads/model/GetLeadModel.dart';
import 'package:leads/model/SourceModel.dart';
import '../model/GetLeadEdit.dart';
import '../model/GetStaffModel.dart';
import '../model/LoginModel.dart';
import '../model/ServiceModel.dart';
import 'otherservices.dart';
import 'package:http/http.dart' as http;

class Userapi {

  static String host = "https://app.synk.in";

  static Future<GetSourceModel?> GetSource() async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/mysource");
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



  static Future<GetServiceModel?> getService() async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/myservices");
      final res = await get(url, headers: headers);
      if (res != null) {
        print("getService Response:${res.body}");
        return GetServiceModel.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  static Future<GetLeadEdit?> getEditData(id) async {
    print('idd>>${id}');
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/editleaddata/${id}'");
      final res = await get(url, headers: headers);
      if (res != null) {
        print("getEditData Response:${res.body}");
        return GetLeadEdit.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }


  static Future<GetStaffModel?> getStaff() async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/mystaff");
      final res = await get(url, headers: headers);
      if (res != null) {
        print("getStaff Response:${res.body}");
        return GetStaffModel.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  static Future<GetLeadData?> getLeads() async {
    try {
      final headers = await getheader();
      final url = Uri.parse("${host}/api/getleaddata");
      final res = await get(url, headers: headers);
      if (res != null) {
        print("getLeads Response:${res.body}");
        return GetLeadData.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }



  static Future<LeadData?> addLeadData(
      String customerName,
      String companyName,
      String phoneNumber,
      String service,
      String leadSource,
      String priority,
      String staff,
      String price,
      String city,
      String remarks,
      ) async {
    final url = Uri.parse('https://app.synk.in/api/addleaddata');

    var request = http.MultipartRequest('POST', url)
      // ..fields['created_at'] = date
      ..fields['customer'] = customerName
      ..fields['Orginazation'] = companyName // Make sure this is correct
      ..fields['Title'] = service
      ..fields['Description'] = remarks
      ..fields['mobile'] = phoneNumber
      ..fields['email'] = "sk.asif0490@gmail.com" // Ensure it's properly formatted
      ..fields['leadsource'] = leadSource
      ..fields['city'] = city
      ..fields['Priotity'] = priority
      ..fields['ownerid'] = "134"
      ..fields['leadOwnerid'] = "134" // Assuming this is a static value
      ..fields['amount'] = price;

    print("request fields:${request.fields}");

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        print('addLead Response: $responseString');
        return LeadData.fromJson(jsonDecode(responseString));
      } else {
        final responseString = await response.stream.bytesToString();
        print('Error: ${response.statusCode}, Message: $responseString');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }





  static Future<LeadData?> UpdateLead( id,
      String customerName,
      String companyName,
      String phoneNumber,
      String service,
      String leadSource,
      String priority,
      String staff,
      String price,
      String city,
      String remarks,
      ) async  {
      final url = Uri.parse('https://app.synk.in/api/update_lead/${id}');

    var request = http.MultipartRequest('POST', url)

      // ..fields['created_at'] = date
      ..fields['customer'] = customerName
      ..fields['Orginazation'] = companyName // Make sure this is correct
      ..fields['Title'] = service
      ..fields['Description'] = remarks
      ..fields['mobile'] = phoneNumber
      ..fields['email'] = "sk.asif0490@gmail.com" // Ensure it's properly formatted
      ..fields['leadsource'] = leadSource
      ..fields['city'] = city
      ..fields['Priotity'] = priority
      ..fields['ownerid'] = "134"
      ..fields['leadOwnerid'] = "134"
      ..fields['amount'] = price;

      print("request fields:${request.fields}");
      try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        print('addLead Response: $responseString');
        return LeadData.fromJson(jsonDecode(responseString));

      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

}
