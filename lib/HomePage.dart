import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List lists = [];
  final dbRef = FirebaseDatabase.instance.reference().child("Users");

  Future <void> fetchData() async {
    var db = FirebaseDatabase.instance.reference().child("Users");
    await db.once().then((DataSnapshot snapshot){
      lists.clear();
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values)
      {
        // print(values["UserEmail"]);
        lists.add(values);
        print(lists);
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchData();
    // setState(() {
    //
    // });
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.red[100],
          child: Column(
            children: [
              Text("WelCome to Home Page !"),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 20),
                child: FutureBuilder(
                    future: dbRef.once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        lists.clear();
                        Map<dynamic, dynamic> values = snapshot.data.value;
                        values.forEach((key, values) {
                          lists.add(values);
                        });
                        return new ListView.builder(
                            shrinkWrap: true,
                            itemCount: lists.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Emails: " + lists[index]["UserEmail"]),

                                  ],
                                ),
                              );
                            });
                      }
                      return CircularProgressIndicator();
                    }),
              ),
              SizedBox(height: 20,),
              RaisedButton(
                child: Text("Logout"),
                onPressed: () async {
                  try{
                   await _auth.signOut();
                   Navigator.pushNamed(context, "/login");
                  }
                  catch(e)
                  {
                    print(e.toString());
                  }

                },
              )
            ],
          ),

        ),
      ),
    );
  }
}
