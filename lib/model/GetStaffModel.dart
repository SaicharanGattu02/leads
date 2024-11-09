class GetStaffModel {
  bool? status;
  List<Staff>? staff;

  GetStaffModel({this.status, this.staff});

  GetStaffModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      staff = <Staff>[];
      json['data'].forEach((v) {
        staff!.add(new Staff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.staff != null) {
      data['data'] = this.staff!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Staff {
  int? uid;
  String? email;
  String? fullname;
  int? role;
  int? mobile;
  String? designation;
  Null? imagepath;
  int? status;
  String? companyname;
  String? companyid;
  String? regdate;
  String? reregistrationdate;
  String? regendingdate;
  int? plantype;
  int? expstatus;
  int? editAccess;
  int? deleteAccess;
  Null? createdAt;
  Null? updatedAt;
  Null? emailOtp;
  int? emailOtpStatus;
  Null? emailOtpTime;

  Staff(
      {this.uid,
        this.email,
        this.fullname,
        this.role,
        this.mobile,
        this.designation,
        this.imagepath,
        this.status,
        this.companyname,
        this.companyid,
        this.regdate,
        this.reregistrationdate,
        this.regendingdate,
        this.plantype,
        this.expstatus,
        this.editAccess,
        this.deleteAccess,
        this.createdAt,
        this.updatedAt,
        this.emailOtp,
        this.emailOtpStatus,
        this.emailOtpTime});

  Staff.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    fullname = json['fullname'];
    role = json['role'];
    mobile = json['mobile'];
    designation = json['designation'];
    imagepath = json['imagepath'];
    status = json['status'];
    companyname = json['companyname'];
    companyid = json['companyid'];
    regdate = json['regdate'];
    reregistrationdate = json['reregistrationdate'];
    regendingdate = json['regendingdate'];
    plantype = json['plantype'];
    expstatus = json['expstatus'];
    editAccess = json['edit_access'];
    deleteAccess = json['delete_access'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    emailOtp = json['emailOtp'];
    emailOtpStatus = json['emailOtp_status'];
    emailOtpTime = json['emailOtp_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['fullname'] = this.fullname;
    data['role'] = this.role;
    data['mobile'] = this.mobile;
    data['designation'] = this.designation;
    data['imagepath'] = this.imagepath;
    data['status'] = this.status;
    data['companyname'] = this.companyname;
    data['companyid'] = this.companyid;
    data['regdate'] = this.regdate;
    data['reregistrationdate'] = this.reregistrationdate;
    data['regendingdate'] = this.regendingdate;
    data['plantype'] = this.plantype;
    data['expstatus'] = this.expstatus;
    data['edit_access'] = this.editAccess;
    data['delete_access'] = this.deleteAccess;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['emailOtp'] = this.emailOtp;
    data['emailOtp_status'] = this.emailOtpStatus;
    data['emailOtp_time'] = this.emailOtpTime;
    return data;
  }
}
