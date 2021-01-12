import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'levels_kids.dart';

class quiz_kids extends StatefulWidget {
  List<String> question;

  int level_index = 0;

  quiz_kids(List<String> question2, int level) {
    this.level_index = level;
    this.question = question2;
  }

  @override
  State<StatefulWidget> createState() {
    return MyAppState(level_index, question);
  }
}

class MyAppState extends State<quiz_kids> {
  List<String> fake_data = [
    'خروف',
    'فيل',
    'ثعلب',
    'نمر',
    'نملة',
    'كلب',
    'اسد',
    'قرد'
  ];
  List<String> question;

  int level_index = 0;

  MyAppState(int level_index, List<String> question2) {
    this.level_index = level_index;
    this.question = question2;
  }
  int i = 0, counter = 0, degree = 0, page = 1;
  String image;

  List<String> data__show(String data) {
    int x = 1, ii = 0;
    List<String> data_show = ['', '', ''];
    // print(data);
    List<String> mydata = fake_data..shuffle();
    data_show[0] = data;
    while (x < 3) {
      if (fake_data[ii] != data) {
        data_show[x] = mydata[ii];
        x++;
      }
      ii++;
    }
    return (data_show..shuffle());
  }

  List<String> data_show;

  @override
  Widget build(BuildContext context) {
    image = 'assets2/image/levels_kids/' + question[i] + '.png';
    data_show = data__show(question[i]);
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
                        image: AssetImage("assets2/image/kids_back.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            image, // My Image
                            width: 500,
                            height: 250,
                          ),
                          Column(children: <Widget>[
                            for (int ii = 0; ii <= 2; ii++)
                              My_Button(i, data_show[ii])
                          ]),
                        ])))));
  }

  Widget My_Button(int jj, String data_show) {
    double marg = 30.0;

    if (jj != 0) double marg = 0.0;
    return Container(
        transform: Matrix4.rotationZ(-.2),
        //      alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10, top: marg),
        width: 100.0,
        height: 50.0,
        child: RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(
              data_show,
              textAlign: TextAlign.center,
//              style: TextStyle(fontSize: 22),
            ),
            onPressed: () {
              setState(() {
                check(jj, data_show);
              });
            }));
  }

  check(int x, String cho) {
    if (i <= 2) {
      if (x != 2) i++;
      if (question[x] == cho) {
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

    if (x == 2) {
      if (degree == 3) level_index++;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => levels_kids(level_index, degree)),
      );
    }
  }
}
