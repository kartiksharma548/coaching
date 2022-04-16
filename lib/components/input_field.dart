import 'package:coaching/components/button.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  InputField({Key? key}) : super(key: key);
  final GlobalKey<InputFieldState> key = new GlobalKey();
  @override
  State<InputField> createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  final loginForm = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();

  TextEditingController txtPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: loginForm,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
              child: TextFormField(
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
                decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
              child: TextFormField(
                controller: txtPwd,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Button(loginForm, widget.key)
          ],
        ));
  }
}
