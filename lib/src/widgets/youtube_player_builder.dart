import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:the_youtube_player/the_youtube_player.dart';

/// A wrapper for [TheYoutubePlayer].
class TheYoutubePlayerBuilder extends StatefulWidget {
  /// The actual [TheYoutubePlayer].
  final TheYoutubePlayer player;

  /// Builds the widget below this [builder].
  final Widget Function(BuildContext, Widget) builder;

  /// Callback to notify that the player has entered fullscreen.
  final VoidCallback? onEnterFullScreen;

  /// Callback to notify that the player has exited fullscreen.
  final VoidCallback? onExitFullScreen;

  /// Builder for [TheYoutubePlayer] that supports switching between fullscreen and normal mode.
  const TheYoutubePlayerBuilder({
    Key? key,
    required this.player,
    required this.builder,
    this.onEnterFullScreen,
    this.onExitFullScreen,
  }) : super(key: key);

  @override
  _TheYoutubePlayerBuilderState createState() => _TheYoutubePlayerBuilderState();
}

class _TheYoutubePlayerBuilderState extends State<TheYoutubePlayerBuilder> with WidgetsBindingObserver {
  final GlobalKey playerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final physicalSize = SchedulerBinding.instance.window.physicalSize;
    final controller = widget.player.controller;
    if (physicalSize.width > physicalSize.height) {
      controller.updateValue(controller.value.copyWith(isFullScreen: true));
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      widget.onEnterFullScreen?.call();
    } else {
      controller.updateValue(controller.value.copyWith(isFullScreen: false));
      SystemChrome.restoreSystemUIOverlays();
      widget.onExitFullScreen?.call();
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    final _player = Container(
      key: playerKey,
      child: WillPopScope(
        onWillPop: () async {
          final controller = widget.player.controller;
          if (controller.value.isFullScreen) {
            widget.player.controller.toggleFullScreenMode();
            return false;
          }
          return true;
        },
        child: widget.player,
      ),
    );
    final child = widget.builder(context, _player);
    return OrientationBuilder(
      builder: (context, orientation) => orientation == Orientation.portrait ? child : _player,
    );
  }
}
