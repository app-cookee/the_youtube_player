import 'package:flutter/widgets.dart';

import '../controller/the_youtube_player_controller.dart';

/// An inherited widget to provide [TheYoutubePlayerController] to it's descendants.
class YoutubePlayerControllerProvider extends InheritedWidget {
  /// The [TheYoutubePlayerController].
  final TheYoutubePlayerController controller;

  /// An inherited widget that provide [TheYoutubePlayerController] to it's descendants.
  const YoutubePlayerControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// Finds the most recent [TheYoutubePlayerController] in its ancestors.
  static TheYoutubePlayerController of(BuildContext context) {
    final controllerProvider = context.dependOnInheritedWidgetOfExactType<YoutubePlayerControllerProvider>();
    assert(
      controllerProvider != null,
      'Cannot find YoutubePlayerControllerProvider above. Please wrap parent widget with YoutubePlayerControllerProvider.',
    );
    return controllerProvider!.controller;
  }

  /// Finds the most recent [TheYoutubePlayerController] in its ancestors.
  static TheYoutubePlayerController? maybeOf(BuildContext context) {
    final controllerProvider = context.dependOnInheritedWidgetOfExactType<YoutubePlayerControllerProvider>();

    return controllerProvider?.controller;
  }

  @override
  bool updateShouldNotify(YoutubePlayerControllerProvider old) {
    return old.controller.hashCode != controller.hashCode;
  }
}

/// YoutubePlayerControllerExtension
extension YoutubePlayerControllerExtension on BuildContext {
  /// Finds the most recent [TheYoutubePlayerController] in its ancestors.
  TheYoutubePlayerController get ytController {
    return YoutubePlayerControllerProvider.of(this);
  }
}
