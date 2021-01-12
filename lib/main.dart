import 'package:flutter/material.dart';
import 'levels.dart';
import 'levels_kids.dart';
import 'new_level.dart';
import 'matching_level.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, /////
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage() : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget img() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets2/image/start1.jpg"),
                fit: BoxFit.cover)));
  }

  double padd = 20.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets2/image/levels_kids/back.jpg'),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text('القائمة'),
                centerTitle: true,
              ),
              body: Center(
                  child: IntrinsicWidth(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                    Padding(padding: const EdgeInsets.all(20.0)),
                    RaisedButton(
                      color: Colors.black.withOpacity(0.05),
                      onPressed: () {},
                      child: Image.asset(
                        'assets2/image/logo.png',
                        height: 60,
                        width: 80,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(20.0)),
                    RaisedButton(
                      color: Colors.black.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          side: BorderSide(color: Colors.yellow)),
                      child: Image.asset(
                        'assets2/image/match-icon.png',
                        height: 60,
                        width: 80,
                      ),
                      //   child: Icon(Ionicons.ios_body),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new matching_level(0, 0)));
                      },
                    ),
                    Padding(padding: const EdgeInsets.all(20.0)),
                    RaisedButton(
                      color: Colors.black.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          side: BorderSide(color: Colors.yellow)),
                      child: Image.asset(
                        'assets2/image/levels_kids/baby.png',
                        height: 60,
                        width: 80,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new levels_kids(0, 0)));
                      },
                    ),
                    Padding(padding: const EdgeInsets.all(20.0)),
                    RaisedButton(
                      color: Colors.black.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          side: BorderSide(color: Colors.yellow)),
                      child: Image.asset(
                        'assets2/image/levels_kids/man.png',
                        height: 60,
                        width: 80,
                      ),
                      //   child: Icon(Ionicons.ios_body),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new levels(0, 0)));
                      },
                    ),
                  ]))),
            )));
  }
}

class SlideRight extends PageRouteBuilder {
  final Page;
  SlideRight({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var tween = Tween(begin: begin, end: end);
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            });
}
