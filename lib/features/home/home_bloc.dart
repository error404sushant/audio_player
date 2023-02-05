import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
enum HomeScreenState { Loading,Pause, Playing, Failed, Empty }

class HomeBloc {
  //region Common variable
  late BuildContext context;

  // final player = AudioPlayer();
  late AudioPlayer audioPlayer;
 late bool isPlaying  = true;

  //endregion

//region Text Editing Controller
//endregion

//region Controller
  final playerCtrl = StreamController<HomeScreenState>.broadcast();
//endregion
  //region Constructor
  HomeBloc({required context});

  //endregion
//region Init
   init() async{
    audioPlayer = AudioPlayer();
    var url = "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3";
    final duration = await audioPlayer.setUrl(url);
    // Set a sequence of audio sources that will be played by the audio player.
    // player.setAudioSource(ConcatenatingAudioSource(children: [
    //   AudioSource.uri(Uri.parse(
    //       "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3")),
    // ]))
    //     .catchError((error) {
    //   // catch load errors: 404, invalid url ...
    //   print("An error occured $error");
    // });
  }

//endregion

  //region On tap play button
  void onTapPlayButton(){
    // isPlaying = !isPlaying;
    audioPlay();

  }
  //endregion

//region Audio play
  void audioPlay() async {
    try{
      isPlaying = !isPlaying;

      //If it is playing then pause
      if(isPlaying){
        await audioPlayer.pause();
        return;
      }else{
        await audioPlayer.play();
        return;
      }
      // if(isPlaying){
      //   stateCheck();
      //   var url = "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3";
      //   final duration = await audioPlayer.setUrl(url);
      //   await audioPlayer.play();
        //Playing

      // }else{
      //   await audioPlayer.pause();
      //   stateCheck();
      // }


    }
    catch(e){

    }
  }

//endregion


//region State check
  void stateCheck() {
    // audioPlayer.playerStateStream.listen((state) {
    //   if (state.playing) {
    //     return;
    //   } else {
    //     switch (state.processingState) {
    //       case ProcessingState.idle:
    //         print("Ideeal");
    //         break;
    //       case ProcessingState.loading:
    //         playerCtrl.sink.add(HomeScreenState.Loading);
    //
    //         print("Loading");
    //         break;
    //
    //       case ProcessingState.buffering:
    //         print("Buffering");
    //         break;
    //       case ProcessingState.ready:
    //         print("Ready");
    //         playerCtrl.sink.add(HomeScreenState.Pause);
    //         break;
    //       case ProcessingState.completed:
    //         print("Complete");
    //     }
    //   }
    // });
  }
//endregion

}
