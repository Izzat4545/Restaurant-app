import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/pages/waiter/waiter.dart';

import 'cooker/cooker.dart';

// ignore: must_be_immutable
class FirstPage extends StatelessWidget {
  var fontStyle = GoogleFonts.inter(
      fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white);

  FirstPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cooker()),
              );
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(242, 153, 74, 100)),
              child: Center(
                child: Text('Cooker', style: fontStyle),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Waiter()),
              );
            },
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(235, 87, 87, 100)),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Text(
                  'Waiter',
                  style: fontStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
