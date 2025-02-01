class GetSourceModel {
  bool? status;
  List<Data>? data;

  GetSourceModel({this.status, this.data});

  GetSourceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? lsid;
  String? leadsource;
  String? companyid;
  String? imagepath;

  Data({this.lsid, this.leadsource, this.companyid, this.imagepath});

  Data.fromJson(Map<String, dynamic> json) {
    lsid = json['lsid'];
    leadsource = json['leadsource'];
    companyid = json['companyid'];
    imagepath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lsid'] = this.lsid;
    data['leadsource'] = this.leadsource;
    data['companyid'] = this.companyid;
    data['imagepath'] = this.imagepath;
    return data;
  }
}
