import 'package:firebasenotes/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(31, 29, 43, 1),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 30, right: 30),
            child: Image.asset("assets/images/illus.png"),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Daily Notes",
            style: GoogleFonts.montserratAlternates(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "   Take notes, reminders, set targets\n collect resources, and secure privacy ",
            style: GoogleFonts.mulish(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Color.fromRGBO(237, 237, 255, .6)),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(111, 111, 200, 1))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 15, bottom: 15),
                child: Text(
                  "Get Started",
                  style: GoogleFonts.mulish(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
