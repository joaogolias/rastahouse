import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _resetPasswordSnackBar =
      SnackBar(content: Text('Verifique o seu e-mail :)'));

  String _nicknameError;
  String _passwordError;

  @override
  void dispose() {
    _nicknameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String nicknameValidator() {
    if (_nicknameController.text.isEmpty) {
      return 'Coloque seu nickname';
    }
    return null;
  }

  String passwordValidator() {
    if (_passwordController.text.isEmpty) {
      return 'Coloque sua senha';
    } else if (_passwordController.text.length < 6) {
      return 'A senha deve conter, no mínimo, 6 caracteres';
    }
    return null;
  }

  bool validate() {
    String nicknameError = nicknameValidator();
    String passwordError = passwordValidator();
    setState(() {
      _nicknameError = nicknameError;
      _passwordError = passwordError;
    });

    return nicknameError.isNotEmpty && passwordError.isNotEmpty;
  }

  void onLoginClick() {
    if (validate()) {
      performLogin();
    }
  }

  void performLogin() {
    validate();
  }

  Function onForgotPasswordClick(BuildContext context) => () {
        Scaffold.of(context).showSnackBar(_resetPasswordSnackBar);
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
            builder: (context) => Form(
                key: _formKey,
                autovalidate: true,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          key: Key("nickname"),
                          controller: _nicknameController,
                          decoration: InputDecoration(
                              errorText: _nicknameError, labelText: "Nickname"),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          key: Key("password"),
                          controller: _passwordController,
                          decoration: InputDecoration(
                              errorText: _passwordError, labelText: "Senha"),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(top: 16),
                        child: RaisedButton(
                          onPressed: onLoginClick,
                          child: Text("Login"),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(top: 16),
                        child: Center(
                            child: InkWell(
                          child: Text("Esqueci minha senha"),
                          onTap: onForgotPasswordClick(context),
                        ))),
                  ],
                )))));
  }
}
