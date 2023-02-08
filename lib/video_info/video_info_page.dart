import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/shared/colors.dart';

class VideoInfoPage extends StatefulWidget {
  const VideoInfoPage({Key? key}) : super(key: key);

  @override
  State<VideoInfoPage> createState() => _VideoInfoPageState();
}

class _VideoInfoPageState extends State<VideoInfoPage> {
  List videoInfo = [];
  bool _playArea = false;
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  Duration? _duration;
  Duration? _position;
  var _progress=0.0;

  _readData() async {
    // print('data read');
    await rootBundle.loadString('assets/json/videoinfo.json').then((s) {
      //set state to work after building app again if any dara is triggered
      setState(() {
        videoInfo = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readData();
  }

  @override
  void dispose() {
    //will be used in listener
    _disposed = true;
    //pause video controller after fasting forward or back
    _controller!.pause();
    //delete it from local storage
    _controller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: (!_playArea)
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gradientFirst.withOpacity(0.9),
                    AppColors.gradientSecond,
                  ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight,
                ),
              )
            : BoxDecoration(color: AppColors.gradientSecond),
        child: Column(
          children: [
            (!_playArea)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    padding: const EdgeInsets.only(
                      left: 30,
                      top: 70,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //back icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 25,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.info_outline_rounded,
                                  color: Colors.white,
                                  size: 25,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Legs Toning',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('and Glutes Workout',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white70.withOpacity(0.3),
                                    AppColors.gradientSecond.withOpacity(0.1),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(children: const [
                                Icon(
                                  Icons.timer,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '68 min',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 30,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white70.withOpacity(0.3),
                                    AppColors.gradientSecond.withOpacity(0.1),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(children: const [
                                Icon(
                                  Icons.handyman_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Resistant band , Ketteball',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ]),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _playArea = false;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white70,
                                    size: 25,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.white70,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        //video itself
                        _playView(context),
                        //control audio,quality,velocity,playback and others
                        _controllerView(context),
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'circuit 1 : Legs Toning',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.loop,
                          color: AppColors.gradientSecond,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          '3 sets',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                    //video list
                    Expanded(
                      child: _listView(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //video play view
  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 14 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return const Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Center(
                child: Text(
                  'Preparing....',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontSize: 20),
                ),
              )));
    }
  }

  //list view of all tiles
  Widget _listView() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: videoInfo.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              debugPrint(index.toString());
              setState(() {
                if (_playArea == false) {
                  _playArea = true;
                }
              });
              onTapVideo(index);
            },
            child: _playerCard(index),
          );
        },
      );

  //list tile of audio players
  Widget _playerCard(int index) => Container(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        margin: const EdgeInsets.only(bottom: 20),
        height: 135,
        width: 200,
        color: Colors.white70,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(videoInfo[index]['img']),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoInfo[index]['title'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      videoInfo[index]['time'],
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            //dashed line will be created in a loop
            Row(
              children: [
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xffeaeefc),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      '15 rest',
                      style: const TextStyle(color: const Color(0xff839fed)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0; i < 70; i++)
                      Container(
                        width: 3,
                        height: 1,
                        decoration: BoxDecoration(
                          color: i.isEven
                              ? const Color(0xff839fed)
                              : Colors.white70,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      )
                  ],
                )
              ],
            ),
          ],
        ),
      );

  //on tap method to play video
  void onTapVideo(int index) {
    //to load url
    final controller =
        VideoPlayerController.network(videoInfo[index]['videoUrl']);
    //to save previous controller
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    //init controller
    controller.initialize().then((_) {
      //to ensure deleting previous controller
      // old!.dispose();

      _isPlayingIndex = index;
      //listener to know video state
      controller.addListener(_onControllerUpdate);
      controller.play();
      //to ensure that init was happened
      setState(() {});
    });
  }

String convertTo(int value){
    return value <10 ?'0$value':'$value';
}
  //video controller view
  Widget _controllerView(BuildContext context) {
  final noMute = (_controller?.value.volume??0)>0;
  final duration= _duration?.inSeconds??0;
  final head= _position?.inSeconds??0;
  final remind=max(0,duration-head);
  final mins=convertTo(remind~/60);
  final secs=convertTo(remind%60);
    return Container(
        height: 100,
        margin:const EdgeInsets.only(bottom: 5),
        width: MediaQuery.of(context).size.width,
        color: AppColors.gradientSecond,
        child: Column(
          children: [
            //video slider
            Slider(value: max(0,min(_progress*100,100)),min: 0,max: 100,divisions: 100,label: _position.toString().split('.')[0], onChanged: (value){
              setState(() {
                _progress=value*0.01;
              });
            },
              onChangeStart: (value){
              _controller!.pause();
              },
              onChangeEnd: (value){
              final duration=_controller!.value.duration;
              if(_duration!=null){
                var newValue=max(0,min(value,99)*0.01);
                var millis=(duration.inMilliseconds*newValue).toInt();
                _controller!.seekTo(Duration(milliseconds: millis));
                _controller!.play();
              }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //audio volume
                InkWell(
                  onTap: (){
                    //to control audio volume is 1 or 0
                    if(noMute){
                      _controller!.setVolume(0);
                    }else{
                      _controller!.setVolume(1.0);
                    }
                    setState(() {
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                    child: Container(
                      decoration:  const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                           BoxShadow(
                            offset: Offset(0,0),
                            blurRadius: 4,
                            color:  Color.fromARGB(50, 0, 0, 0)
                          )
                        ]
                      ),
                      child: Icon((noMute)?Icons.volume_up:Icons.volume_off,color: Colors.white70,),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      final index = _isPlayingIndex - 1;
                      if (index >= 0) {
                        onTapVideo(index);
                      } else {
                        Get.snackbar('Video', '',
                            snackPosition: SnackPosition.TOP,
                            icon: const Icon(
                              Icons.face,
                              size: 30,
                              color: Colors.white70,
                            ),
                            colorText: Colors.white70,
                            messageText: const Text(
                              'No more Video to play',
                              style: TextStyle(fontSize: 20, color: Colors.white70),
                            ),
                            backgroundColor: AppColors.gradientFirst);
                      }
                    },
                    icon: const Icon(
                      Icons.fast_rewind,
                      size: 36,
                      color: Colors.white70,
                    )),
                IconButton(
                    onPressed: () async {
                      if (_isPlaying) {
                        _controller!.pause();
                        setState(() {
                          _isPlaying = false;
                        });
                      } else {
                        _controller!.play();
                        setState(() {
                          _isPlaying = true;
                        });
                      }
                    },
                    icon: Icon(
                      (!_isPlaying) ? Icons.play_arrow : Icons.pause,
                      size: 36,
                      color: Colors.white70,
                    )),
                IconButton(
                    onPressed: () async {
                      final index = _isPlayingIndex + 1;

                      if (index <= videoInfo.length - 1) {
                        onTapVideo(index);
                      } else {
                        Get.snackbar('Video', '',
                            snackPosition: SnackPosition.TOP,
                            icon: const Icon(
                              Icons.face,
                              size: 30,
                              color: Colors.white70,
                            ),
                            colorText: Colors.white70,
                            messageText: const Text(
                              'No more Video to play in the list',
                              style: TextStyle(fontSize: 20, color: Colors.white70),
                            ),
                            backgroundColor: AppColors.gradientFirst);
                      }
                    },
                    icon: const Icon(
                      Icons.fast_forward,
                      size: 36,
                      color: Colors.white70,
                    )),
                Text(
                  '$mins:$secs',style: TextStyle(
                  color: Colors.white70,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0,1),
                      blurRadius: 4,
                      color: Color.fromARGB(150, 0, 0, 0),
                    )
                  ]
                ),
                )
              ],
            ),
          ],
        ),
      );
  }

//to update state

  void _onControllerUpdate() async {
    var _onUpdateControllerTime;

    //if disposed is true will exit from the method
    if (_disposed) {
      return;
    }
    //to limit invoking this method to improve video performance
    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint('controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint('controller cannot be initialized');
      return;
    }
    if(_duration==null){
      _duration=_controller!.value.duration;
    }
    var duration=_duration;
    if(duration==null) return;

    var position=await _controller!.position;
    _position=position;
    //to save state of video
    final playing = controller.value.isPlaying;
    if(_isPlaying){
      if(_disposed) return;
      setState(() {
        _progress=position!.inMilliseconds.ceilToDouble()/duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }
}
