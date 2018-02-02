library media_flutter;
import 'dart:async';
import 'dart:io'as dio;
import 'package:umiuni2d/media.dart' as media;
import 'package:umiuni2d_audio/umiuni2d_audio.dart' as audio;


class FlutterMediaManager extends media.MediaManager{
  String assetRoot;
  audio.Umiuni2dAudio _audioManager;
  FlutterMediaManager(this.assetRoot) {
    _audioManager = new audio.Umiuni2dAudio();
  }
  Future<media.AudioSource> loadAudio(String path) async {
    _audioManager = new audio.Umiuni2dAudio();
    await _audioManager.setupFromAssets(assetRoot + path);
    String assetPath = await _audioManager.getAssetPath("assets/bgm_maoudamashii_acoustic09.mp3");
    if(await (new dio.File(assetPath)).exists()) {
      print("# exist" + '\r\n');
    } else {
      print("# no exist" + '\r\n');
    }
    await _audioManager.load(assetRoot + path);
    return new FlutterAudioSource(_audioManager);
  }
}

class FlutterAudioSource extends media.AudioSource {
  audio.Umiuni2dAudio _audioManager;
  FlutterAudioSource(this._audioManager);

  Future prepare() async {
    //    await _audioManager.prepareAssetPath(key).prepare();
  }

  Future start({double volume:1.0, bool looping:false}) async {
    await _audioManager.setVolume(1.0, 0);
    String v= await _audioManager.play();
    print("# play " +v );
  }

  Future pause() async  {
    await _audioManager.pause();
    return null;
  }

}
