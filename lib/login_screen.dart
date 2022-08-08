import 'package:chat_app/background_image.dart';
import 'package:chat_app/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
class Login extends StatefulWidget {
  static const String id='loginscreen';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading=false;
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  Color mycolor=Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backGroundImage,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ModalProgressHUD(
            inAsyncCall: loading,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Column(
                        children: const [
                          Hero(
                            tag: 'logo',
                            child: Image(
                              image: AssetImage('images/newlogo.png'),
                              height: 250,
                              width: 250,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100,),
                    Text('Wrong Credentials*',style: TextStyle(color: mycolor),),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.85,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (value){
                          email=value;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 20),
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.purple,width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.purple,width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.85,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: true,
                        onChanged: (value){
                          password=value;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 20),
                          hintText: 'Enter your Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.purple,width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.purple,width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
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
                          onPressed: ()async{
                            try{
                              setState((){
                                loading=true;
                              });
                              final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                              if(user!=null)
                                {
                                  mycolor=Colors.transparent;
                                  setState((){});
                                  SharedPreferences sp= await SharedPreferences.getInstance();
                                  sp.setString('email', email);
                                  sp.setString('password', password);
                                  sp.setBool('isLogin', true);

                                  Navigator.pushNamed(context, ChatScreen.id);

                                }
                              setState((){
                                loading=false;
                              });
                            }
                            catch(e){
                              setState((){
                                loading=false;
                              });
                              mycolor=Colors.red;
                              setState((){});
                            }

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
