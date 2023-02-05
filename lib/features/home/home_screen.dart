import 'package:audio_player/features/home/home_bloc.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //region Bloc
  late HomeBloc homeBloc;
  //endregion

  //region Init
  @override
  void initState() {
    homeBloc = HomeBloc(context: context);
    homeBloc.init();
    super.initState();
  }

  //endregion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: SafeArea(child: body()),
    );
  }

  //region Body
  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        audioList(),
        player(),
      ],
    );
  }
  //endregion

  //region Audio list
  Widget audioList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 100,
          itemBuilder: (context, index) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                //homeBloc.init();
              },
              child: Container(
                width: 100,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
              ),
            );
          }),
    );
  }
//endregion

//region Player
  Widget player() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          color: Colors.grey,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    homeBloc.onTapPlayButton();
                  },
                  child: StreamBuilder<PlayerState>(
                    stream: homeBloc.audioPlayer.playerStateStream,
                    initialData: homeBloc.audioPlayer.playerState,
                    builder: (context, snapshot) {
                      final playerState = homeBloc.audioPlayer.processingState;
                      bool isPlaying = snapshot.data!.playing;
                      if(isPlaying){
                        return Icon(Icons.pause);
                      }
                      //Loading
                      if(playerState == ProcessingState.loading){
                        return CircularProgressIndicator();
                      }
                      return Icon(Icons.play_arrow);

                    }
                  )),
              Text(
                "Song name",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Icon(Icons.person)
            ],
          ),
        ),

      ],
    );
  }
//endregion
}
