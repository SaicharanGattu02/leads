class GetLeadData {
  bool? status;
  Leads? leads;

  GetLeadData({this.status, this.leads});

  GetLeadData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    leads = json['leads'] != null ? new Leads.fromJson(json['leads']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.leads != null) {
      data['leads'] = this.leads!.toJson();
    }
    return data;
  }
}

class Leads {
  int? currentPage;
  List<LeadsData>? leadslist;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Leads(
      {this.currentPage,
        this.leadslist,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Leads.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      leadslist = <LeadsData>[];
      json['data'].forEach((v) {
        leadslist!.add(new LeadsData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.leadslist != null) {
      data['data'] = this.leadslist!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class LeadsData {
  int? leadid;
  String? customer;
  String? ogrinazation;
  String? contactperson;
  String? title;
  String? description;
  int? value;
  String? currency;
  String? label;
  String? owner;
  int? leadownerid;
  int? phone;
  String? phonetype;
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
  String? expacteddate;
  Null? filepath;
  Null? content;
  Null? team;
  int? dealstatus;
  Null? leadComments;
  String? dealfixdate;
  String? leadsource;
  int? leadstage;
  String? color;
  String? leadstagetext;
  String? companyid;
  Null? leaddata;
  Null? dealdata;
  User? user;

  LeadsData(
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
        this.user});

  LeadsData.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? uid;
  String? fullname;

  User({this.uid, this.fullname});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['fullname'] = this.fullname;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
