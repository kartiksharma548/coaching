import 'dart:convert';
import 'dart:io';
import 'package:coaching/components/input_field.dart';
import 'package:coaching/globals.dart';
import 'package:coaching/models/user_model.dart';
import 'package:coaching/services/api_service.dart';
import 'package:coaching/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Button extends StatefulWidget {
  final StorageService _storageService = StorageService();

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
      res
          .then((value) => {postLoginProcess(value)})
          .onError((error, stackTrace) => {
                snackbarKey.currentState?.showSnackBar(
                    SnackBar(content: Text("Please try again later.")))
              });
    }
  }

  postLoginProcess(Response val) async {
    try {
      // Map<String, dynamic> mapJson = jsonDecode(val.body);
      if (val.statusCode == 200) {
        UserModel um = UserModel.fromJson(jsonDecode(val.body));
        logindata?.setBool('login', true);
        logindata?.setInt("user_id", um.data?.id ?? -1);
        final StorageItem item = StorageItem("token", um.access_token);
        widget._storageService.writeSecureData(item);
        snackbarKey.currentState
            ?.showSnackBar(SnackBar(content: Text("Logged In.")));
      } else {
        snackbarKey.currentState
            ?.showSnackBar(SnackBar(content: Text("Please try again.")));
      }
    } catch (e) {
      print(e);
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
