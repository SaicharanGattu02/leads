import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leads/model/LoginModel.dart';
import 'package:leads/service/CustomSnackBar.dart';

import '../model/GetLeadEdit.dart';
import '../model/GetStaffModel.dart';
import '../model/ServiceModel.dart';
import '../model/SourceModel.dart';

import '../service/UserApi.dart';
import 'ViewLeads.dart';
import 'ShakeWidget.dart';

class ViewLeads extends StatefulWidget {
  final String id;
  final String type;
  ViewLeads({super.key, required this.id, required this.type});

  @override
  State<ViewLeads> createState() => _ViewLeadsState();
}

class _ViewLeadsState extends State<ViewLeads> {
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _leadSourceController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _laedOwnerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String _validateDate = "";
  String _validateRemarks = "";
  String _validateCustomer = "";

  String _validateCompany = "";
  String _validatePhoneNumber = "";
  String _validateservice = "";
  String _validateleadSource = "";
  String _validatePriority = "";
  String _validateleadOwner = "";
  String _validatePrice = "";
  String _validateCity = "";

  String? selectedValue;
  bool _isLoading = true;
  int? serviceid;
  String? servicename;
  String? lead_source;
  String? lead_owner;
  int? leadsource_id;
  int? leadowner_id ;


  final List<String> items = [
    'Cold',
    'Hot',
    'Warm',
  ];

  @override
  void initState() {
    super.initState();

    _DateController.addListener(() {
      setState(() {
        _validateDate = "";
      });
    });
    _customerController.addListener(() {
      setState(() {
        _validateCustomer = "";
      });
    });
    _phoneNumberController.addListener(() {
      setState(() {
        _validatePhoneNumber = "";
      });
    });
    _serviceController.addListener(() {
      setState(() {
        _validateservice = "";
      });
    });
    _leadSourceController.addListener(() {
      setState(() {
        _validateleadSource = "";
      });
    });
    _priorityController.addListener(() {
      setState(() {
        _validatePriority = "";
      });
    });
    _laedOwnerController.addListener(() {
      setState(() {
        _validateleadOwner = "";
      });
    });
    _remarksController.addListener(() {
      setState(() {
        _validateRemarks = "";
      });
    });

    loadData();
  }

