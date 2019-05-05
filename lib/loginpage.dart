import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
/* import 'package:flutter_auth_buttons/flutter_auth_buttons.dart'; */
import 'services/usermanagement.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  FacebookLogin fbLogin = FacebookLogin();

  /* FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged = false;

  FirebaseUser myUser;

  Future<FirebaseUser> _loginWithFacebook() async{
    var facebookLogin = FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);

    if(result.status == FacebookLoginStatus.loggedIn) {
      FirebaseUser user = await _auth.signInWithCredential(FacebookAuthProvider.getCredential(accessToken: result.accessToken.token) );
    }
  } */

  //Facebook SignIn Object
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  }),
              SizedBox(height: 15.0),
              TextField(
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Login'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((FirebaseUser user) {
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
              SizedBox(height: 15.0),

              RaisedButton(
                child: Text('Login with Facebook'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  fbLogin.logInWithReadPermissions(['email', 'public_profile'])
                  .then((result) {
                    switch (result.status) {
                      case FacebookLoginStatus.loggedIn:
                        FirebaseAuth.instance.signInWithCredential(FacebookAuthProvider.getCredential(accessToken: result.accessToken.token))
                        .then((signedInUser) {
                          print('Signed in as ${signedInUser.displayName}');
                          UserManagementFb().storeNewUser(signedInUser, context);
                          Navigator.of(context).pushReplacementNamed('/homepage');
                        }).catchError((e) {
                          print(e);
                        });
                        
                        break;
                      default:
                    }
                  })
                  .catchError((e) {
                    print(e);
                  });
                },
              ),
              SizedBox(height: 15.0),

              RaisedButton(
                child: Text('LOG IN WITH PHONE NUMBER'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  
                },
              ),
              SizedBox(height: 15.0),

              Text('Don\'t have an account?'),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text('Sign Up'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  Navigator.of(context).pushNamed('/signup');
                },
              ),
            ],
          )),
    ));
  }
}