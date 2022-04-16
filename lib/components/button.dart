import 'package:coaching/components/input_field.dart';
import 'package:coaching/globals.dart';
import 'package:coaching/services/api_service.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  var loginForm = GlobalKey<FormState>();
  String email = "";
  String pwd = "";
  GlobalKey<InputFieldState> inputkey;
  Button(this.loginForm, this.inputkey, {Key? key}) : super(key: key);

  register() {
    if (loginForm.currentState!.validate()) {
      var emailVal = inputkey.currentState!.txtEmail.text.toString();
      var pwdVal = inputkey.currentState!.txtPwd.text.toString();

      var obj = {"email": emailVal, "password": pwdVal};
      var res = RestUrls.login(obj);
      res
          .then((value) => {
                snackbarKey.currentState
                    ?.showSnackBar(SnackBar(content: Text("Logged In.")))
              })
          .onError((error, stackTrace) => {
                snackbarKey.currentState?.showSnackBar(
                    SnackBar(content: Text("Please try again later.")))
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.cyan[500],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: GestureDetector(
            onTap: (() {
              register();
            }),
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
