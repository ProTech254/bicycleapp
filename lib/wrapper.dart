import 'package:bicycleapp/app_screens/homepage.dart';
import 'package:bicycleapp/app_screens/login.dart';
import 'package:bicycleapp/app_screens/register.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool logged_in = false;
  Future<void> main() async {

    // var user = await FlutterSession().get("user_id");
    //
    // if(user != null){
    //   setState(() {
    //     logged_in = true;
    //   });
    // }
    // print(user);


  }
  @override
  Widget build(BuildContext context) {

    return logged_in ? BicycleList():LoginPage();
  }
}
