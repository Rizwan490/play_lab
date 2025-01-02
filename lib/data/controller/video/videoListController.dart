import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:video_player/video_player.dart';

typedef LoadMoreVideo = Future<List<VPVideoController>> Function(int index, List<VPVideoController> list);

class VideoListController extends ChangeNotifier {
  VideoListController({this.loadMoreCount = 1, this.preloadCount = 2, this.disposeCount = 0});

  final int loadMoreCount;

  final int preloadCount;

  final int disposeCount;


  loadIndex(int target, {bool reload = false}) {
    if (!reload) {
      if (index.value == target) return;
    }

    var oldIndex = index.value;
    var newIndex = target;

    if (!(oldIndex == 0 && newIndex == 0)) {
      playerOfIndex(oldIndex)?.controller.seekTo(Duration.zero);

      playerOfIndex(oldIndex)?.pause();
      printx('old Index$oldIndex');
    }

    playerOfIndex(newIndex)?.controller.addListener(_didUpdateValue);
    playerOfIndex(newIndex)?.showPauseIcon.addListener(_didUpdateValue);
    playerOfIndex(newIndex)?.play();
    printx('New Index $newIndex');

    for (var i = 0; i < playerList.length; i++) {
      if (i < newIndex - disposeCount || i > newIndex + max(disposeCount, 2)) {
        printx('index$i');
        playerOfIndex(i)?.controller.removeListener(_didUpdateValue);
        playerOfIndex(i)?.showPauseIcon.removeListener(_didUpdateValue);
        playerOfIndex(i)?.dispose();
        continue;
      }

      if (i > newIndex && i < newIndex + preloadCount) {
        printx('preload$i');
        playerOfIndex(i)?.init();
        continue;
      }
    }
// rotating from zero
    // if (playerList.length - newIndex <= loadMoreCount + 1) {
    //   _videoProvider?.call(newIndex, playerList).then(
    //     (list) async {
    //       playerList.addAll(list);
    //       notifyListeners();
    //     },
    //   );
    // }

    index.value = target;
  }

  _didUpdateValue() {
    notifyListeners();
  }

  VPVideoController? playerOfIndex(int index) {
    if (index < 0 || index > playerList.length - 1) {
      return null;
    }
    return playerList[index];
  }

  int get videoCount => playerList.length;

  init({
    required PageController pageController,
    required List<VPVideoController> initialList,
    required LoadMoreVideo videoProvider,
  }) async {
    playerList.addAll(initialList);
    pageController.addListener(() {
      var p = pageController.page!;
      if (p % 1 == 0) {
        loadIndex(p ~/ 1);
      }
    });
    loadIndex(0, reload: true);
    notifyListeners();
  }

  ValueNotifier<int> index = ValueNotifier<int>(0);

  List<VPVideoController> playerList = [];

  VPVideoController get currentPlayer => playerList[index.value];

  @override
  void dispose() {
    for (var player in playerList) {
      player.showPauseIcon.dispose();
      player.dispose();
    }
    playerList = [];
    super.dispose();
  }
}

typedef ControllerSetter<T> = Future<void> Function(T controller);
typedef ControllerBuilder<T> = T Function();

abstract class ReelsVideoController<T> {
  T? get controller;

  ValueNotifier<bool> get showPauseIcon;

  Future<void> init({ControllerSetter<T>? afterInit});

  Future<void> dispose();

  Future<void> play();

  Future<void> pause({bool showPauseIcon = false});
}

Completer<void>? _syncLock;

class VPVideoController extends ReelsVideoController<VideoPlayerController> {
  VideoPlayerController? _controller;
  final ValueNotifier<bool> _showPauseIcon = ValueNotifier<bool>(false);

  final String? videoInfo;

  final ControllerBuilder<VideoPlayerController> _builder;
  final ControllerSetter<VideoPlayerController>? _afterInit;

  VPVideoController({
    this.videoInfo,
    required ControllerBuilder<VideoPlayerController> builder,
    ControllerSetter<VideoPlayerController>? afterInit,
  })  : _builder = builder,
        _afterInit = afterInit;

  @override
  VideoPlayerController get controller {
    _controller ??= _builder.call();
    return _controller!;
  }

  bool get isDispose => _disposeLock != null;

  bool get prepared => _prepared;
  bool _prepared = false;

  Completer<void>? _disposeLock;

  Future<void> _syncCall(Future Function()? fn) async {
    var lastCompleter = _syncLock;
    var completer = Completer<void>();
    _syncLock = completer;

    await lastCompleter?.future;

    await fn?.call();

    completer.complete();
  }

  @override
  Future<void> dispose() async {
    if (!prepared) return;
    _prepared = false;
    _controller?.dispose();
    await _syncCall(() async {
      printx('+++dispose $hashCode');
      await controller.dispose();
      _controller = null;
      printx('+++==dispose $hashCode');
      _disposeLock = Completer<void>();
    });
  }

  @override
  Future<void> init({
    ControllerSetter<VideoPlayerController>? afterInit,
  }) async {
    if (prepared) return;
    await _syncCall(() async {
      printx('+++initialize $hashCode');
      await controller.initialize();
      await controller.setLooping(true);

      afterInit ??= _afterInit;
      await afterInit?.call(controller);
      printx('+++==initialize $hashCode');
      _prepared = true;
    });
    if (_disposeLock != null) {
      _disposeLock?.complete();
      _disposeLock = null;
    }
  }

  @override
  Future<void> pause({bool showPauseIcon = false}) async {
    await init();
    if (!prepared) return;
    if (_disposeLock != null) {
      await _disposeLock?.future;
    }
    await controller.pause();
    _showPauseIcon.value = true;
  }

  @override
  Future<void> play() async {
    await init();
    if (!prepared) return;
    if (_disposeLock != null) {
      await _disposeLock?.future;
    }
    await controller.play();
    _showPauseIcon.value = false;
  }

  @override
  ValueNotifier<bool> get showPauseIcon => _showPauseIcon;
}
