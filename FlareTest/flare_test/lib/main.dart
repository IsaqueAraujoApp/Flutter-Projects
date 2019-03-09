import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splach(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Splach extends StatefulWidget {
  @override
  _SplachState createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150.0,
          height: 150.0,
          child: FlareActor("assets/AnimGears.flr", animation: "spin1",),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home())
      );
    });
  }

}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Flutter + Flare",
          style: TextStyle(
            fontSize: 30.0,
          ), textAlign: TextAlign.center,
          ),
          Container(
            height: 100.0,
            width: 100.0,
            child: FlareActor("assets/heart.flr", animation: "pulse",),
          ),
        ],
      ),
    );
  }
}