  Future<void> loadData() async {
    try {
      await Future.wait([
        services(),
        sourceList(),
        staff(),
        getEdit()
      ]);
    } catch (e) {
      // Handle any errors that occur during the loading
      print("Error loading data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _validateFields() {
    setState(() {
      // _validateDate = _DateController.text.isEmpty ? "Please select date" : "";
      _validateCustomer =
          _customerController.text.isEmpty ? "Please enter customer name" : "";
      // _validateCompany = _companyController.text.isEmpty
      //     ? "Please enter company name"
      //     : "";
      _validatePhoneNumber = _phoneNumberController.text.isEmpty ||
          _phoneNumberController.text.length != 10 ||
          !_phoneNumberController.text.isNotEmpty
          ? "Please enter a valid phone number with exactly 10 digits"
          : "";

      _validateservice =
          serviceid==null ? "Please select service" : "";
      _validateleadSource =
          leadsource_id==null  ? "Please select leadSource" : "";
      _validatePriority =
          selectedValue==null  ? "Please select priority" : "";
      _validateleadOwner =
          leadowner_id==null ? "Please enter staff" : "";
      // _validateCity = _cityController.text.isEmpty
      //     ? "Please enter city"
      //     : "";
      _validateRemarks =
          _remarksController.text.isEmpty ? "Please enter remarks" : "";
      // _validatePrice = _priceController.text.isEmpty
      //     ? "Please enter remarks"
      //     : "";

_isLoading=
      _validateCustomer.isEmpty&&

      _validatePhoneNumber.isEmpty&&
      _validateservice.isEmpty&&
      _validateleadSource.isEmpty&&
      _validatePriority.isEmpty&&
      _validateleadOwner.isEmpty&&
      _validatePhoneNumber.isEmpty&&
      _validateCity.isEmpty&&
      _validateRemarks.isEmpty;



      if (_isLoading) {

        addLead();
      }
    });
  }

  List<Data> data = [];

  Future<void> sourceList() async {
    var res = await Userapi.GetSource();
    setState(() {
      if (res != null) {
        if (res.data != null) {
          data = res.data ?? [];
          print("sourceList>>${data}");
        } else {
          print("No data found");
        }
      } else {
        print("Failed to fetch data");
      }
    });
  }

  List<LeadsEdit> leadseditdata=[];
  Future<void> getEdit() async {
    var res = await Userapi.getEditData(widget.id);
    setState(() {
      if (res != null) {
        if (res.leadsdata != null) {
          if(res.status==true){
            leadseditdata = res.leadsdata??[];
            for(int i=0;i<leadseditdata.length;i++){
              _DateController.text=leadseditdata[0].createdAt??"";
              _customerController.text=leadseditdata[0].customer??"";
              _companyController.text=leadseditdata[0].ogrinazation??"";
              _phoneNumberController.text=leadseditdata[0].phone.toString()??"";
              selectedValue=leadseditdata[0].label??"";
              _priceController.text=leadseditdata[0].value.toString()??"";
              _cityController.text=leadseditdata[0].town??"";
              _remarksController.text=leadseditdata[0].description??"";


              String leadsource = leadseditdata[0].leadsource ?? "";

              var selectedSource = data.firstWhere(
                    (source) => source.leadsource == leadsource,
                orElse: () => data.first,
              );

              if (selectedSource != null) {
                leadsource_id = selectedSource.lsid;
              }
            }
            print('datalead>>${leadseditdata}');
        } else {
          print("No data found");
        }
      } else {
        print("Failed to fetch data");
      }
    }});
  }


  List<Services> servicelist = [];
  Future<void> services() async {
    var res = await Userapi.getService();
    setState(() {
      if (res != null) {
        if (res.service != null) {
          servicelist = res.service ?? [];
          print("sourceList>>${servicelist}");
        } else {
          print("No data found");
        }
      } else {
        print("Failed to fetch data");
      }
    });
  }

  List<Staff> stafflist = [];
  Future<void> staff() async {
    var res = await Userapi.getStaff();
    setState(() {
      if (res != null) {
        if (res.staff != null) {
          stafflist = res.staff ?? [];
          print("sourceList>>${stafflist}");
        } else {
          print("No data found");
        }
      } else {
        print("Failed to fetch data");
      }
    });
  }
  Future<void> addLead() async {
    var data;

    try {
      if (widget.type == "Add") {
        print("add");
        data = await Userapi.addLeadData(
          _customerController.text,
          _companyController.text,
          _phoneNumberController.text,
          servicename!,
          lead_source!,
          selectedValue.toString(),
         lead_owner!,
          _priceController.text,
          _cityController.text,
          _remarksController.text,
        );
      } else {
        print("edit");
        data = await Userapi.UpdateLead(
          widget.id,
          _customerController.text,
          _companyController.text,
          _phoneNumberController.text,
          servicename!,
          lead_source!,
          selectedValue.toString(),
          lead_owner!,
          _priceController.text,
          _cityController.text,
          _remarksController.text,
        );
      }

      setState(() {
        _isLoading = false;
        if (data != null) {
          if (data.status == true) {
            CustomSnackBar.show(context, data.message);
            // Navigate after showing the snackbar
            Future.delayed(Duration(seconds: 1), () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddLeads()));
            });
          } else {
            CustomSnackBar.show(context, data.message);
          }
        } else {
          _isLoading = false;
        }
      });
    } catch (e) {
      CustomSnackBar.show(context, "An error occurred: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffF3ECFB),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            "assets/pixl.png",
            width: 89,
            height:40,fit: BoxFit.fitWidth,

          ),
        ),
        leadingWidth: 80,
        actions: [
          InkResponse(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddLeads()));
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0xff007AFF),
              ),
              child: Text('View Leads',
                  style: TextStyle(
                      color: Color(0xfffffffff),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Inter')),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${widget.type} Leads',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 21.78 / 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          _label(text: 'Lead Date'),
                          SizedBox(height: 4),
                          _buildDateField(
                            _DateController,
                          ),
                          if (_validateDate.isNotEmpty) ...[
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(bottom: 5),
                              child: ShakeWidget(
                                key: Key("value"),
                                duration: Duration(milliseconds: 700),
                                child: Text(
                                  _validateDate,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                          _label(text: 'Customer Name'),
                          SizedBox(height: 4),
                          _buildTextFormField(
                            controller: _customerController,
                            hintText: 'Enter Customer Name',
                            validationMessage: _validateCustomer,
                            keyboardType: TextInputType.text
                          ),
                          _label1(text: 'Company Name'),
                          SizedBox(height: 4),
                          _buildTextFormField(
                            controller: _companyController,
                            hintText: 'Enter Company Name',
                            validationMessage: _validateCompany,
                              keyboardType: TextInputType.text

                          ),
                          _label(text: 'Phone Number'),
                          SizedBox(height: 4),
                          _buildTextFormField(
                            controller: _phoneNumberController,
                            hintText: ' Phone Number',
                            validationMessage: _validatePhoneNumber,
                              keyboardType: TextInputType.phone

                          ),
                          SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _label(text: 'Service Required'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<Services>(
                                      isExpanded: true,
                                      hint: const Row(
                                        children: [
                                          Text(
                                            'Select service',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              color: Color(0xffAFAFAF),
                                            ),

                                          ),
                                        ],
                                      ),
                                      items: servicelist
                                          .map((service) => DropdownMenuItem(
                                                value: service,
                                                child: Text(
                                                  service.projectName ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),

                                      value: serviceid != null && serviceid != 0
                                          ? servicelist.firstWhere(
                                            (member) => member.pid == serviceid,
                                        orElse: () => servicelist[0],
                                      )
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          serviceid = value!.pid!;
                                          servicename = value!.projectName!;
                                          _validateservice="";
                                        });

                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 35,
                                        width: w * 0.4,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                            color: Color(0xffD0CBDB),
                                          ),
                                          color: Color(0xffFCFAFF),
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 25,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.black,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all(6),
                                          thumbVisibility:
                                              MaterialStateProperty.all(true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                  if (_validateservice.isNotEmpty) ...[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: ShakeWidget(
                                        key: Key("value"),
                                        duration: Duration(milliseconds: 700),
                                        child: Text(
                                          _validateservice,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(
                                width: w * 0.02,
                              ),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _label(text: 'Lead source'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<Data>(
                                      isExpanded: true,
                                      // The hint is shown when no value is selected
                                      hint: const Row(
                                        children: [
                                          Text(
                                            'Select Lead',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              color: Color(0xffAFAFAF),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      // The items to display in the dropdown
                                      items: data
                                          .map((source) => DropdownMenuItem(
                                        value: source,
                                        child: Text(
                                          source.leadsource ?? '',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      // Set the value to null initially to show the hint
                                      value: leadsource_id != null && leadsource_id != 0
                                          ? data.firstWhere(
                                            (member) => member.lsid == leadsource_id,
                                        orElse: () => data[0],
                                      )
                                          : null, // Ensure it shows the hint when no valid selection
                                      onChanged: (value) {
                                        setState(() {
                                          // Update the selected value
                                          leadsource_id = value!.lsid!;
                                          lead_source = value.leadsource!;
                                          _validateleadSource = "";
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 35,
                                        width: w * 0.4,
                                        padding: const EdgeInsets.only(left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          border: Border.all(color: Color(0xffD0CBDB)),
                                          color: Color(0xffFCFAFF),
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 25,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.black,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness: MaterialStateProperty.all(6),
                                          thumbVisibility: MaterialStateProperty.all(true),
                                        ),
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                  if (_validateleadSource.isNotEmpty) ...[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: ShakeWidget(
                                        key: Key("value"),
                                        duration: Duration(milliseconds: 700),
                                        child: Text(
                                          _validateleadSource,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _label(text: 'Priority'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: const Row(
                                        children: [
                                          Text(
                                            'Select priority',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              color: Color(0xffAFAFAF),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      items: items
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value;
                                          _validatePriority="";

                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 35,
                                        width: w * 0.4,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                            color: Color(0xffD0CBDB),
                                          ),
                                          color: Color(0xffFCFAFF),
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 25,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.black,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all(6),
                                          thumbVisibility:
                                              MaterialStateProperty.all(true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                  if (_validatePriority.isNotEmpty) ...[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: ShakeWidget(
                                        key: Key("value"),
                                        duration: Duration(milliseconds: 700),
                                        child: Text(
                                          _validatePriority,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _label(text: 'Lead owner'),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<Staff>(
                                      isExpanded: true,
                                      hint: const Row(
                                        children: [
                                          Text(
                                            'Select Staff',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              color: Color(0xffAFAFAF),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      items: stafflist
                                          .map((staff) => DropdownMenuItem(
                                        value: staff,
                                        child: Text(
                                          staff.fullname ?? '',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),

                                      value: leadowner_id != null && leadowner_id != 0
                                                ? stafflist.firstWhere(
                                     (member) => member.uid == leadowner_id,
                                            orElse: () => stafflist[0],
                                      )
                                          : null,


                                      onChanged: (value) {
                                        setState(() {
                                          leadowner_id = value!.uid!;
                                          lead_owner = value!.fullname!;
                                          _validateleadOwner="";
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 35,
                                        width: w * 0.4,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                            color: Color(0xffD0CBDB),
                                          ),
                                          color: Color(0xffFCFAFF),
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 25,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.black,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all(6),
                                          thumbVisibility:
                                              MaterialStateProperty.all(true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                  if (_validateleadOwner.isNotEmpty) ...[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: ShakeWidget(
                                        key: Key("value"),
                                        duration: Duration(milliseconds: 700),
                                        child: Text(
                                          _validateleadOwner,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _label1(text: 'Price'),
                                  _buildTextFormField1(
                                      controller: _priceController,
                                      hintText: '₹ Enter Price',
                                      validationMessage: _validatePrice),
                                ],
                              ),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _label1(text: 'City/Town'),
                                  _buildTextFormField1(
                                      controller: _cityController,
                                      hintText: 'Enter City/Town',
                                      validationMessage: _validateCity),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          _label(text: 'Remarks'),
                          SizedBox(height: 4),
                          Container(
                            height: h * 0.15,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xffE8ECFF))),
                            child: TextFormField(
                              cursorColor: Color(0xff8856F4),
                              scrollPadding: const EdgeInsets.only(top: 5),
                              controller: _remarksController,
                              textInputAction: TextInputAction.done,
                              maxLines: 100,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                hintText: "Enter Remarks",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 0,
                                  height: 1.2,
                                  color: Color(0xffAFAFAF),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                fillColor: Color(0xffFCFAFF),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xffD0CBDB)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xffD0CBDB)),
                                ),
                              ),
                            ),
                          ),
                          if (_validateRemarks.isNotEmpty) ...[
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(bottom: 5),
                              child: ShakeWidget(
                                key: Key("value"),
                                duration: Duration(milliseconds: 700),
                                child: Text(
                                  _validateRemarks,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            InkResponse(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: w * 0.43,
                decoration: BoxDecoration(
                  color: Color(0xffF8FCFF),
                  border: Border.all(
                    color: Color(0xff007AFF),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xff007AFF),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            InkResponse(
              onTap: () {
                _validateFields();
              },
              child: Container(
                height: 40,
                width: w * 0.43,
                decoration: BoxDecoration(
                  color: Color(0xff007AFF),
                  border: Border.all(
                    color: Color(0xff007AFF),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      {required TextEditingController controller,
      bool obscureText = false,
      required String hintText,
      required String validationMessage,
      required TextInputType keyboardType ,
      Widget? prefixicon,
      Widget? suffixicon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.040,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            cursorColor: Color(0xff8856F4),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              hintText: hintText,
              // prefixIcon: Container(
              //     width: 21,
              //     height: 21,
              //     padding: EdgeInsets.only(top: 10, bottom: 10, left: 6),
              //     child: prefixicon),
              suffixIcon: suffixicon,
              hintStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                letterSpacing: 0,
                height: 19.36 / 14,
                color: Color(0xffAFAFAF),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: const Color(0xffFCFAFF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd0cbdb)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd0cbdb)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd0cbdb)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd0cbdb)),
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
        if (validationMessage.isNotEmpty) ...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ShakeWidget(
              key: Key("value"),
              duration: Duration(milliseconds: 700),
              child: Text(
                validationMessage,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 15),
        ]
      ],
    );
  }

  Widget _buildTextFormField1(
      {required TextEditingController controller,
      bool obscureText = false,
      required String hintText,
      required String validationMessage,
      TextInputType keyboardType = TextInputType.text,
      Widget? prefixicon,
      Widget? suffixicon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.040,
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            cursorColor: Color(0xff8856F4),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              hintText: hintText,
              // prefixIcon: Container(
              //     width: 21,
              //     height: 21,
              //     padding: EdgeInsets.only(top: 10, bottom: 10, left: 6),
              //     child: prefixicon),
              suffixIcon: suffixicon,
              hintStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                letterSpacing: 0,
                height: 19.36 / 14,
                color: Color(0xffAFAFAF),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: const Color(0xffFCFAFF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd0cbdb)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd0cbdb)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd0cbdb)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd0cbdb)),
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
        if (validationMessage.isNotEmpty) ...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ShakeWidget(
              key: Key("value"),
              duration: Duration(milliseconds: 700),
              child: Text(
                validationMessage,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 15),
        ]
      ],
    );
  }

  Widget _buildDateField(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.04,
          child: TextField(
            controller: controller,
            readOnly: true,
            onTap: () {
              _selectDate(context, controller);
            },
            decoration: InputDecoration(
              hintText: "Date",
              suffixIcon: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Image.asset(
                    "assets/date.png",
                    color: Color(0xff000000),
                    width: 18,
                    height: 18,
                    fit: BoxFit.contain,
                  )),
              hintStyle: TextStyle(
                fontSize: 14,
                letterSpacing: 0,
                height: 1.2,
                color: Color(0xffAFAFAF),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Color(0xffFCFAFF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(width: 1, color: Color(0xffD0CBDB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: BorderSide(width: 1, color: Color(0xffD0CBDB)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  static Widget _label({required String text}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Color(0xff141516),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          ' *',
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  static Widget _label1({required String text}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Color(0xff141516),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class MeetingTypess {
  final String meetingtypevalue;

  MeetingTypess({
    required this.meetingtypevalue,
  });
}
