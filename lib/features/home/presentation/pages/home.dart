import 'package:flutter/material.dart';
import 'package:whatif_project/features/home/presentation/widgets/main_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          const Center(
            child: Text(
              "WHAT IF?!",
              style: TextStyle(
                  fontFamily: 'Jersey', color: Colors.white, fontSize: 70),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 50
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HomeButton(title: "Let's Play",nav: true,),
                HomeButton(title: "Info",nav: false,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
