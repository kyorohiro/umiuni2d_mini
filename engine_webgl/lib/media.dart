library audio_webgl;

import 'dart:html' as html;
import 'dart:async';
import 'package:umiuni2d/media.dart' as media;
import 'dart:web_audio';


class WebglMediaManager extends media.MediaManager {
  String assetsRoot;

  WebglMediaManager(this.assetsRoot);

  Future<media.AudioSource> loadAudio(String path) {
    print("--A--");
    Completer<media.AudioSource> c = new Completer();
    AudioContext context = new AudioContext();
    html.HttpRequest request = new html.HttpRequest();
    request.open("GET", "${assetsRoot}${path}");
    request.responseType = "arraybuffer";
    request.onLoad.listen((html.ProgressEvent e) async {
      print("--B--");
      try {
        AudioBuffer buffer = await context.decodeAudioData(request.response);
        c.complete(new TinyWebglAudioSource(context, buffer));
      } catch (e) {
        print("--D-${path}- ${e}");
        c.completeError(e);
      }
    });

    request.onError.listen((html.ProgressEvent e) {
      print("--C--");
      c.completeError(e);
    });

    request.send();

    print("--D--");
    return c.future;
  }
}

class TinyWebglAudioSource extends media.AudioSource {
  AudioContext context;
  AudioBuffer buffer;
  AudioBufferSourceNode s = null;
  TinyWebglAudioSource(this.context, this.buffer) {}

  Future prepare() async {}
  Future start({double volume: 1.0, bool looping: false}) async {
    await pause();
    s = context.createBufferSource();
    GainNode gain = context.createGain();
    s.connectNode(gain);
    gain.connectNode(context.destination);
    s.buffer = buffer;
    s.loop = looping;
    gain.gain.value = volume;

    s.connectNode(context.destination);
    s.start(0);
  }

  Future pause() async {
    if (s != null) {
      s.stop(0);
      s = null;
    }
  }

  double _volume = 0.5;
  double get volume => _volume;
  void set volume(double v) {
    _volume = v;
  }
}