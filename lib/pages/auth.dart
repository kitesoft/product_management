import "package:flutter/material.dart";
import "./products.dart";

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }
}

class _AuthPageState extends State<StatefulWidget> {
  String email = '';
  String password = '';

  _loginContainer() {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // username
              TextField(
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (value) {
                    setState(() {
                      this.email = value;
                    });
                  }),

              // password
              TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  onChanged: (value) {
                    setState(() {
                      this.password = value;
                    });
                  }),

              // login button
              Container(
                padding: EdgeInsets.only(top: 15.0),
                child: RaisedButton(
                  child: Text("Login"),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/products');
                  },
                ),
              ),
            ]));
  } //login container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body
        body: _loginContainer());
  }
}
