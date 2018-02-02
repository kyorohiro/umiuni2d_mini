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
    await this.start(volume: volume);
  }

  Future pause() async  {
    await this.pause();
    return null;
  }

}
