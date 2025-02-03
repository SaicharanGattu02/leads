import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leads/Providers/ConnectivityProviders.dart';
import 'package:leads/model/SignInModel.dart';
import 'package:leads/screens/NoInterNet.dart';
import 'package:leads/screens/SignIn.dart';
import 'package:leads/screens/ViewLeads.dart';
import 'package:leads/service/Preferances.dart';
import 'package:leads/service/UserApi.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String token = "";
  @override
  void initState() {
    Fetchdetails();
    super.initState();
    _initAsync();
  }

  Fetchdetails() async {
    var Token = (await PreferenceService().getString('access_token')) ?? "";
    setState(() {
      token = Token;
    });
    print("Token:${token}");

  }

  Future<void> _initAsync() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return (token!='') ? ViewLeads() : SignInWithEmail();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xff02017d),
            body: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/synk.png",
                  width: 200,
                  height: 55,
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ));

  }
}
