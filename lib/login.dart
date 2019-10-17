import 'package:flutter/material.dart';
import 'package:flutter_app/models/usermodel.dart';
import 'package:flutter_app/services/userservice.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formLoginKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();
  UserModel userModel = UserModel();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue, Colors.green]),
              ),
            ),
            ListView(
              children: <Widget>[
                generateLoginForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget generateLoginForm() {
    return Card(
      margin: EdgeInsets.only(top: 80, left: 30, right: 30),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formLoginKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "assets/cryptoicon.png",
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "COIN DEMO",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 22,
              ),
              generateUsernameInput(),
              SizedBox(
                height: 8,
              ),
              generatePasswordInput(),
              SizedBox(
                height: 28,
              ),
              generateSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget generateUsernameInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'example@gmail.com',
        icon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter email";
        }

        if (!isEmail(value)) {
          return "Invalid email format";
        }

        return null;
      },
      onSaved: (String value) {
        userModel.username = value;
      },
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
    );
  }

  Widget generatePasswordInput() {
    return TextFormField(
      focusNode: passwordFocusNode,
      decoration: InputDecoration(
        labelText: "Password",
        icon: Icon(Icons.lock),
      ),
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter password";
        }
        if (value.length < 8) {
          return "Password nust be at least 8 charactors";
        }
        return null;
      },
      onSaved: (value) {
        userModel.password = value;
      },
    );
  }

  Widget generateSubmitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          if (formLoginKey.currentState.validate()) {
            formLoginKey.currentState.save();

            userService.login(userModel: userModel).then((result) {
              if (result) {
                Navigator.pushReplacementNamed(context, "home");
              } else {
                showAlertDialog();
              }
            });
          }
        },
        child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Username or Password is incorrect"),
            content: Text("Please Try Again"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }
}
