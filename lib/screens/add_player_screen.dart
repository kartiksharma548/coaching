import 'package:coaching/screens/login_screen.dart';
import 'package:coaching/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({Key? key}) : super(key: key);

  @override
  State<AddPlayer> createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  SharedPreferences? logindata;

  @override
  void initState() {
    super.initState();
    checkifalreadylogin();
  }

  void checkifalreadylogin() async {
    logindata = await SharedPreferences.getInstance();
  }

  TextEditingController txtName = TextEditingController();
  TextEditingController txtdob = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  addPlayer() {
    if (_formKey.currentState!.validate()) {
      var obj = {
        "user_id": logindata?.getInt("user_id"),
        "name": txtName.text,
        "dob": txtdob.text,
      };

      var res = RestUrls.addPlayer(obj);
      res
          .then((value) => {postAddPlayerProcess(value)})
          .onError((error, stackTrace) => {});
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
    //keyboardType: TextInputType.emailAddress,
    autofocus: false,
    decoration: InputDecoration(
      icon: Icon(Icons.person),
      labelText: 'Full Name',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    ),
  );
  late TextFormField dob = TextFormField(
    controller: txtdob,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter dob';
      }
      return null;
    },
    readOnly: true,
    //keyboardType: TextInputType.datetime,
    autofocus: false,
    onTap: () => _selectDate(context),
    decoration: InputDecoration(
      icon: Icon(Icons.date_range),
      labelText: 'Date of Birth',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    ),
  );
  // late ElevatedButton datePicker = ElevatedButton(
  //   onPressed: () {
  //     _selectDate(context);
  //   },
  //   child: Text("Choose Date"),
  // );
  postAddPlayerProcess(Response value) {
    if (value.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Player Added')));

      setState(() {
        txtdob.text = "";
        txtName.text = "";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please try again later.")));
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        txtdob.text =
            "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      });
  }

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
                    dob,
                    SizedBox(height: 24.0),
                    Hero(
                      tag: 'hero',
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: addPlayer,
                          padding: EdgeInsets.all(12),
                          color: Colors.lightBlueAccent,
                          child: Text('Add Player',
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
