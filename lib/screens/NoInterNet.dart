import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leads/service/CustomSnackBar.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/no_internet.png",
              width: 200,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Text(
                "Connect to the Internet",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Text(
                "You are Offline. Please Check Your Connection",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final connectivityResult = await Connectivity().checkConnectivity();
                String message;

                if (connectivityResult == ConnectivityResult.mobile) {
                  message = "Connected to Mobile Network";
                } else if (connectivityResult == ConnectivityResult.wifi) {
                  message = "Connected to WiFi";
                } else {
                  message = "No Internet Connection";
                }
                CustomSnackBar.show(context, message);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 38),
                child: Container(
                  width: 240,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color:  Color(0xff02017d),
                  ),
                  child: Center(
                    child: Text(
                      "Retry",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 20,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
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
}
