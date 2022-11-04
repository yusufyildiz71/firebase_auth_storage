import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
      //padding: EdgeInsets.symmetric(vertical: size.height * 0.0, 0.015),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                color: Color(0xFF00897B),
              ),
            ),
          ),
          buildDivider(context),
        ],
      ),
    );
  }

  Expanded buildDivider(context) {
    return const Expanded(
      child: Divider(
        color: Color.fromARGB(255, 17, 16, 16),
        height: 16,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
