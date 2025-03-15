class GetServiceModel {
  bool? status;
  List<Services>? service;

  GetServiceModel({this.status, this.service});

  GetServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      service = <Services>[];
      json['data'].forEach((v) {
        service!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.service != null) {
      data['data'] = this.service!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? pid;
  String? projectName;
  int? amount;
  String? companyid;
  String? projectimage;

  Services(
      {this.pid,
        this.projectName,
        this.amount,
        this.companyid,
        this.projectimage});

  Services.fromJson(Map<String, dynamic> json) {
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
