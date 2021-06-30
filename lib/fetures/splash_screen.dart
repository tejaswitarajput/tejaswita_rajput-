import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_employee_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTimeOpen = false;
//  Box<bool> loginBoolBox;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(create: (context) => SignInProvider()),
    //       ChangeNotifierProvider(create: (context) => DoctorFormProvider()),
    //       ChangeNotifierProvider(create: (context) => NotificationRepository()),
    //
    //     ],
    return Scaffold(body: HomeScreen());
  }

  // else {
  // return Center(child: CircularProgressIndicator());
  //   }

  // );

}
