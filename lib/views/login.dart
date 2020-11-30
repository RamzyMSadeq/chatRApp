import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatrooms.dart';
import 'package:chatapp/views/signup2.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:chatapp/helper/theme.dart' as style;

class LogIn extends StatefulWidget {
  final Function toggleView;

  LogIn({this.toggleView});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          :
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
              tag: "signIn",
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
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val)
                                ? null
                                : "Please Enter Correct Email";
                          },
                          controller: emailEditingController,
                          style: simpleTextStyle(),
                          decoration: InputDecoration(
                        hintText: "the password",
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
                          validator: (val) {
                            return val.length > 6
                                ? null
                                : "Enter Password 6+ characters";
                          },
                          style: simpleTextStyle(),
                          controller: passwordEditingController,
                          decoration: InputDecoration(
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(15)) )
                      )
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
                        signIn();
                      },
                       child: Center(
                         child: Text("SignIn", style: TextStyle(
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
                      width: 260,
                      child: Row(
                        children: <Widget>[
                          Text("don't have an account ?"),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>SignUp2()));
                            },
                            child: Text(" SignUp" ,style: TextStyle(
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