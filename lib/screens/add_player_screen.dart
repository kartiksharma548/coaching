import 'package:coaching/screens/login_screen.dart';
import 'package:coaching/services/api_service.dart';
import 'package:flutter/material.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({Key? key}) : super(key: key);

  @override
  State<AddPlayer> createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPwd = TextEditingController();
  TextEditingController txtConfPwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  register() {
    if (_formKey.currentState!.validate()) {
      var obj = {
        "name": txtName.text,
        "email": txtEmail.text,
        "phone": txtPhone.text,
        "password": txtPwd.text
      };

      var res = RestUrls.register(obj);
      res
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')))
              })
          .onError((error, stackTrace) => {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please try again later.")))
              });
    }
  }

  late TextFormField name = TextFormField(
    controller: txtName,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter name';
      }
      return null;
    },
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    decoration: InputDecoration(
      icon: Icon(Icons.person),
      labelText: 'Full Name',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    ),
  );

  late TextFormField email = TextFormField(
    controller: txtEmail,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter email';
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Please enter a valid email';
      }

      return null;
    },
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    decoration: InputDecoration(
      icon: Icon(Icons.mail),
      labelText: 'Email ID',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    ),
  );

  late TextFormField number = TextFormField(
    controller: txtPhone,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter phone';
      } else if (!RegExp(r"^((\+91)?|91)?[789][0-9]{9}").hasMatch(value)) {
        return 'Please enter a valid phone no.';
      }
      return null;
    },
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    decoration: InputDecoration(
      icon: Icon(Icons.call),
      labelText: 'Mobile No.',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    ),
  );

  late TextFormField password = TextFormField(
    controller: txtPwd,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter password';
      }
      return null;
    },
    autofocus: false,
    obscureText: true,
    decoration: InputDecoration(
      icon: Icon(Icons.lock),
      labelText: 'Password',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    ),
  );

  late TextFormField conpass = TextFormField(
    controller: txtConfPwd,
    validator: (value) {
      if (value != txtPwd.text) {
        return 'Passwords does not match';
      }
      return null;
    },
    autofocus: false,
    obscureText: true,
    decoration: InputDecoration(
      icon: Icon(Icons.spellcheck),
      labelText: 'Confirm Password',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.lightBlue,
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                    ),
                  ),
                  SizedBox(width: 0.0),
                  Text(
                    'Add Player',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                  ),
                ],
              ),
            ),
            Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 40.0, right: 40.0),
                  children: <Widget>[
                    SizedBox(height: 24.0),
                    name,
                    SizedBox(height: 12.0),
                    email,
                    SizedBox(height: 12.0),
                    number,
                    SizedBox(height: 12.0),
                    password,
                    SizedBox(height: 12.0),
                    conpass,
                    SizedBox(height: 24.0),
                    Hero(
                      tag: 'hero',
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: register,
                          padding: EdgeInsets.all(12),
                          color: Colors.lightBlueAccent,
                          child: Text('Sign Up',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
