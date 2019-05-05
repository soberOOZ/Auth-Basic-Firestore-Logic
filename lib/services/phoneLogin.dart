import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneNumberLogin extends StatefulWidget {
  @override
  _PhoneNumberLoginState createState() => _PhoneNumberLoginState();
}

class _PhoneNumberLoginState extends State<PhoneNumberLogin> {

  String phoneNo;
  String smsCode;
  String verificationId;
  

  Future<void> verifyPhone() async {

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      codeAutoRetrievalTimeout: autoRetrieve
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Number is"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: 'Enter you Number..'),
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
              SizedBox(height: 10.0,),
              RaisedButton(
                onPressed: verifyPhone,
                child: Text("Verify"),
                textColor: Colors.white,
                elevation: 7.0,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}