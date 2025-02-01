import 'package:flutter/cupertino.dart';

import '../model/GetLeadModel.dart';
import '../service/UserApi.dart';

class ViewLeadsProviders extends ChangeNotifier {
  bool _isLoading = false;
  bool _pageLoading = false;
  bool _hasNext = true;
  List<LeadsData> _leadslist = [];
  int _currentPage = 1;

  bool get isLoading => _isLoading;
  bool get pageLoading => _pageLoading;
  bool get hasNext => _hasNext;
  List<LeadsData> get leadslist => _leadslist;
  int get currentPage => _currentPage;

  Future<void> getLeadsData(context) async {
    _isLoading = true;
    _currentPage = 1;
    notifyListeners();
    var res = await Userapi.getLeads(_currentPage, context);
    try {
      if (res != null) {
        if (res.leads != null) {
          _leadslist = res.leads?.leadslist ?? [];
          _hasNext = res.leads?.nextPageUrl !=null;
          print("getLeadsData>>${_leadslist}");
        } else {
          print("No leads data found");
        }
      } else {
        print("Failed to fetch data");
      }
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMoreLeadsData(context) async {
    if (!_hasNext || _pageLoading) {
      debugPrint("No more pages to fetch or another fetch is in progress.");
      return;
    }
    _pageLoading = true;
    notifyListeners();
    var res = await Userapi.getLeads(_currentPage+1, context);
    try {
      if (res != null) {
        if (res.leads != null) {
          _currentPage ++;
          _leadslist.addAll( res.leads?.leadslist ?? []);
          _hasNext = res.leads?.nextPageUrl !=null;
          print("getLeadsData>>${_leadslist}");
        } else {
          print("No leads data found");
        }
      } else {
        print("Failed to fetch data");
      }
    } catch (e) {
    } finally {
      _pageLoading = false;
      notifyListeners();
    }
  }
}
