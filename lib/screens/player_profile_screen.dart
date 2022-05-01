import 'package:coaching/models/player_model.dart';
import 'package:flutter/material.dart';

class PlayerProfile extends StatefulWidget {
  final PlayerModel pm;

  const PlayerProfile(this.pm);

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Player Profile'),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 140),
            child: Column(
              children: [
                Center(
                  child: Icon(Icons.account_circle_rounded, size: 80),
                ),
                SizedBox(height: 10),
                Table(
                    //defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder(
                        horizontalInside: BorderSide(
                            width: 1,
                            color: Colors.grey,
                            style: BorderStyle.solid)),
                    //color: Colors.black, style: BorderStyle.none, width: 2),
                    children: [
                      infoRow("Name", widget.pm.name!),
                      infoRow("DOB", widget.pm.dob!),
                      infoRow("Team", "Delhi"),
                      infoRow("Matches Played", "23")
                    ])
              ],
            )));
  }

  TableRow infoRow(String field, String value) {
    return TableRow(children: [
      TableCell(
          child: Text(
        field,
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      TableCell(
        child: Text(value),
      ),
    ]);
  }
}
