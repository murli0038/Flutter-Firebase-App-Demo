import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String password;

  final _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SignUp Page",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
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
                // Navigator.pushNamed(context, "/home");
                try{
                  final newUser = await _auth.createUserWithEmailAndPassword(email: _email, password: password);



                  if (newUser != null)
                    {
                      Navigator.pushNamed(context, "/login");
                      _email = "";
                      password = "";
                    }
                }
                catch(e)
                {
                  print(e.toString());
                }
              },
              child: Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
