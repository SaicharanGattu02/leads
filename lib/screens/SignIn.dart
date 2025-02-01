import 'package:flutter/material.dart';
import 'package:leads/Providers/ConnectivityProviders.dart';
import 'package:leads/screens/NoInterNet.dart';
import 'package:leads/screens/ViewLeads.dart';
import 'package:leads/service/Preferances.dart';
import 'package:leads/service/UserApi.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'ShakeWidget.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({super.key});

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _focusNodePassword = FocusNode();

  bool _obscurePassword = true;
  String validateEmail = "";
  String validatePassword = "";
  bool _loading = false;

  void _validateFields() {
    setState(() {
      _loading = true;
      validateEmail =
          !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(_emailController.text)
              ? "Please enter a valid email"
              : "";
      validatePassword = _passwordController.text.isEmpty
          ? "Please enter a valid password"
          : "";

      if (validateEmail.isEmpty && validatePassword.isEmpty) {
        LoginWithEmail();
      } else {
        _loading = false;
      }
    });
  }

  Future<void> LoginWithEmail() async {
    setState(() {
      _loading = true;
    });
    var res = await Userapi.SignIn(
        _emailController.text, _passwordController.text, context);
    setState(() {
      _loading = false;
      if (res?.accessToken != null) {
        int currentTimestampInSeconds =
            DateTime.now().millisecondsSinceEpoch ~/ 1000;
        int expiryTimestamp = currentTimestampInSeconds + (res?.expiresIn ?? 0);
        PreferenceService().saveString('access_token', res?.accessToken ?? '');
        PreferenceService().saveInt('user_id', res?.userId?? 0);
        PreferenceService().saveInt('expiry_time', expiryTimestamp);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddLeads()),
        );
      } else {
        // Handle error or failure to sign in (if needed)
        print("Login failed or access token is empty");
      }
    });
  }

  @override
  void initState() {
    Provider.of<ConnectivityProviders>(context, listen: false)
        .initConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<ConnectivityProviders>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var connectiVityStatus = Provider.of<ConnectivityProviders>(context);
    return (connectiVityStatus.isDeviceConnected == "ConnectivityResult.wifi" ||
            connectiVityStatus.isDeviceConnected == "ConnectivityResult.mobile")
        ? Scaffold(
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 40,
                  // ),

                  Lottie.asset(
                    'assets/animations/signin.json',
                    height: h * 0.37,
                    width: w * 0.65,
                  ),

                  // Image.asset(
                  //   "assets/syn",
                  //   width: 120,
                  //   height: 55,
                  //   fit: BoxFit.fitWidth,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text('Sign In',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 18),),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.01),
                        TextFormField(
                          onTap: () {
                            setState(() {
                              validateEmail = "";
                            });
                          },
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            hintText: 'Email ID',
                            hintStyle: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              color: Color(0xff617C9D),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xff617C9D),
                            ),
                            fillColor: const Color(0xffFCFAFF),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xffd0cbdb)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xffd0cbdb)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xffd0cbdb)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xffd0cbdb)),
                            ),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                        if (validateEmail.isNotEmpty) ...[
                          Container(
                            alignment: Alignment.topLeft,
                            margin:
                                EdgeInsets.only(left: 8, bottom: 10, top: 5),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ShakeWidget(
                              key: Key("value"),
                              duration: Duration(milliseconds: 700),
                              child: Text(
                                validateEmail,
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
                        ],
                        _buildTextFormField(
                          controller: _passwordController,
                          focusNode: _focusNodePassword,
                          hintText: "Password",
                          obscureText: _obscurePassword,
                          validationMessage: 'Please enter your password',
                          toggleObscure: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        if (validatePassword.isNotEmpty) ...[
                          Container(
                            alignment: Alignment.topLeft,
                            margin:
                                EdgeInsets.only(left: 8, bottom: 10, top: 5),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ShakeWidget(
                              key: Key("value"),
                              duration: Duration(milliseconds: 700),
                              child: Text(
                                validatePassword,
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
                        ],
                        SizedBox(
                          height: h * 0.02,
                        ),
                        // containertext(
                        //   context,
                        //   'CONTINUE',
                        //   isLoading: _loading,
                        //   onTap: () {
                        //     if (_loading) {
                        //     } else {
                        //       _validateFields();
                        //     }
                        //   },
                        // ),
                        InkResponse(
                          onTap: () {
                            if (_loading) {
                            } else {
                              _validateFields();
                            }
                          },
                          child: Container(
                            width: w,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff02017d)),
                            child: Center(
                                child: _loading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'CONTINUE',
                                        style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : NoInternetWidget();
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required String validationMessage,
    bool obscureText = false,
    Widget? prefixIcon,
    required VoidCallback toggleObscure,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      onTap: () {
        setState(() {
          validatePassword = '';
        });
      },
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.lock,
          color: Color(0xff617C9D),
          size: 22,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Color(0xffAFAFAF),
            size: 18,
          ),
          onPressed: toggleObscure,
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          letterSpacing: 0,
          height: 19.36 / 14,
          color: Color(0xff617C9D),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: const Color(0xffFCFAFF),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(width: 1, color: Color(0xffd0cbdb)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(width: 1, color: Color(0xffd0cbdb)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(width: 1, color: Color(0xffd0cbdb)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(width: 1, color: Color(0xffd0cbdb)),
        ),
      ),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
