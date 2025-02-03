import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leads/Providers/ConnectivityProviders.dart';
import 'package:leads/Providers/ViewLeadsProviders.dart';
import 'package:leads/screens/NoInterNet.dart';
import 'package:leads/screens/SignIn.dart';
import 'package:leads/service/Preferances.dart';
import 'package:leads/service/UserApi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Provider.of<ConnectivityProviders>(context, listen: false)
        .initConnectivity();
    super.initState();
    GetLeads();
  }

  void refresh() {
    Provider.of<ViewLeadsProviders>(context, listen: false)
        .getLeadsData(context);
  }

  Future<void> GetLeads() async {
    final leadslist = Provider.of<ViewLeadsProviders>(context, listen: false);
    leadslist.getLeadsData(context);
  }

  String? selectedValue;

  @override
  void dispose() {
    Provider.of<ConnectivityProviders>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;
    var connectiVityStatus = Provider.of<ConnectivityProviders>(context);
    return (connectiVityStatus.isDeviceConnected == "ConnectivityResult.wifi" ||
            connectiVityStatus.isDeviceConnected == "ConnectivityResult.mobile")
        ? Scaffold(
            // backgroundColor: const Color(0xffF3ECFB),
            appBar: AppBar(
              backgroundColor: Color(0xff02017d),
              leading: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Center(
                    child: Text(
                      'SYNK',
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          letterSpacing: 1.2),
                    ),
                  )),
              leadingWidth: 100,
              actions: [
                IconButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkResponse(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewLeads(id: '', type: 'Add')));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xffffffff))),
                    child: Text('Add Leads',
                        style: TextStyle(
                            color: Color(0xfffffffff),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Inter')),
                  ),
                ),
              ],
            ),
            body: Consumer<ViewLeadsProviders>(
              builder: (context, leadlistprovider, child) {
                return leadlistprovider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff02017d),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(height: 20),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                refresh();
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child:
                                        NotificationListener<
                                                ScrollNotification>(
                                            onNotification: (ScrollNotification
                                                scrollInfo) {
                                              if (!leadlistprovider.isLoading &&
                                                  scrollInfo.metrics.pixels ==
                                                      scrollInfo.metrics
                                                          .maxScrollExtent) {
                                                if (leadlistprovider.hasNext) {
                                                  leadlistprovider
                                                      .getMoreLeadsData(
                                                          context);
                                                }
                                                return true;
                                              }
                                              return false;
                                            },
                                            child: CustomScrollView(
                                              slivers: [
                                                SliverList(
                                                    delegate:
                                                        SliverChildBuilderDelegate(
                                                            (context, index) {
                                                  final lead = leadlistprovider
                                                      .leadslist[index];
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        width: w,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 12,
                                                                vertical: 6),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 12,
                                                                vertical: 8),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                        0xff02017d)
                                                                    .withOpacity(
                                                                        0.2),
                                                                width: 1),
                                                            color: Color(
                                                                0xffffffff),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .calendar_month,
                                                                  size: 16,
                                                                  color: Color(
                                                                      0xff787486),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      w * 0.02,
                                                                ),
                                                                Text(
                                                                  lead.createdAt ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff371F41),
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
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
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        lead.customer ??
                                                                            "",
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xff1D1C1D),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        lead.ogrinazation ??
                                                                            "",
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xff787486),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w300),
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
                                                                  width:
                                                                      w * 0.01,
                                                                ),
                                                                InkResponse(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                ViewLeads(id: lead.leadid.toString() ?? "", type: 'Edit')));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: h *
                                                                        0.10,
                                                                    width:
                                                                        w * 0.1,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(3),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffF3F9FF),
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0xffD4DDEB),
                                                                          width:
                                                                              1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                    ),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/edit.png',
                                                                      color: Color(
                                                                          0xff02017d),
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: h * 0.03,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width:
                                                                      w * 0.28,
                                                                  height:
                                                                      h * 0.07,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    right: 10,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffFEF6EC),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                100),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                100),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                100),
                                                                        topLeft:
                                                                            Radius.circular(100)),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: w *
                                                                            0.01,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            lead.owner ??
                                                                                "",
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
                                                                  width:
                                                                      w * 0.28,
                                                                  height:
                                                                      h * 0.07,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    right: 10,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffEEF9F2),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                100),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                100),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                100),
                                                                        topLeft:
                                                                            Radius.circular(100)),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            lead.leadsource ??
                                                                                "",
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
                                                                  width:
                                                                      w * 0.28,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    right: 10,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffF3F9FF),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                                100),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                100),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                100),
                                                                        topLeft:
                                                                            Radius.circular(100)),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      ClipOval(
                                                                          child:
                                                                              Image.asset(
                                                                        'assets/rupee.png',
                                                                        width: w *
                                                                            0.08,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      )),
                                                                      SizedBox(
                                                                        width: w *
                                                                            0.01,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          lead.value?.toString() ??
                                                                              "0",
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
                                                            InkResponse(
                                                              onTap: () {
                                                                setState(() {
                                                                  _isExpanded =
                                                                      !_isExpanded;
                                                                });
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              16,
                                                                          vertical:
                                                                              8),
                                                                  width: w,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0xffD4DDEB),
                                                                          width:
                                                                              1),
                                                                      color: Color(
                                                                          0xffffffff),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child: Column(
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              lead.title ?? "",
                                                                              style: TextStyle(color: Color(0xff1C1D22), fontSize: 15, fontFamily: 'Inter'),
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
                                                                        height: h *
                                                                            0.01,
                                                                      ),
                                                                      if (_isExpanded) ...[
                                                                        // Space before description
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Divider(
                                                                              height: 0.5,
                                                                            ),
                                                                            SizedBox(
                                                                              height: h * 0.01,
                                                                            ),
                                                                            Text(
                                                                              lead.description ?? "",
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
                                                                InkResponse(
                                                                  onTap: () {
                                                                    _makePhoneCall(
                                                                        lead.phone.toString() ??
                                                                            "");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: w *
                                                                        0.71,
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            16),
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7),
                                                                      color: Color(
                                                                          0xff02017d),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          'assets/call.png',
                                                                          width:
                                                                              w * 0.08,
                                                                          height:
                                                                              h * 0.05,
                                                                          color:
                                                                              Color(0xffffffff),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              w * 0.03,
                                                                        ),
                                                                        Text(
                                                                            'CALL',
                                                                            style: TextStyle(
                                                                                color: Color(0xfffffffff),
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 18,
                                                                                fontFamily: 'Inter')),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkResponse(
                                                                  onTap: () {
                                                                    _openWhatsApp(
                                                                        lead.phone.toString() ??
                                                                            "");
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: h *
                                                                        0.10,
                                                                    width:
                                                                        w * 0.1,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(4),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      gradient:
                                                                          LinearGradient(
                                                                              colors: [
                                                                            Color(0xFF25CF43),
                                                                            Color(0xFF61FD7D),
                                                                          ]),
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0xffD4DDEB),
                                                                          width:
                                                                              1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                    ),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/wtsp.png',
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                            childCount:
                                                                leadlistprovider
                                                                    .leadslist
                                                                    .length)),
                                                SliverPadding(
                                                    padding: EdgeInsets.only(
                                                        top: 16, bottom: 16)),
                                                if (leadlistprovider
                                                    .pageLoading)
                                                  SliverToBoxAdapter(
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 0.8,
                                                      ),
                                                    ),
                                                  ),
                                                SliverPadding(
                                                    padding: EdgeInsets.only(
                                                        top: 16, bottom: 16)),
                                              ],
                                            )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          )
        : NoInternetWidget();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 4.0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Power Icon Positioned Above Dialog
                Positioned(
                  top: -35.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 6.0, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.red.shade100, // Light red background
                    ),
                    child: const Icon(
                      Icons.power_settings_new,
                      size: 40.0,
                      color: Colors.red, // Power icon color
                    ),
                  ),
                ),

                // Dialog Content
                Positioned.fill(
                  top: 30.0, // Moves content down
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15.0),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff02017d),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20.0),

                        // Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // No Button (Filled)
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color(0xff02017d), // Filled button color
                                  foregroundColor: Colors.white, // Text color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text("No"),
                              ),
                            ),

                            // Yes Button (Outlined)
                            SizedBox(
                              width: 100,
                              child: OutlinedButton(
                                onPressed: () async {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.remove('access_token');
                                  Navigator.push(
                                      context,

                                      MaterialPageRoute(
                                          builder: (context) => SignInWithEmail()));
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Color(0xff02017d), // Text color
                                  side: BorderSide(
                                      color: Color(0xff02017d)), // Border color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  // void _showLogoutDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Logout Confirmation'),
  //         content: Text('Are you sure you want to log out?'),
  //         actions: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               InkResponse(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //                   decoration: BoxDecoration(
  //                       color: Colors.grey,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: Text(
  //                     'Cancel',
  //                     style: TextStyle(
  //                         fontSize: 14,
  //                         fontFamily: 'Inter',
  //                         color: Colors.white),
  //                   ),
  //                 ),
  //               ),
  //               InkResponse(
  //                 onTap: () async {
  //                   SharedPreferences sharedPreferences =
  //                       await SharedPreferences.getInstance();
  //                   sharedPreferences.remove('access_token');
  //
  //                   Navigator.pushReplacement(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => SignInWithEmail()),
  //                   );
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       border: Border.all(color: Colors.blue)),
  //                   child: Text(
  //                     'Logout',
  //                     style: TextStyle(
  //                         fontSize: 14,
  //                         fontFamily: 'Inter',
  //                         color: Colors.blue),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
