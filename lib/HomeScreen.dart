
import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';

import 'emergencies/customeAppBar.dart';
import 'emergencies/emergency.dart';


class HomePage extends StatefulWidget {
  int qIndex = 0;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }
  int qIndex = 0;
  void initState(){
    super.initState();
    getRandomQuote();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: CustomAppBar(
                quoteIndex: qIndex,
                onTap: getRandomQuote(),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 10),
                  //SafeHome(),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Incase of Emergency",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Emergency(),
                  const SizedBox(height: 5),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Find on Map",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  // Container(
                  //     alignment: Alignment.center,
                  //     child: const LiveSafe()),
                  const SizedBox(height: 10),
                  const SizedBox(height: 5),
                  // Container(
                  //     alignment: Alignment.center,
                  //     child: const LiveSafe()),
                  // const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Explore Inspiring Stories",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  // const CustomCarouel(),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }


}
