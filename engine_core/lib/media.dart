library media;

import 'dart:async';

abstract class MediaManager {
  Future<AudioSource> loadAudio(String path);
}

abstract class AudioSource {
  Future prepare();
  Future start({double volume:1.0, bool looping:false});
  Future pause();
}
