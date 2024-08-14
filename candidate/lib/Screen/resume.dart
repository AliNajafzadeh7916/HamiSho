import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_im_animations/im_animations.dart';

import '../Data/dynamic_data.dart';
import '../Data/static_data.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  //
  bool isPlaying = false;

  final player = AudioPlayer();

  Future<void> play(String url) async {
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        player.pause();
        Navigator.of(context).pop(false);
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
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
                          style: TextStyle(
                            color: Color(
                              int.parse(
                                '0XFF${candidate['Color'][2]}',
                              ),
                            ),
                            fontSize: 50,
                            fontFamily: 'IranNastaliq',
                          ),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        candidate['Cv'],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            height: 2),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25 - 52.5,
                child: Container(
                  //  padding: EdgeInsets.all(15),
                  height: 105,
                  width: 105,
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
                              StaticData.baseUrl + candidate['Image']),
                          fit: BoxFit.cover)),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.28,
                right: MediaQuery.of(context).size.width * 0.32,
                child: GestureDetector(
                  onTap: () async {
                    if (!isPlaying) {
                      play(StaticData.baseUrl + candidate['Sound']);

                      setState(() {
                        isPlaying = true;
                      });
                    } else {
                      await player.pause();

                      setState(() {
                        isPlaying = false;
                      });
                    }
                  },
                  child: Sonar(
                    radius: 30,
                    waveColor: Color(
                      int.parse(
                        '0XFF${candidate['Color'][1]}',
                      ),
                    ),
                    child: Container(
                      //  padding: EdgeInsets.all(15),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(
                            '0XFF${candidate['Color'][1]}',
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          isPlaying
                              ? CupertinoIcons.pause_circle
                              : CupertinoIcons.play_circle,
                          color: Color(
                            int.parse(
                              '0XFF${candidate['Color'][2]}',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
