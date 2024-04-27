import 'package:flutter/material.dart';

class appTabs extends StatelessWidget {
  final String text;
  final Color tabColor;

  const appTabs({super.key, required this.text, required this.tabColor});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 120,
      height: 50,
      child: Center(

        child: Text(
          text,
          style: TextStyle(color: Colors.white,fontSize: 17),
        ),
      ),

      decoration: BoxDecoration(
          color: tabColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 7,
                offset: Offset(0, 0))
          ]),
    );;
  }
}


