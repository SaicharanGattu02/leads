import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:leads/service/UserApi.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/GetLeadModel.dart';
import 'AddLeads.dart';

class AddLeads extends StatefulWidget {
  const AddLeads({super.key});

  @override
  State<AddLeads> createState() => _AddLeadsState();
}

class _AddLeadsState extends State<AddLeads> {
  final List<String> items = [
    'Internal',
    'External',
  ];

  bool _isExpanded = false;
  bool isLoading = true;

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      await launchUrl(launchUri);
    } catch (e) {
      print("Could not launch $launchUri: $e");
    }
  }

  void _openWhatsApp(String phoneNumber) async {

    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '/$phoneNumber',
    );

    try {
      await launchUrl(launchUri);
    } catch (e) {
      print("Could not launch $launchUri: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    getLeadsData();
  }


  void refresh(){
    getLeadsData();
  }

  String? selectedValue;

  List<Leads> leadsData = [];

  Future<void> getLeadsData() async {
    var res = await Userapi.getLeads();

    setState(() {
       isLoading = false;
      if (res != null) {
        if (res.leads != null) {
          leadsData = res.leads ?? [];
          print("getLeadsData>>${leadsData}");
        } else {
          print("No data found");
        }
      } else {
        print("Failed to fetch data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffF3ECFB),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewLeads(id: '', type: 'Add')));
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0xff007AFF),
              ),
              child: Text('Add Leads',
                  style: TextStyle(
                      color: Color(0xfffffffff),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Inter')),
            ),
          )
        ],
      ),
      body:
          isLoading?
      Center(
        child: CircularProgressIndicator(),
      ):
      Column(
        children: [
          SizedBox(height: 15,),
          // Container(
          //   width: w,
          //   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //   decoration: BoxDecoration(
          //       color: Color(0xffffffff),
          //       borderRadius: BorderRadius.circular(8)),
          //   child: DropdownButtonHideUnderline(
          //     child: DropdownButton2<String>(
          //       isExpanded: true,
          //       hint: const Row(
          //         children: [
          //           Expanded(
          //             child: Text(
          //               'Select staff',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.w400,
          //                 fontFamily: "Inter",
          //                 color: Color(0xffAFAFAF),
          //               ),
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           ),
          //         ],
          //       ),
          //       items: items
          //           .map((String item) => DropdownMenuItem<String>(
          //                 value: item,
          //                 child: Text(
          //                   item,
          //                   style: const TextStyle(
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w400,
          //                     color: Colors.black,
          //                   ),
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ))
          //           .toList(),
          //       value: selectedValue,
          //       onChanged: (value) {
          //         setState(() {
          //           selectedValue = value;
          //           print(selectedValue);
          //         });
          //       },
          //       buttonStyleData: ButtonStyleData(
          //         height: 30,
          //         padding: const EdgeInsets.only(left: 14, right: 14),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(7),
          //           border: Border.all(
          //             color: Color(0xffD0CBDB),
          //           ),
          //           color: Color(0xffFCFAFF),
          //         ),
          //       ),
          //       iconStyleData: const IconStyleData(
          //         icon: Icon(
          //           Icons.arrow_drop_down,
          //           size: 25,
          //         ),
          //         iconSize: 14,
          //         iconEnabledColor: Colors.black,
          //         iconDisabledColor: Colors.black,
          //       ),
          //       dropdownStyleData: DropdownStyleData(
          //         maxHeight: 200,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(14),
          //           color: Colors.white,
          //         ),
          //         scrollbarTheme: ScrollbarThemeData(
          //           radius: const Radius.circular(40),
          //           thickness: MaterialStateProperty.all(6),
          //           thumbVisibility: MaterialStateProperty.all(true),
          //         ),
          //       ),
          //       menuItemStyleData: const MenuItemStyleData(
          //         height: 40,
          //         padding: EdgeInsets.only(left: 14, right: 14),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: RefreshIndicator(onRefresh:() async{
              refresh();
            },
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: leadsData.length,
                  itemBuilder: (context, index) {
                    final lead = leadsData[index];
                    return Column(
                      children: [
                        Container(
                          width: w,
                          margin: EdgeInsets.only(
                            left: 12,
                            right: 12,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 16,
                                    color: Color(0xff787486),
                                  ),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Text(
                                    lead.createdAt ?? "",
                                    style: TextStyle(
                                        color: Color(0xff371F41),
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lead.customer ?? "",
                                          style: TextStyle(
                                              color: Color(0xff1D1C1D),
                                              fontFamily: 'Inter',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          lead.ogrinazation?? "",
                                          style: TextStyle(
                                              color: Color(0xff787486),
                                              fontFamily: 'Inter',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  // Container(
                                  //   height: h * 0.10,
                                  //   width: w * 0.1,
                                  //   padding: EdgeInsets.all(1),
                                  //   decoration: BoxDecoration(
                                  //     color: Color(0xffF3F9FF),
                                  //     border: Border.all(
                                  //         color: Color(0xffD4DDEB), width: 1),
                                  //     borderRadius: BorderRadius.circular(4),
                                  //   ),
                                  //   child: Image.asset(
                                  //     'assets/google.png',
                                  //     fit: BoxFit.contain,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: w * 0.01,
                                  ),
                                  InkResponse(onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewLeads(id: lead.leadid.toString()??"", type: 'Edit')));
                    },
                                    child: Container(
                                      height: h * 0.10,
                                      width: w * 0.1,
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: Color(0xffF3F9FF),
                                        border: Border.all(
                                            color: Color(0xffD4DDEB), width: 1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Image.asset(
                                        'assets/edit.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: w * 0.28,
                                    height:h*0.07,
                                    padding: EdgeInsets.only(
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFEF6EC),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(100),
                                          topRight: Radius.circular(100),
                                          bottomLeft: Radius.circular(100),
                                          topLeft: Radius.circular(100)),
                                    ),
                                    child: Row(
                                      children: [
                                        // ClipOval(
                                        //     child: Image.asset(
                                        //   'assets/bharath.png',
                                        //   width: w * 0.08,
                                        //   fit: BoxFit.contain,
                                        // )),
                                        SizedBox(
                                          width: w * 0.01,
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              lead.owner ?? "",
                                              style: TextStyle(
                                                  color: Color(0xffCA9221),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 19.36 / 12,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: w * 0.28,
                                    height:h*0.07,
                                    padding: EdgeInsets.only(
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffEEF9F2),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(100),
                                          topRight: Radius.circular(100),
                                          bottomLeft: Radius.circular(100),
                                          topLeft: Radius.circular(100)),
                                    ),
                                    child: Row(
                                      children: [
                                        // Text(
                                        //    "Lead Source:",
                                        //   style: TextStyle(
                                        //       color: Color(0xff147324),
                                        //       fontSize: 12,
                                        //       fontWeight: FontWeight.w500,
                                        //       height: 19.36 / 12,
                                        //       overflow: TextOverflow.ellipsis,
                                        //       fontFamily: 'Inter'),
                                        // ),
                                        // ClipOval(
                                        //     child: Image.asset(
                                        //   'assets/bhanu.png',
                                        //   width: w * 0.08,
                                        //   // height: h * 0.1,
                                        //   fit: BoxFit.contain,
                                        // )),
                                        // SizedBox(
                                        //   width: w * 0.01,
                                        // ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              lead.leadsource ?? "",
                                              style: TextStyle(
                                                  color: Color(0xff147324),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 19.36 / 12,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: w * 0.28,
                                    padding: EdgeInsets.only(
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF3F9FF),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(100),
                                          topRight: Radius.circular(100),
                                          bottomLeft: Radius.circular(100),
                                          topLeft: Radius.circular(100)),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipOval(
                                            child: Image.asset(
                                          'assets/rupee.png',
                                          width: w * 0.08,
                                          fit: BoxFit.contain,
                                        )),
                                        SizedBox(
                                          width: w * 0.01,
                                        ),
                                        Expanded(
                                          child: Text(
                                            lead.value.toString() ??"",
                                            style: TextStyle(
                                                color: Color(0xff265F97),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 19.36 / 12,
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Inter'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              InkResponse(onTap: (){
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    width: w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffD4DDEB), width: 1),
                                        color: Color(0xffffffff),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        Center(

                                          child: Row(
                                            children: [
                                              Text(
                                                lead.title ?? "",
                                                style: TextStyle(
                                                    color: Color(0xff1C1D22),
                                                    fontSize: 15,
                                                    fontFamily: 'Inter'),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                size: 18,
                                                color: Color(0xff000000),
                                              )
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: h * 0.01,
                                        ),
                                        if (_isExpanded) ...[

                                           // Space before description
                                          Column( mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Divider(
                                                height: 0.5,
                                              ),
                                              SizedBox(
                                                height: h * 0.01,
                                              ),
                                              Text(
                                                lead.description??"",
                                                style: TextStyle(
                                                  color: Color(0xff787486),
                                                  fontFamily: 'Inter',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                ),

                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              Row(
                                children: [
                                  InkResponse(onTap:(){
                                    _makePhoneCall(lead.phone.toString()??"");

                                  },
                                    child: Container(
                                      width: w * 0.71,
                                      margin: EdgeInsets.only(right: 16),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Color(0xff007AFF),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/call.png',
                                            width: w * 0.08,
                                            height: h * 0.05,
                                            color: Color(0xffffffff),
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(
                                            width: w * 0.03,
                                          ),
                                          Text('CALL',
                                              style: TextStyle(
                                                  color: Color(0xfffffffff),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  fontFamily: 'Inter')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkResponse(onTap:(){
                                    _openWhatsApp(lead.phone.toString()??"");

                                  },
                                    child: Container(
                                      height: h * 0.10,
                                      width: w * 0.1,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xFF25CF43),
                                          Color(0xFF61FD7D),
                                        ]),
                                        border: Border.all(
                                            color: Color(0xffD4DDEB), width: 1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Image.asset(
                                        'assets/wtsp.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
