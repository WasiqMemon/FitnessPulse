import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';

class LoginScreen2 extends StatefulWidget {
  final Color? backgroundColor1;
  final Color? backgroundColor2;
  final Color? highlightColor;
  final Color? foregroundColor;
  final AssetImage? logo;

  LoginScreen2({
    Key? k,
    this.backgroundColor1 = const Color(0xFF444152),
    this.backgroundColor2 = const Color(0xFF6f6c7d),
    this.highlightColor = Colors.deepPurple,
    this.foregroundColor = Colors.white,
    this.logo = const AssetImage("./assets/images/logo.png"),
  });

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final Map<String, String> _loginUserData = {
    'email': '',
    'password': '',
  };

  final emailController = TextEditingController();
  final pswdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _submit() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = pswdController.text;

      _loginUserData['email'] = email;
      _loginUserData['password'] = password;

      AuthController.login(_loginUserData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: new Alignment(
                  1.0, 0.0), // 10% of the width, so there are ten blinds.
              colors: [
                this.widget.backgroundColor1!,
                this.widget.backgroundColor2!
              ], // whitish to gray
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 110.0, bottom: 50.0),
                child: Center(
                  child: new Column(
                    children: <Widget>[
                      SizedBox(height: 100),
                      new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Text(
                          "FitnessPulse",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.deepPurple,
                                  offset: Offset(5, 5),
                                )
                              ],
                              letterSpacing: 5,
                              color: Colors.deepPurpleAccent,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: this.widget.foregroundColor!,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, right: 00.0),
                          child: Icon(
                            Icons.alternate_email,
                            color: this.widget.foregroundColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'email',
                              hintStyle:
                                  TextStyle(color: this.widget.foregroundColor),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Invalid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: this.widget.foregroundColor!,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, right: 00.0),
                          child: Icon(
                            Icons.lock_open,
                            color: this.widget.foregroundColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            controller: pswdController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'password',
                              hintStyle:
                                  TextStyle(color: this.widget.foregroundColor),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password field is empty!';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 30.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  this.widget.highlightColor as Color),
                            ),
                            onPressed: _submit,
                            child: Text(
                              "Log In",
                              style:
                                  TextStyle(color: this.widget.foregroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () => {},
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                              color: this
                                  .widget
                                  .foregroundColor!
                                  .withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
