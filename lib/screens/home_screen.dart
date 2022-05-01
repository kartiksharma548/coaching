import 'dart:async';

import 'package:coaching/screens/splash_screen.dart';
import 'package:coaching/services/storage_service.dart';
import 'package:coaching/utilities_class/curve_painter.dart';
import 'package:flutter/material.dart';
import 'package:coaching/models/home_tiles_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? logindata;
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    checkifalreadylogin();
  }

  void checkifalreadylogin() async {
    logindata = await SharedPreferences.getInstance();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //       Duration(seconds: 5),
  //       () => Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => SplashScreen())));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        children: [
          Container(
              //color: Colors.blueGrey,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: CurvePainter(),
                //size: Size.fromHeight(50),
              )),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 87, 148, 194),
                child: Icon(Icons.add_circle_outline_sharp),
                elevation: 0.1,
                onPressed: () {}),
          )
        ],
      ),
      appBar: AppBar(
        title: Center(
            child: Text('coaching Guru',
                style: TextStyle(fontFamily: 'Cookie', fontSize: 30))),
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        itemCount: HomeTiles.tileList.length,
        itemBuilder: (context, index) => ItemTile(HomeTiles.tileList[index]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //childAspectRatio: 2,
        ),
      ),
    );
  }

  Widget ItemTile(HomeTiles item) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
            onTap: (() {
              if (item.tag == "logout") {
                clearPref();
              }
              Navigator.pushNamed(context, item.route ?? "/login");
            }),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(item.imgPath ?? "")),
                  Text(item.title.toString())
                ],
              ),
            )));
  }

  clearPref() async {
    await logindata?.clear();
    await _storageService.deleteAllSecureData();
  }
}
