import 'package:flutter/material.dart';
import 'package:leads/Providers/ConnectivityProviders.dart';
import 'package:leads/Providers/ViewLeadsProviders.dart';
import 'package:leads/screens/SignIn.dart';
import 'package:leads/screens/Spalsh.dart';
import 'package:leads/screens/ViewLeads.dart';
import 'package:leads/screens/AddLeads.dart';
import 'package:provider/provider.dart';


void main() {
  runApp
    (MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ConnectivityProviders(),
    ),ChangeNotifierProvider(
      create: (context) => ViewLeadsProviders(),
    ),

  ],child:   const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leads',

        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          cardColor: Colors.white,
          searchBarTheme: const SearchBarThemeData(),
          tabBarTheme: const TabBarTheme(),
          dialogTheme: const DialogTheme(
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0)), // Set the border radius of the dialog
            ),
          ),
          buttonTheme: const ButtonThemeData(),
          popupMenuTheme: const PopupMenuThemeData(
              color: Colors.white, shadowColor: Colors.white),
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.white,
          ),
          cardTheme: const CardTheme(
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            color: Colors.white,
          ),

          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              // overlayColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
          bottomSheetTheme: const BottomSheetThemeData(
              surfaceTintColor: Colors.white, backgroundColor: Colors.white),
          colorScheme: const ColorScheme.light(background: Colors.white)
              .copyWith(background: Colors.white),
        ),
      home:Splash()
    );
  }
}
