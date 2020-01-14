import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_helper.dart';
import 'package:flutter_sqlite/models/user.dart';
import 'package:flutter_sqlite/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final ScaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;
  LoginpagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginpagePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = RaisedButton(
      onPressed: _submit,
      child: Text("Login"),
      color: Colors.green,
    );
    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Login",
          textScaleFactor: 2.0,
        ),
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(labelText: "Username"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      key: ScaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
  }

  @override
  Future onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    _showSnackBar(user.toString());
    setState(()  {
      _isLoading = false;
    });
    var db = DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    ScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
