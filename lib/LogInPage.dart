

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo_app/curveWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}


final _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();
//
// Future<String> signInWithGoogle() async {
//   await Firebase.initializeApp();
//
//   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//
//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );
//
//   final UserCredential authResult = await _auth.signInWithCredential(credential);
//   final User user = authResult.user;
//
//   if (user != null) {
//     assert(!user.isAnonymous);
//     assert(await user.getIdToken() != null);
//
//     final User currentUser = _auth.currentUser;
//     assert(user.uid == currentUser.uid);
//
//     print('signInWithGoogle succeeded: $user');
//
//     return '$user';
//   }
//
//   return null;
// }
// void signOutGoogle() async{
//   await googleSignIn.signOut();
//
//   print("User Signed Out");
// }

class _LogInState extends State<LogIn> {

  String _email;
  String password;


  String userId;
  final DatabaseRef = FirebaseDatabase.instance.reference().child('Users');



  getCurrentUser() async
  {
    final user = await _auth.currentUser;
    final uid = user.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    userId = uid;
    print('User ID:  '+userId);
    print(user.email);

  }

  void writeData() async{
    final user = await _auth.currentUser;
    DatabaseRef.child(userId).set({
      'UserEmail': user.email,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
            children: <Widget>[
              CurvedWidget(
                child: Container(
                  padding: const EdgeInsets.only(top: 100, left: 50),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.red[100], Colors.blue.withOpacity(0.5)],
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xff6a515e),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
              margin: const EdgeInsets.only(top: 230),
              // child: LoginForm(userRepository: _userRepository,),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        SizedBox(height: 10,),
                        TextField(
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter Your email...",
              hintStyle: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
              ),
            ),
            onChanged: (value){
              setState(() {
                _email = value;
              });
            },
          ),
          SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter Your password...",
              hintStyle: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
              ),
            ),
            obscureText: true,
            onChanged: (value){
              setState(() {
                password = value;
              });
            },
          ),
          SizedBox(height: 10,),
          RaisedButton(
            onPressed: () async {
              try{

                final newUser = await _auth.signInWithEmailAndPassword(email: _email, password: password);

                if (newUser != null)
                {
                  Navigator.pushNamed(context, "/home");
                  getCurrentUser();
                  writeData();
                  _email = "";
                  password = "";
                }
              }
              catch(e)
              {
                print(e.toString());
              }
            },
            child: Text("Log In"),
          ),
          SizedBox(height: 10,),
          RaisedButton(
            onPressed: () async {
              Navigator.pushNamed(context, "/signup");
            },
            child: Text("Sign Up"),
          ),
                      SizedBox(height: 10,),

        ],
      ),
    ),
               ],
            ),
      )
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         "LogIn Page",
      //         style: TextStyle(
      //             fontSize: 50,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.black
      //         ),
      //       ),
      //       SizedBox(height: 10,),
      //       TextField(
      //         decoration: InputDecoration(
      //           labelText: "Email",
      //           hintText: "Enter Your email...",
      //           hintStyle: TextStyle(
      //             color: Colors.black,
      //             fontStyle: FontStyle.normal,
      //           ),
      //         ),
      //         onChanged: (value){
      //           setState(() {
      //             _email = value;
      //           });
      //         },
      //       ),
      //       SizedBox(height: 10,),
      //       TextField(
      //         decoration: InputDecoration(
      //           labelText: "Password",
      //           hintText: "Enter Your password...",
      //           hintStyle: TextStyle(
      //             color: Colors.black,
      //             fontStyle: FontStyle.normal,
      //           ),
      //         ),
      //         obscureText: true,
      //         onChanged: (value){
      //           setState(() {
      //             password = value;
      //           });
      //         },
      //       ),
      //       SizedBox(height: 10,),
      //       RaisedButton(
      //         onPressed: () async {
      //           try{
      //
      //             final newUser = await _auth.signInWithEmailAndPassword(email: _email, password: password);
      //
      //             if (newUser != null)
      //             {
      //               Navigator.pushNamed(context, "/home");
      //               getCurrentUser();
      //               writeData();
      //               _email = "";
      //               password = "";
      //             }
      //           }
      //           catch(e)
      //           {
      //             print(e.toString());
      //           }
      //         },
      //         child: Text("Log In"),
      //       ),
      //       SizedBox(height: 10,),
      //       RaisedButton(
      //         onPressed: () async {
      //           Navigator.pushNamed(context, "/signup");
      //         },
      //         child: Text("Sign Up"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
