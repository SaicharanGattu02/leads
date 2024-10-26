class GetServiceModel {
  bool? status;
  List<Data>? data;

  GetServiceModel({this.status, this.data});

  GetServiceModel.fromJson(Map<String, dynamic> json) {
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
  int? pid;
  String? projectName;
  int? amount;
  String? companyid;
  Null? projectimage;

  Data(
      {this.pid,
        this.projectName,
        this.amount,
        this.companyid,
        this.projectimage});

  Data.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    projectName = json['Project_Name'];
    amount = json['amount'];
    companyid = json['companyid'];
    projectimage = json['projectimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['Project_Name'] = this.projectName;
    data['amount'] = this.amount;
    data['companyid'] = this.companyid;
    data['projectimage'] = this.projectimage;
    return data;
  }
}
