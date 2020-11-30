import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/views/login.dart';
import 'package:chatapp/views/signup2.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/helper/theme.dart' as style;

class SignIn2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 400,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        width: 250.0,
                        child: FadeAnimatedTextKit(
                          repeatForever: true,
                            onTap: () {
                              print("Tap Event");
                            },
                            text: [
                              "Welcome",
                              "Ramzy Chat",
                              "APP!!"
                            ],
                            textStyle: TextStyle(
                              color: style.CustomTheme.mainColors,
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            alignment: AlignmentDirectional
                                .topStart // or Alignment.topLeft
                            ),
                      ),
                      Container(
                        height: 470 ,
                        width: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/hom.jpg'),
                          //fit: BoxFit.fill
                          )
                        ),
                      )
                    ],
                  ))),
          Expanded(
              flex: 0,
              child: Container(
                height: 250,
                width: double.infinity,
                
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 350,
                      decoration: BoxDecoration(
                        color: style.CustomTheme.mainColors,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        
                      ),
                      child: Hero(
                        tag: "signup",
                          child: FlatButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>SignUp2()));
                          },
                         child: Center(
                           child: Text("SignUp" , style: TextStyle(
                             fontSize: 17,
                             color: Colors.white,

                           ),),
                         )),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 70,
                      width: 350,
                      decoration: BoxDecoration(
                        color: style.CustomTheme.fiveColors,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        
                      ),
                      child: Hero(
                        tag: "signIn",
                         child: FlatButton(onPressed: (){
                           Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>LogIn()));
                         },
                         child: Center(
                           child: Text("SignIn", style: TextStyle(
                             fontSize: 17,
                             color: Colors.lightBlue[900],
                             
                           ),),
                         )),
                      ),
                    ),
                  ],
                )
              )),
        ],
      ),
    );
  }
}
