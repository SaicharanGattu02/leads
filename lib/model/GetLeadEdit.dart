class GetLeadEdit {
  bool? status;
  List<LeadsEdit>? leadsdata;

  GetLeadEdit({this.status, this.leadsdata});

  GetLeadEdit.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['leads'] != null) {
      leadsdata = <LeadsEdit>[];
      json['leads'].forEach((v) {
        leadsdata!.add(new LeadsEdit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.leadsdata != null) {
      data['leads'] = this.leadsdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadsEdit {
  int? leadid;
  String? customer;
  String? ogrinazation;
  String? contactperson;
  int? title;
  String? titleId;
  String? description;
  int? value;
  String? currency;
  String? label;
  String? owner;
  int? leadownerid;
  int? phone;
  String? phonetype;
  String? email;
  String? emailtype;
  String? addressline1;
  String? addressline2;
  String? addressline3;
  String? town;
  String? state;
  String? zipcode;
  String? country;
  String? createdAt;
  String? createdBy;
  int? createdById;
  int? status;
  String? expacteddate;
  String? filepath;
  String? content;
  String? team;
  int? dealstatus;
  String? leadComments;
  String? dealfixdate;
  int? leadsource;
  int? leadstage;
  String? color;
  String? leadstagetext;
  String? companyid;
  String? leaddata;
  String? dealdata;
  User? user;
  List<TitleName>? titleName;
  List<LeadSourceName>? leadSourceName;

  LeadsEdit(
      {this.leadid,
        this.customer,
        this.ogrinazation,
        this.contactperson,
        this.title,
        this.titleId,
        this.description,
        this.value,
        this.currency,
        this.label,
        this.owner,
        this.leadownerid,
        this.phone,
        this.phonetype,
        this.email,
        this.emailtype,
        this.addressline1,
        this.addressline2,
        this.addressline3,
        this.town,
        this.state,
        this.zipcode,
        this.country,
        this.createdAt,
        this.createdBy,
        this.createdById,
        this.status,
        this.expacteddate,
        this.filepath,
        this.content,
        this.team,
        this.dealstatus,
        this.leadComments,
        this.dealfixdate,
        this.leadsource,
        this.leadstage,
        this.color,
        this.leadstagetext,
        this.companyid,
        this.leaddata,
        this.dealdata,
        this.user,
        this.titleName,
        this.leadSourceName});

  LeadsEdit.fromJson(Map<String, dynamic> json) {
    leadid = json['leadid'];
    customer = json['customer'];
    ogrinazation = json['ogrinazation'];
    contactperson = json['contactperson'];
    title = json['title'];
    titleId = json['title_id'];
    description = json['description'];
    value = json['value'];
    currency = json['currency'];
    label = json['label'];
    owner = json['owner'];
    leadownerid = json['leadownerid'];
    phone = json['phone'];
    phonetype = json['phonetype'];
    email = json['email'];
    emailtype = json['emailtype'];
    addressline1 = json['addressline_1'];
    addressline2 = json['addressline_2'];
    addressline3 = json['addressline_3'];
    town = json['town'];
    state = json['state'];
    zipcode = json['zipcode'];
    country = json['country'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    createdById = json['created_by_id'];
    status = json['status'];
    expacteddate = json['expacteddate'];
    filepath = json['filepath'];
    content = json['content'];
    team = json['team'];
    dealstatus = json['dealstatus'];
    leadComments = json['lead_comments'];
    dealfixdate = json['dealfixdate'];
    leadsource = json['leadsource'];
    leadstage = json['leadstage'];
    color = json['color'];
    leadstagetext = json['leadstagetext'];
    companyid = json['companyid'];
    leaddata = json['leaddata'];
    dealdata = json['dealdata'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['title_name'] != null) {
      titleName = <TitleName>[];
      json['title_name'].forEach((v) {
        titleName!.add(new TitleName.fromJson(v));
      });
    }
    if (json['lead_source_name'] != null) {
      leadSourceName = <LeadSourceName>[];
      json['lead_source_name'].forEach((v) {
        leadSourceName!.add(new LeadSourceName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadid'] = this.leadid;
    data['customer'] = this.customer;
    data['ogrinazation'] = this.ogrinazation;
    data['contactperson'] = this.contactperson;
    data['title'] = this.title;
    data['title_id'] = this.titleId;
    data['description'] = this.description;
    data['value'] = this.value;
    data['currency'] = this.currency;
    data['label'] = this.label;
    data['owner'] = this.owner;
    data['leadownerid'] = this.leadownerid;
    data['phone'] = this.phone;
    data['phonetype'] = this.phonetype;
    data['email'] = this.email;
    data['emailtype'] = this.emailtype;
    data['addressline_1'] = this.addressline1;
    data['addressline_2'] = this.addressline2;
    data['addressline_3'] = this.addressline3;
    data['town'] = this.town;
    data['state'] = this.state;
    data['zipcode'] = this.zipcode;
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['created_by_id'] = this.createdById;
    data['status'] = this.status;
    data['expacteddate'] = this.expacteddate;
    data['filepath'] = this.filepath;
    data['content'] = this.content;
    data['team'] = this.team;
    data['dealstatus'] = this.dealstatus;
    data['lead_comments'] = this.leadComments;
    data['dealfixdate'] = this.dealfixdate;
    data['leadsource'] = this.leadsource;
    data['leadstage'] = this.leadstage;
    data['color'] = this.color;
    data['leadstagetext'] = this.leadstagetext;
    data['companyid'] = this.companyid;
    data['leaddata'] = this.leaddata;
    data['dealdata'] = this.dealdata;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.titleName != null) {
      data['title_name'] = this.titleName!.map((v) => v.toJson()).toList();
    }
    if (this.leadSourceName != null) {
      data['lead_source_name'] =
          this.leadSourceName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? uid;
  String? email;
  String? fullname;
  int? role;
  int? mobile;
  String? designation;
  String? imagepath;
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
  String? createdAt;
  String? updatedAt;
  int? emailOtp;
  int? emailOtpStatus;
  String? emailOtpTime;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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

class TitleName {
  int? pid;
  String? projectName;
  int? amount;
  String? companyid;
  String? projectimage;

  TitleName(
      {this.pid,
        this.projectName,
        this.amount,
        this.companyid,
        this.projectimage});

  TitleName.fromJson(Map<String, dynamic> json) {
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

class LeadSourceName {
  int? lsid;
  String? leadsource;
  String? companyid;
  String? imagepath;

  LeadSourceName({this.lsid, this.leadsource, this.companyid, this.imagepath});

  LeadSourceName.fromJson(Map<String, dynamic> json) {
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
