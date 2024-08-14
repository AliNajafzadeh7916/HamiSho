// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../Api/api.dart';

import '../Data/dynamic_data.dart';
import '../Data/static_data.dart';

import 'message.dart';
import 'post.dart';
import 'resume.dart';
import 'update.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //

  bool hami = isSupporter;
  bool isPost = true;

  bool havePost = true;
  bool haveNews = true;

  bool checkPost = false;
  bool checkNews = false;

  bool updateDialog = false;

  List<ExpandableController> controllers = [];

  check() {
    Duration checkInterval = const Duration(seconds: 20);
    Timer.periodic(checkInterval, (timer) async {
      await getCandidateData();
      if (!updateDialog) {
        await getPostCandidate();
        await getNewsCandidate();
      }
    });
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
    } else if (response.data['Status'] == 903) {
      setState(() {
        updateAppUrl = response.data['Link']['AppFile'];
        updateDialog = true;
      });

      update(context);
    } else {}
  }

  getPostCandidate() async {
    Api api = Api();
    Response response = await api.getPostCandidate();

    if (response.data['Status'] == 200) {
      setState(() {
        post = response.data['Post'];
        post = post.reversed.toList();
        checkPost = true;
      });

      if (post.isEmpty) {
        setState(() {
          havePost = false;
        });
      }
    } else if (response.data['Status'] == 903) {
      setState(() {
        updateAppUrl = response.data['Link']['AppFile'];
      });
      update(context);
    } else {}
  }

  getNewsCandidate() async {
    Api api = Api();

    Response response = await api.getNewsCandidate();

    if (response.data['Status'] == 200) {
      setState(() {
        news = response.data['News'];
        news = news.reversed.toList();
        checkNews = true;
      });

      if (news.isEmpty) {
        setState(() {
          haveNews = false;
        });
      }
    } else if (response.data['Status'] == 903) {
      setState(() {
        updateAppUrl = response.data['Link']['AppFile'];
      });
      update(context);
    } else {}
  }

  setSupporter() async {
    Api api = Api();
    Response response = await api.setSupporter();
    if (response.data['Status'] == 200) {
      setState(() {
        hami = true;
      });
      getCandidateData();
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
    getPostCandidate();
    getNewsCandidate();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(
                            '0XFF${candidate['Color'][0]}',
                          ),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                StaticData.baseUrl + candidate['Background']),
                            fit: BoxFit.cover,
                            opacity: 0.5),
                      ),
                      child: Center(
                          child: Text(
                        candidate['Slogan'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(
                            int.parse(
                              '0XFF${candidate['Color'][2]}',
                            ),
                          ),
                          fontSize: candidate['Slogan'].toString().length > 30
                              ? 50
                              : 70,
                          fontFamily: 'IranNastaliq',
                        ),
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Column(
                  children: [
                    Text(
                      candidate['Name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(candidate['SirName']),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        hami
                            ? ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(
                                      int.parse(
                                        '0XFF${candidate['Color'][1]}',
                                      ),
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: null,
                                child: SizedBox(
                                  height: 45,
                                  width: 110,
                                  child: Center(
                                    child: Lottie.asset(
                                      'assets/images/isSupporter.json',
                                      repeat: false,
                                    ),
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(
                                      int.parse(
                                        '0XFF${candidate['Color'][1]}',
                                      ),
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    setSupporter();
                                  });
                                },
                                child: const SizedBox(
                                  height: 45,
                                  width: 180,
                                  child: Center(
                                    child: Text(
                                      'حمایت از کاندیدا',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(
                                int.parse(
                                  '0XFF${candidate['Color'][1]}',
                                ),
                              ),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResumeScreen(),
                              ),
                            );
                          },
                          child: const SizedBox(
                            height: 45,
                            width: 110,
                            child: Center(
                              child: Text(
                                'رزومـه',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(
                            int.parse(
                              '0XFF${candidate['Color'][1]}',
                            ),
                          ),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MessageScreen(),
                          ),
                        );
                      },
                      child: const SizedBox(
                        height: 45,
                        width: 280,
                        child: Center(
                          child: Text(
                            'ارتباط با کاندیدا',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.camera_on_rectangle,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'پست ها',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                havePost
                                    ? Text(
                                        post.length.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )
                                    : LoadingAnimationWidget.staggeredDotsWave(
                                        color: Colors.black,
                                        size: 20,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.group,
                                  size: 40,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    ' حامیان ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  candidate['nSupporter'].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Column(
                              children: [
                                const Icon(
                                  CupertinoIcons.bubble_left_bubble_right,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    ' پیام ها ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  candidate['nMessageSentToCandidate']
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 12,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child:
                                      Lottie.asset('assets/images/iran.json'),
                                ),
                                const Text(
                                  'حامیان',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child:
                                      Lottie.asset('assets/images/iran.json'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 160,
                              width: MediaQuery.of(context).size.width - 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sponsor.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Color(
                                            int.parse(
                                              '0XFF${candidate['Color'][0]}',
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  StaticData.baseUrl +
                                                      sponsor[index]['Image']),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        width: 80,
                                        child: Center(
                                          child: Text(
                                            sponsor[index]['Name'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        // padding: const EdgeInsets.all(5),
                                        width: 80,
                                        child: Center(
                                          child: Text(
                                            sponsor[index]['Proper'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPost = true;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              color: isPost
                                  ? Color(
                                      int.parse(
                                        '0XFF${candidate['Color'][1]}',
                                      ),
                                    ).withOpacity(0.1)
                                  : null,
                              border: isPost
                                  ? Border.all(
                                      width: 2,
                                      color: Color(
                                        int.parse(
                                          '0XFF${candidate['Color'][1]}',
                                        ),
                                      ),
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'پست ها',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: isPost ? FontWeight.bold : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPost = false;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              color: !isPost
                                  ? Color(
                                      int.parse(
                                        '0XFF${candidate['Color'][1]}',
                                      ),
                                    ).withOpacity(0.1)
                                  : null,
                              border: !isPost
                                  ? Border.all(
                                      width: 2,
                                      color: Color(
                                        int.parse(
                                          '0XFF${candidate['Color'][1]}',
                                        ),
                                      ),
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'اطلاعیه ها',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: !isPost ? FontWeight.bold : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    isPost
                        ? Padding(
                            padding: const EdgeInsets.all(5),
                            child: Wrap(
                              children: post.map((dynamic value) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PostScreen(
                                            index: post.indexOf(value)),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        height:
                                            (MediaQuery.of(context).size.width -
                                                    40) /
                                                3,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    40) /
                                                3,
                                        decoration: BoxDecoration(
                                            color: Color(
                                              int.parse(
                                                '0XFF${candidate['Color'][0]}',
                                              ),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  StaticData.baseUrl +
                                                      value['Image']),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      if (value['File'] != null)
                                        Positioned(
                                          right: 15,
                                          bottom: 15,
                                          child: Center(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      7, 5, 4, 4),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.play,
                                                size: 22,
                                                color: Color(
                                                  int.parse(
                                                    '0XFF${candidate['Color'][0]}',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(0),
                            child: Wrap(
                              children: news.map((dynamic value) {
                                if (controllers.length < news.length) {
                                  controllers.add(ExpandableController());
                                }
                                return Container(
                                  color: news.indexOf(value) % 2 == 1
                                      ? Colors.grey.withOpacity(0.5)
                                      : null,
                                  child: Column(
                                    children: [
                                      ExpandablePanel(
                                        controller:
                                            controllers[news.indexOf(value)],
                                        theme: const ExpandableThemeData(
                                          iconColor: Colors.grey,
                                          iconSize: 30,
                                          iconPadding: EdgeInsets.fromLTRB(
                                              20, 20, 0, 10),
                                        ),
                                        header: ListTile(
                                          leading: const Icon(
                                            CupertinoIcons.envelope,
                                            size: 30,
                                          ),
                                          title: Text(
                                            value['Title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Text(
                                                value['RegisterTime']
                                                    .toString()
                                                    .substring(11, 16),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                value['RegisterTime']
                                                    .toString()
                                                    .substring(0, 10)
                                                    .replaceAll('-', '/'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        collapsed: const Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Row(),
                                        ),
                                        expanded: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image(
                                                      image: NetworkImage(
                                                          StaticData.baseUrl +
                                                              value['Image']),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              30,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            30,
                                                    child: Text(
                                                      value['Content'],
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          controllers[
                                                                  news.indexOf(
                                                                      value)]
                                                              .toggle();
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            Color(
                                                              int.parse(
                                                                '0XFF${candidate['Color'][1]}',
                                                              ),
                                                            ),
                                                          ),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                        ),
                                                        child: const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      100),
                                                          child: Text('بستن'),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.30 - 65,
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    color: Color(
                      int.parse(
                        '0XFF${candidate['Color'][0]}',
                      ),
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 3, color: Colors.white),
                    image: DecorationImage(
                        image: NetworkImage(
                          StaticData.baseUrl + candidate['Image'],
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            if (candidate['isSponsorApp'])
              Positioned(
                top: MediaQuery.of(context).size.height * 0.29,
                left: MediaQuery.of(context).size.width * 0.20,
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Lottie.asset('assets/images/vip.json'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
