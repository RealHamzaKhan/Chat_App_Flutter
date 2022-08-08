import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/loadingscreen.dart';
import 'package:chat_app/login_screen.dart';
import 'package:chat_app/signup_screen.dart';
import 'package:chat_app/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: Loading_Screen.id,
      routes: {
       Login.id:(context)=>const Login(),
        Signup.id:(context)=>const Signup(),
        Loading_Screen.id:(context)=>const Loading_Screen(),
        Welcome_Screen.id:(context)=>const Welcome_Screen(),
        ChatScreen.id:(context)=>const ChatScreen(),
      },
    );
  }
}

