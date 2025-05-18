abstract class Playable {
  start();
  stop();
  pause();
  resume();
  bool isPaused();
  bool isStopped();
}

class PlayableGroup implements Playable {
  List<Playable> playables = [];

  addPlayable(Playable p) {
    playables.add(p);
  }

  removePlayable(Playable p) {
    playables.remove(p);
  }

  @override
  bool isPaused() {
    return playables.map((e) => e.isPaused()).reduce((a, b) => a && b);
  }

  @override
  bool isStopped() {
    return playables.map((e) => e.isStopped()).reduce((a, b) => a && b);
  }

  @override
  pause() {
    for (var p in playables) {
      p.pause();
    }
  }

  @override
  resume() {
    for (var p in playables) {
      p.resume();
    }
  }

  @override
  start() {
    for (var p in playables) {
      p.start();
    }
  }

  @override
  stop() {
    for (var p in playables) {
      p.stop();
    }
  }
}
