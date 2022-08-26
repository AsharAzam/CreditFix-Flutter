import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'package:core/Utils/Font.dart';

class VideoViewScreen extends StatefulWidget {
  static const String route = "VideoViewScreen";

  @override
  _VideoViewScreenState createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  late BuildContext _context;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

        setState(() {});
        _controller.addListener(() => setState(() {
          // played =
          //     '${_controller.value.position.inMinutes}:${_controller.value.position.inSeconds}';
          // played = durationToString(_controller.value.position);
          played = format(_controller.value.position);
          full = format(_controller.value.duration);
        }));
      });
  }

  @override
  Widget build(BuildContext context) {
    print('State: HowToUseApp');
    _context = context;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: smallView ? appBar() : null,
      body: RotatedBox(
        quarterTurns: smallView ? 0 : 1,
        child: Container(
          color: Colors.black87,
          // height: smallView?ScreenConfig.screenHeight:ScreenConfig.screenWidth,
          // width: smallView?ScreenConfig.screenWidth:ScreenConfig.screenHeight,
          padding: EdgeInsets.all(smallView ? 16 : 0),
          // color: Colors.green,
          child: smallView
              ? body()
              : Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width ?? 0,
                    height: _controller.value.size.height ?? 0,
                    child: InkWell(
                      child: VideoPlayer(_controller),
                      onTap: () {
                        toggleControllerView();
                      },
                    ),
                  ),
                ),
              ),
              //FURTHER IMPLEMENTATION
              if (controllerView) videoControllerView()
            ],
          ),
        ),
      ),
    );
  }

  bool smallView = true, controllerView = false, muted = false;
  String played = '00:00', full = "00:00";

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _controller.value.isInitialized
            ? Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              child: SizedBox(
                height: 280,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              onTap: () {
                toggleControllerView();
              },
            ),
            if (controllerView) videoControllerView(),
          ],
        )
            : Container(
          height: 300,
          alignment: Alignment.center,
          child: Text('Loading..'),
        ),
        if (smallView)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quisque suscipit ipsum est, eu venenatis leo ornare eget. Ut porta facilisis elementum. Sed condimentum sed massa quis ullamcorper. Donec at scelerisque neque. Pellentesque sagittis, massa sodales sodales finibus, felis",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Gibson',
                        fontWeight: FontWeight.w400,
                        height: 1.7),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
      ],
    );
  }

  videoControllerView() {
    return ColoredBox(
      color: Colors.grey.withAlpha(200),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: smallView
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.spaceAround,
            // mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  toggleVolume();
                },
                icon: Icon(!muted ? Icons.volume_off : Icons.volume_up),
                iconSize: 30,
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                icon: Icon(_controller.value.isPlaying
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline_outlined),
                iconSize: 30,
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  toggleFullscreen();
                },
                icon:
                Icon(!smallView ? Icons.fullscreen_exit : Icons.fullscreen),
                iconSize: 30,
                color: Colors.white,
              ),
            ],
          ),
          // Slider(value: 0, onChanged: (val){
          //   _controller.seekTo(val)
          // }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: smallView ? 10 : 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  played,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: Font.Regular,
                  ),
                ),
                Text(
                  full,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: Font.Regular,
                  ),
                ),
              ],
            ),
          ),
          VideoProgressIndicator(
            _controller, //controller
            allowScrubbing: true,
            colors: VideoProgressColors(
              playedColor: Colors.red,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.grey.shade300,
            ),
          )
        ],
      ),
    );
  }

  toggleVolume() {
    setState(() {
      muted = !muted;
      _controller.setVolume(!muted ? 0 : 1);
    });
  }

  // togglePlay(){
  //   setState((){
  //     muted = !muted;
  //   });
  // }

  toggleFullscreen() {
    setState(() {
      smallView = !smallView;
    });
  }

  toggleControllerView() {
    setState(() {
      controllerView = !controllerView;
    });
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text("Nulla fermenturm fravida"),
      centerTitle: false,
      iconTheme: Theme.of(context).appBarTheme.iconTheme?.copyWith(color: Colors.white),
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(color: Colors.white),
      titleSpacing: 0,
      backgroundColor: Colors.black87,
      elevation: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
