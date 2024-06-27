import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class VideoPage extends StatefulWidget {
  final String url;
  final String title;
  const VideoPage(this.title,this.url,{super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }
  @override
  void dispose() {
    _videoPlayerController1!.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar:widget.title.isNotEmpty ?  DefaultAppBar(name: widget.title) : null,
      body: SizedBox(
        height: sizeWidth(context).height,
        child:  _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(
          controller: _chewieController!,
        )
            : spinKit(context),
      ),

    );
  }
  Future<void> initializePlayer() async {
    _videoPlayerController1 =VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await Future.wait([
      _videoPlayerController1!.initialize(),
    ]);
    _createChewieController();
    setState(() {
      _videoPlayerController1!.play();
    });
  }
  void _createChewieController() {
    _chewieController = ChewieController(
        fullScreenByDefault: true,
        looping: true,
        zoomAndPan: true,
        showControls: true,
        aspectRatio: _videoPlayerController1!.value.aspectRatio,
        allowFullScreen: true,
        videoPlayerController: _videoPlayerController1!,
        autoPlay: true,
        showOptions: true);
  }
}
