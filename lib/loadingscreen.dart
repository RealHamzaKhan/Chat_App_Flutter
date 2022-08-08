import 'dart:async';
import 'package:chat_app/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading_Screen extends StatefulWidget {
  static final String id='loading_screen';
  const Loading_Screen({Key? key}) : super(key: key);

  @override
  State<Loading_Screen> createState() => _Loading_ScreenState();
}

class _Loading_ScreenState extends State<Loading_Screen> {
  @override
  void initState(){
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, Welcome_Screen.id);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitThreeInOut(
          color: Colors.pink,
          size: 70,
          duration: Duration(seconds: 4),
        ),
      ),
    );
  }
}
