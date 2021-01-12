import 'dart:math';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'matching_level.dart';

class Secondscreen extends StatefulWidget {
  int level;
  Map<String, String> choices;
  Secondscreen(Map<String, String> choices, int level) {
    this.level = level;
    this.choices = choices;
  }

  @override
  _SecondscreenState createState() => _SecondscreenState(choices, level);
}

class _SecondscreenState extends State<Secondscreen> {
  int level;
  Map<String, String> choices;
  int counter = 0;
  List<int> check = [0, 0, 0, 0, 0, 0];
  _SecondscreenState(Map<String, String> choices, int level) {
    this.level = level;
    this.choices = choices;
  }
  Map<String, bool> score = {};
  List<Color> newmap = [
    Colors.orange,
    Colors.black,
    Colors.green,
    Colors.pink,
    Colors.purple,
    Colors.yellow,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Level 1',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Ionicons.ios_arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false)),
      ),
      body:
          //Center(
          //  child: RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.mail), label: Text('mail me'),color: Colors.amber,),
          //
          // ),
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choices.keys.map((element) {
              return Expanded(
                child: Draggable<String>(
                  data: element,
                  child: Movable(score[element] == true ? '✔️' : element),
                  feedback: Movable(element),
                  childWhenDragging: Movable(''),
                ),
              );
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices.keys.map((element) {
              return buildTarget(element);
            }).toList()
              ..shuffle(Random()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Back',
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.pink[800],
      ),
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //  child: Icon(Icons.refresh),
      //  onPressed: () {
      //  setState(() {
      //    score.clear();
      //      index++;
      //   });
      //    },
      //  ),
    );
  }

  Widget buildTarget(element) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        if (score[element] == true) {
          return Container(
            color: Colors.transparent,
            child: Text(
              'احسنت',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        } else {
          return Container(
            child: Text(
              choices[element],
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            color: Colors.blue,
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == element,
      onAccept: (data) {
        setState(() {
          score[element] = true;
          counter++;
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets2/sound/corecct.wav"),
            showNotification: true,
          );

          if (counter >= 6) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => matching_level(level + 1, counter)),
            );
          }
        });
      },
      onLeave: (data) {},
    );
  }
}

class quote {
  String text;
  quote({this.text});
}

class Movable extends StatelessWidget {
  final String emoji;
  String text;
  Movable(this.emoji);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        padding: EdgeInsets.all(15),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 60),
        ),
      ),
    );
  }
}
