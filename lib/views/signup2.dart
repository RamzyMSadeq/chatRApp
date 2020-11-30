import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/login.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/helper/theme.dart' as style;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'chatrooms.dart';

class SignUp2 extends StatefulWidget {
   final Function toggleView;
  SignUp2({this.toggleView});
  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController =
      new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {

    if(formKey.currentState.validate()){
      setState(() {

        isLoading = true;
      });

      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result){
            if(result != null){

              Map<String,String> userDataMap = {
                "userName" : usernameEditingController.text,
                "userEmail" : emailEditingController.text
              };

              databaseMethods.addUserInfo(userDataMap);

              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserNameSharedPreference(usernameEditingController.text);
              HelperFunctions.saveUserEmailSharedPreference(emailEditingController.text);

              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => ChatRoom()
              ));
            }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) :
       SingleChildScrollView(
      child: Container(
        //padding: EdgeInsets.all(20),
        child: AnimationLimiter(
                  child: Column(
                    
            children:AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(
                 horizontalOffset: 100.0,
                child: FadeInAnimation(
                  child: widget,
                ),
                ),
                 children: <Widget>[
            Hero(
              tag: "signup",
                          child: Container(
                margin: EdgeInsets.only(top: 50),
                height: 200,
                width: double.infinity,
                child: Center(
                  child: Image.asset('assets/images/hom.jpg')
                ),

              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 594,
              width: double.infinity,
              decoration: BoxDecoration(
                color: style.CustomTheme.secondColors,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Text("The Name" , textAlign: TextAlign.start,)),
                  Container(
                    height: 60,
                    child: TextFormField(
                      style: simpleTextStyle2(),
                      controller: usernameEditingController,
                      validator: (val){
                        return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "the Name",
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(15)) )
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Text("The Email" , textAlign: TextAlign.start,)),
                  Container(
                    height: 60,
                    child: TextFormField(
                      controller: emailEditingController,
                      style: simpleTextStyle(),
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                            null : "Enter correct email";
                      },
                      decoration:InputDecoration(
                        hintText: "The Email",
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(15)) )
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Text("The Password" , textAlign: TextAlign.start,)),
                  Container(
                    height: 60,
                    child: TextFormField(
                      obscureText: true,
                      style: simpleTextStyle(),
                      decoration: InputDecoration(
                        hintText: "The Password",
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(15)) )
                      ),
                      controller: passwordEditingController,
                      validator:  (val){
                        return val.length < 6 ? "Enter Password 6+ characters" : null;
                      },

                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      height: 70,
                      width: 380,
                      decoration: BoxDecoration(
                        color: style.CustomTheme.mainColors,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        
                      ),
                      child: FlatButton(onPressed: (){
                        singUp();
                      },
                       child: Center(
                         child: Text("SignUp", style: TextStyle(
                           fontSize: 17,
                           color: Colors.white
                           
                         ),),
                       )),
                    ),
                    SizedBox(height: 5,),
                    Text("or"),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                      height: 70,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey
                          )
                        ]
                        
                      ),
                      child: FlatButton(onPressed: (){},
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             Image.asset('assets/images/google.png',width: 25,height: 25,),


                             Text("Google", style: TextStyle(
                           fontSize: 17,
                           color: style.CustomTheme.mainColors
                           
                         ),),
                           ],
                         )
                       )),
                    ),
                    Container(
                      height: 70,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey
                          )
                        ]
                        
                      ),
                      child: FlatButton(onPressed: (){},
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             Image.asset('assets/images/facebook.png',width: 30,height: 30,),


                             Text("Facebook", style: TextStyle(
                           fontSize: 17,
                           color: style.CustomTheme.mainColors
                           
                         ),),
                           ],
                         )
                       )),
                    ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 220,
                      child: Row(
                        children: <Widget>[
                          Text("have an account ?"),
                          InkWell(
                            onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>LogIn()));
                            },
                            child: Text(" LoginIn" ,style: TextStyle(
                              color: style.CustomTheme.mainColors,
                              fontWeight: FontWeight.w700
                            ),),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
              )
              
              // Column(
              //   children: <Widget>[
              //     Container(
              //       margin: EdgeInsets.only(left: 20 , top: 20),
              //       alignment: Alignment.topLeft,
              //       child: Text("The Name" , textAlign: TextAlign.start,)),
                  
              //   ],
              // ),
            )
           
          ],
            )
          ),
        ),
      ),

      
    ),
    );
  }
}