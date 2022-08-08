import 'package:chat_app/background_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_screen.dart';
import 'constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class Signup extends StatefulWidget {
  static const String id='signupscreen';
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  bool loading=false;
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
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.85,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
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
                            'Sign Up',
                            style: title.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () async {
                            try {
                              setState((){
                                loading=true;
                              });
                              final newuser = await _auth
                                  .createUserWithEmailAndPassword(
                                  email: email, password: password);
                              if(newuser!=null){
                                SharedPreferences sp=await SharedPreferences.getInstance();
                                sp.setString('email', email);
                                sp.setString('password', password);
                                sp.setBool('isLogin', true);
                                Navigator.pushNamed(context, ChatScreen.id);
                                setState((){
                                  loading=false;
                                });
                              }
                              else{
                                Navigator.pushNamed(context, Signup.id);
                                setState((){
                                  loading=false;
                                });
                              }
                            }
                            catch(e){

                            }
                            //
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