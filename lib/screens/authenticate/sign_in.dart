import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/shared/Loading.dart';
import 'package:project/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[400],
            appBar: AppBar(
              backgroundColor: Colors.green[800],
              elevation: 0.0,
              title: Text('Sign in to Don\'t Forget'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: widget.toggleView,
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                ),
              ],
            ),
            body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.green[800], Colors.green[100]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) => val.length < 6
                              ? 'Please enter a password 6+ chars long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.green[800],
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'could not sign in with those credentials';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
