class GetLeadModel {
  bool? status;
  List<Leads>? leads;

  GetLeadModel({this.status, this.leads});

  GetLeadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['leads'] != null) {
      leads = <Leads>[];
      json['leads'].forEach((v) {
        leads!.add(new Leads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.leads != null) {
      data['leads'] = this.leads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leads {
  int? leadid;
  String? customer;
  String? ogrinazation;
  Null? contactperson;
  String? title;
  String? description;
  int? value;
  Null? currency;
  String? label;
  String? owner;
  int? leadownerid;
  int? phone;
  Null? phonetype;
  String? email;
  Null? emailtype;
  Null? addressline1;
  Null? addressline2;
  Null? addressline3;
  String? town;
  Null? state;
  Null? zipcode;
  Null? country;
  String? createdAt;
  String? createdBy;
  int? createdById;
  int? status;
  Null? expacteddate;
  Null? filepath;
  Null? content;
  Null? team;
  int? dealstatus;
  Null? leadComments;
  Null? dealfixdate;
  String? leadsource;
  int? leadstage;
  String? color;
  String? leadstagetext;
  String? companyid;
  Null? leaddata;
  Null? dealdata;
  String? imagepath;
  int? uid;
  String? fullname;

  Leads(
      {this.leadid,
        this.customer,
        this.ogrinazation,
        this.contactperson,
        this.title,
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
        this.imagepath,
        this.uid,
        this.fullname});

  Leads.fromJson(Map<String, dynamic> json) {
    leadid = json['leadid'];
    customer = json['customer'];
    ogrinazation = json['ogrinazation'];
    contactperson = json['contactperson'];
    title = json['title'];
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
    imagepath = json['imagepath'];
    uid = json['uid'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadid'] = this.leadid;
    data['customer'] = this.customer;
    data['ogrinazation'] = this.ogrinazation;
    data['contactperson'] = this.contactperson;
    data['title'] = this.title;
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
    data['imagepath'] = this.imagepath;
    data['uid'] = this.uid;
    data['fullname'] = this.fullname;
    return data;
  }
}
