// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../Api/api.dart';

import '../Data/dynamic_data.dart';
import '../Data/static_data.dart';
import 'update.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  getImeiPhone() async {
    uniqueId = await UniqueIdentifier.serial ?? 'null';
    if (uniqueId != 'null' && uniqueId.isNotEmpty) {
      getCandidateData();
    } else {}
  }

  getCandidateData() async {
    Api api = Api();
    Response response = await api.getCandidateInfo();

    if (response.data['Status'] == 200) {
      setState(() {
        candidate = response.data['Candidate'];
        isSupporter = response.data['Supporter'];
        sponsor = response.data['Sponsor'];
      });
      Navigator.pushReplacementNamed(context, '/home');
    } else if (response.data['Status'] == 903) {
      setState(() {
        updateAppUrl = response.data['Link']['AppFile'];
      });
      update(context);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getImeiPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: AssetImage(
                        StaticData.candidateImage,
                      ),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              StaticData.candidateName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomSheet: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('قدرت گرفته از '),
            Text(
              'سرو سبز ترشیز',
              style: TextStyle(
                //   fontSize: size,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
