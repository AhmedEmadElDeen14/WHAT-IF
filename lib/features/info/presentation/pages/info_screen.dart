import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "WHAT IF?!",
          style: TextStyle(
              fontFamily: 'Jersey', color: Colors.white, fontSize: 35),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .9,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(25)),
        child: SingleChildScrollView(
          child: Text(
            "Ahmed Emad",
            style: TextStyle(
                fontFamily: 'Jersey', color: Colors.black, fontSize: 35),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
