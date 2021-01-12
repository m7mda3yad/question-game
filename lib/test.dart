import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'levels.dart';

class test extends StatefulWidget {
  List<String> question;
  List<List<String>> answer;
  int level_index = 0;
  test(List<String> question, List<List<String>> answer, int level) {
    this.question = question;
    this.answer = answer;
    this.level_index = level;
  }

  @override
  State<StatefulWidget> createState() {
    return MyAppState(this.question, this.answer, level_index);
  }
}

class MyAppState extends State<test> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  List<answers> data = new List(5);
  int level_index = 0;
  MyAppState(
      List<String> question, List<List<String>> answer, int level_index) {
    this.level_index = level_index;
    for (int a = 0; a <= 4; a++) {
      this.data[a] = new answers(answer[a], question[a], a);
    }
    this.data = this.data..shuffle();
  }
  List<Color> _colors = <Color>[Colors.grey, Colors.green];
  int i = 0, j = 0, counter = 0, degree = 0, page = 1, col = 1;
  List<int> stop = [1, 1, 1, 1, 1, 1, 1];
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(1, 0.0),
      end: const Offset(-.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (counter > 2)
      col = 0;
    else
      col = 1;

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('مرحبا بك '),
              backgroundColor: Colors.orange[800],
            ),
            body: Scaffold(
                body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets2/image/xdy.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SlideTransition(
                          position: _animation,
                          textDirection: TextDirection.ltr,
                          child: Text('ثلاث مرادفات لي ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          this.data[i].question,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                        for (int ii = 0; ii < 2; ii++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              for (int jj = 0; jj < 3; jj++)
                                if (ii == 0)
                                  My_Button(jj)
                                else
                                  My_Button(jj + 3)
                            ], //<Widget>[]
                          ),
                        RaisedButton(
                          child: Text("التالي", style: TextStyle(fontSize: 22)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(color: Colors.yellow)),
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              //call build
                              if (counter >= 3) {
                                if (i < 4) {
                                  i++;
                                  for (int v = 0; v <= 5; v++) stop[v] = 1;
                                  counter = 0;
                                  page = i + 1;
                                } else {
                                  i = 0;
                                  if (degree >= 10) level_index++;
                                  return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              levels(level_index, degree)));
                                }
                              }
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text("الرجوع", style: TextStyle(fontSize: 14)),
                          textColor: Colors.white,
                          color: Colors.white.withOpacity(0.0),
                          onPressed: () {
                            setState(() {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => levels(0, 0)));
                            });
                          },
                        ),
                        Text(
                          "Page $page",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    )))));
  }

  Widget My_Button(int jj) {
    double marg = 20.0;
    return Container(
        transform: Matrix4.rotationZ(-.2),
        //      alignment: Alignment.center,
        margin: EdgeInsets.only(right: marg),
        width: 100.0,
        height: 50.0,
        child: RaisedButton(
            color: _colors[col],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(color: Colors.yellow)),
            textColor: Colors.white,
            child: Text(
              data[i].answer[jj],
              textAlign: TextAlign.center,
//              style: TextStyle(fontSize: 22),
            ),
            onPressed: () {
              setState(() {
                check(i, jj);
              });
            }));
  }

  check(int x, int i) {
    if (counter < 3 && stop[i] != 0) {
      counter++;
      stop[i] = 0;
      if (data[x].check(i) == 1) {
        degree++;
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets2/sound/corecct.wav"),
          showNotification: true,
        );
      } else
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets2/sound/wrong.wav"),
          showNotification: true,
        );
    }
  }
}

class answers {
  String question;
  List<String> flag2 = ["", "", ""];
  List<String> answer;
  answers(List<String> b, String q, int index) {
    this.flag2[0] = b[0];
    this.flag2[1] = b[1];
    this.flag2[2] = b[2];
    this.answer = b..shuffle();
    this.question = q;
  }
  int check(int data) {
    if (this.flag2.contains(this.answer[data]))
      return 1;
    else
      return 0;
  }
}
