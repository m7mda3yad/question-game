//matching_level.dart
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:game/main.dart';
import 'package:game/new_level.dart';

class matching_level extends StatefulWidget {
  int level;
  int score = 0;
  matching_level(int level, int score) {
    this.level = level;
    this.score = score;
  }

  @override
  _levelsState createState() => _levelsState(level, score);
}

class _levelsState extends State<matching_level> {
  static int mylevel = 0;
  static int myscore = 0;

  _levelsState(int level, int score) {
    if (mylevel < level) {
      mylevel++;
    }
    if (score >= 6)
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets2/sound/367190__iceofdoom__oh.wav"),
        showNotification: true,
      );
    myscore += score;
  }

  MaterialColor color_level(int a) {
    if (a <= mylevel)
      return Colors.green;
    else
      return Colors.grey;
  }

  Widget mytext(int x) {
    if (x <= mylevel)
      return Text('${x + 1}',
          style: TextStyle(fontSize: 19, color: Colors.white));
    else
      return Icon(Ionicons.ios_lock);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التسجيل   $myscore'),
        backgroundColor: Colors.orange[800],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          children: List.generate(6, (index) {
            return Center(
                child: IntrinsicWidth(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                  InkWell(
                      onTap: () {
                        if (index <= mylevel)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Secondscreen(get_question(index), index)),
                          );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: color_level(index),
                            border: Border.all(color: Colors.black, width: 3.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: mytext(index))),
                  if (index == 5)
                    RaisedButton(
                      child: Text("الرجوع"),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        });
                      },
                    ),
                ])));
          }),
        ),
      )),
    );
  }

  Map<String, String> get_question(int a) {
    List<Map<String, String>> question = [
      {'🐇': "أ", '🍎': "ت", '🦊': "ث", '🐪': "ج", '🐋': "ح", '🐑': "خ"},
      {'🐓': 'د', '🐥': 'ك', '🕊️': 'ح', '🦅': 'ن', '🦆': 'ب', '🦚': 'ط'},
      {'🦍': 'غ', '🐶': 'ك', '🐱': 'ق', '🦁': 'أ', '🐯': 'ن', '🐴': 'ح'},
      {'🐮': 'ب', '🐂': 'ث', '🐐': 'م', '🦙': 'ل', '🦒': 'ز', '🐘': 'ف'},
      {'🐿️': 'س', '🐀': 'ف', '🐹': 'ه', '🐇': 'أ', '🦔': 'ق', '🦇': 'خ'},
      {'🐔': 'د', '🐧': 'ب', '🦋': 'ف', '🐸': 'ض', '🐢': 'س', '🐍': 'ث'}
    ];
    return question[a];
  }
}
