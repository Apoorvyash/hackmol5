// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:saheli_app/widgets/NearbyLocations/Cards/BusStationCard.dart';
// import 'package:saheli_app/widgets/NearbyLocations/Cards/PoliceStationCard.dart';
// import 'package:saheli_app/widgets/NearbyLocations/Cards/HospitalCard.dart';
//
// class LiveSafe extends StatelessWidget {
//   const LiveSafe({Key? key}) : super(key: key);
//
//   static Future<void> openMap(String location) async {
//     String googleUrl = 'https://www.google.com/maps/search/$location';
//
//     if (Platform.isAndroid) {
//       if (await canLaunchUrl(Uri.parse(googleUrl))) {
//         await launchUrl(Uri.parse(googleUrl));
//       } else {
//         throw 'Could not launch $googleUrl';
//       }
//     }
//     // final Uri _url = Uri.parse(googleUrl);
//     // try {
//     //   await launchUrl(_url);
//     // } catch (e) {
//     //   Fluttertoast.showToast(
//     //       msg: 'something went wrong! call emergency number');
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 90,
//       width: MediaQuery.of(context).size.width,
//       child: ListView(
//         physics: BouncingScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//         children: [
//           PoliceStationCard(onMapFunction: openMap),
//           HospitalCard(onMapFunction: openMap),
//           BusStationCard(onMapFunction: openMap),
//         ],
//
//       ),
//     );
//   }
// }
