import 'package:coaching/components/input_field.dart';
import 'package:coaching/globals.dart';
import 'package:coaching/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Button extends StatefulWidget {
  GlobalKey<InputFieldState> inputkey;
  var loginForm = GlobalKey<FormState>();
  Button(this.loginForm, this.inputkey, {Key? key}) : super(key: key);

  @override
  State<Button> createState() => _Button();
}

class _Button extends State<Button> {
  SharedPreferences? logindata;

  String email = "";
  String pwd = "";

  @override
  void initState() {
    super.initState();
    checkifalreadylogin();
  }

  void checkifalreadylogin() async {
    logindata = await SharedPreferences.getInstance();
  }

  register() {
    if (widget.loginForm.currentState!.validate()) {
      var emailVal = widget.inputkey.currentState!.txtEmail.text.toString();
      var pwdVal = widget.inputkey.currentState!.txtPwd.text.toString();

      var obj = {"email": emailVal, "password": pwdVal};
      var res = RestUrls.login(obj);
      res.then((value) => {postLoginProcess()}).onError((error, stackTrace) => {
            snackbarKey.currentState?.showSnackBar(
                SnackBar(content: Text("Please try again later.")))
          });
    }
  }

  postLoginProcess() {
    logindata?.setBool('login', true);
    snackbarKey.currentState
        ?.showSnackBar(SnackBar(content: Text("Logged In.")));
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
