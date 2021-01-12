import 'package:flutter_icons/flutter_icons.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:game/main.dart';
import 'package:game/quiz.dart';

class levels_kids extends StatefulWidget {
  int level = 0;
  int score = 0;
  levels_kids(int a, int b) {
    this.level = a;
    this.score = b;
  }

  @override
  _levelsState createState() => _levelsState(level, score);
}

class _levelsState extends State<levels_kids> {
  static int mylevel = 0;
  static int myscore = 0;

  _levelsState(int level, int score) {
    if (mylevel < level) {
      mylevel = level;
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets2/sound/367190__iceofdoom__oh.wav"),
        showNotification: true,
      );
    }
    myscore += score;
  }

  MaterialColor color_level(int level) {
    if (level <= mylevel)
      return Colors.green;
    else
      return Colors.grey;
  }

  Widget mytext(int level) {
    if (level <= mylevel)
      return Text('${level + 1}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                  InkWell(
                      onTap: () {
                        if (index <= mylevel)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    quiz_kids(get_question(index), index)),
                          );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: color_level(index),
                            border: Border.all(color: Colors.red, width: 3.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(26.0),
                          child: mytext(index))),
                  if (index == 4)
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

  List<String> get_question(int a) {
    List<List<String>> x = [
      ['بقرة', 'بطة', 'اسد'],
      ['جمل', 'ثعلب', 'تمساح'],
      ['ذبابة', 'خروف', 'حمار'],
      ['سحلفاء', 'زرافة', 'رنة'],
      ['فبل', 'غزال', 'سنجاب'],
      ['نمر', 'قرد', 'بومة'],
    ];
    return x[a];
  }
}
