import 'dart:convert';

import 'package:coaching/models/player_model.dart';
import 'package:coaching/screens/player_profile_screen.dart';
import 'package:coaching/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchPlayerScreen extends StatefulWidget {
  const SearchPlayerScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlayerScreen> createState() => _SearchPlayerScreenState();
}

class _SearchPlayerScreenState extends State<SearchPlayerScreen> {
  TextEditingController txtSearch = TextEditingController();
  Future<List<PlayerModel>>? _futureList;
  List<PlayerModel> playerList = [];
  List<PlayerModel> playerTempList = [];

  @override
  void initState() {
    super.initState();

    _futureList = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            onChanged: ((value) {
              filterSearchResults(value);
            }),
            controller: txtSearch,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: GestureDetector(
                    child: Icon(Icons.clear),
                    onTap: () {
                      txtSearch.text = "";
                      setState(() {
                        _futureList = getProducts();
                      });
                    },
                  ),
                  onPressed: () {},
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
      body: playerListWidget(),
    );
  }

  Widget playerListWidget() {
    return FutureBuilder<List<PlayerModel>>(
      future: _futureList,
      builder:
          (BuildContext context, AsyncSnapshot<List<PlayerModel>> snapshot) {
        if (!snapshot.hasData) {
          // while data is loading:
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          playerList = snapshot.data!;

          // data loaded:
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                //customAppBar(),
                Container(
                  color: Colors.amber,
                ),
                Container(
                    height: 560,
                    child: CupertinoScrollbar(
                        isAlwaysShown: true,
                        thickness: 10,
                        child: Expanded(
                            child: RefreshIndicator(
                                onRefresh: () {
                                  return Future.delayed(Duration(seconds: 1),
                                      () {
                                    setState(() {
                                      _futureList = getProducts();
                                    });
                                  });
                                },
                                child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: playerList.length,
                                    itemBuilder: ((context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => PlayerProfile(
                                                    playerList[index]),
                                              ),
                                            );
                                          },
                                          child:
                                              _productRow(playerList[index]));
                                    })))))),
              ],
            ),
          );
        }
      },
    );
  }

  Future<List<PlayerModel>> getProducts() async {
    int id = -1;
    var res = await RestUrls.getPlayers(id);

    if (res.statusCode == 200) {
      final List json = jsonDecode(res.body) as List;
      var listTemp = (json[0]).map((e) => PlayerModel.fromJson(e)).toList();

      List<PlayerModel> list = List<PlayerModel>.from(listTemp);
      playerTempList = [...list];
      return list;
    }
    return [];
  }

  // Future<List<PlayerModel>> postGetPlayerProcess(Response val) async {
  //   try {
  //     if (val.statusCode == 200) {
  //       final List json = jsonDecode(val.body) as List;
  //       Future<List<PlayerModel>> listTemp =
  //         Future.delayed(1,(() {
  //            (json[0]).map((e) => PlayerModel.fromJson(e)).toList();
  //         });

  //       return listTemp;
  //     }
  //     return [];
  //   } catch (e) {
  //     print(e);
  //     return [];
  //   }
  //}

  Widget _productRow(PlayerModel pm) {
    return ListTile(
      leading: Icon(Icons.face_sharp),
      trailing: Icon(Icons.arrow_forward_ios_sharp),
      title: Text(pm.name!),
    );
  }

  void filterSearchResults(String query) {
    List<PlayerModel> dummySearchList = [];
    dummySearchList.addAll(playerTempList);
    if (query.isNotEmpty) {
      List<PlayerModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name!.toUpperCase().contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        playerList.clear();
        playerList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        playerList.clear();
        playerList.addAll(playerTempList);
      });
    }
  }
}
