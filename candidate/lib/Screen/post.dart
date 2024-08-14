import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../Data/dynamic_data.dart';
import '../Data/static_data.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.index});
  final int index;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  //
  late FlickManager videoPlayerController;

  bool postType = false;

  initPost() {
    if (post[widget.index]['File'] != null &&
        post[widget.index]['File'].isNotEmpty) {
      postType = true;
      initVideo();
    }
  }

  initVideo() {
    videoPlayerController = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(
          StaticData.baseUrl + post[widget.index]['File'],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initPost();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (postType)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: FlickVideoPlayer(
                        flickManager: videoPlayerController,
                      ),
                    ),
                  ),
                ),
              if (!postType)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(
                        StaticData.baseUrl + post[widget.index]['Image'],
                      ),
                      width: MediaQuery.of(context).size.width - 30,
                    ),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  post[widget.index]['Caption'],
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
