import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/login_screen.dart';
import 'package:chat_app/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'background_image.dart';
import 'constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class Welcome_Screen extends StatefulWidget {
  static const String id='welcomescreen';
  const Welcome_Screen({Key? key}) : super(key: key);

  @override
  State<Welcome_Screen> createState() => _Welcome_ScreenState();
}

class _Welcome_ScreenState extends State<Welcome_Screen> {
  // late final AnimationController _controller;
  // late final Animation animation;
  // @override
  // void initState() {
  //   _controller=AnimationController(vsync: this,
  //       duration: Duration(seconds: 2));
  //   _controller.forward();
  //   _controller.addListener(() {
  //     setState((){});
  //   });
  //
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backGroundImage,
        Scaffold(
          backgroundColor:Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: [
                      const Hero(
                        tag: 'logo',
                        child: Image(
                          image: AssetImage('images/newlogo.png'),
                          height: 150,
                          width: 150,
                        ),
                      ),
                      AnimatedTextKit(
                        repeatForever: false,
                        animatedTexts: [
                        WavyAnimatedText('Welcome to Ranchat',
                        textStyle: title.copyWith(
                              color: Colors.black.withOpacity(0.7),),),
                      ],
                        isRepeatingAnimation: false,
                      ),
                      AnimatedTextKit(
                          animatedTexts: [TypewriterAnimatedText('Where your privacy is prior',textStyle: title.copyWith(
                               color: Colors.black45,
                               fontSize: 20,
                               fontStyle: FontStyle.italic),
                            speed: Duration(milliseconds: 500),
                         ),
                          ],
                        isRepeatingAnimation: true,

                      ),

                      // Text(
                      //   'Where your privacy is prior',
                      //   style:
                    ],
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      height: 20,
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'Register',
                        style: title.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () async{
                        SharedPreferences sp=await SharedPreferences.getInstance();
                        bool isLogin=sp.getBool('isLogin')??false;
                        if(isLogin)
                        {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        else{
                          Navigator.pushNamed(context, Signup.id);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Material(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      height: 20,
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'Login',
                        style: title.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () async{
                        SharedPreferences sp=await SharedPreferences.getInstance();
                         bool isLogin=sp.getBool('isLogin')??false;
                        if(isLogin)
                          {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                        else{
                          Navigator.pushNamed(context, Login.id);
                        }

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
