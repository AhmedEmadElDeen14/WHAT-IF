import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatif_project/config/routes/routes.dart';

class HomeButton extends StatelessWidget {
  String title;
  bool nav;

  HomeButton({super.key, required this.title, required this.nav});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          if (nav) {
            Navigator.pushNamed(context, RoutesName.category);
          } else {
            Navigator.pushNamed(context, RoutesName.info);
          }
        },
        child: Container(
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * .9,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xffF97316),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Jersey',
              color: Color(0xffE5E7EB),
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }
}
