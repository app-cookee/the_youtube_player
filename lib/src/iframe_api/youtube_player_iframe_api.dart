import 'package:the_youtube_player/src/iframe_api/src/functions/playback_controls.dart';
import 'package:the_youtube_player/src/iframe_api/src/functions/playback_status.dart';
import 'package:the_youtube_player/src/iframe_api/src/functions/player_settings.dart';
import 'package:the_youtube_player/src/iframe_api/src/functions/video_information.dart';

import 'src/functions/queueing_functions.dart';

export 'src/functions/queueing_functions.dart' show ListType;

/// The skeleton for YouTube IFrame Player API.
abstract class YoutubePlayerIFrameAPI
    implements
        QueueingFunctions,
        VideoInformation,
        PlayerSettings,
        PlaybackControls,
        PlaybackStatus {}
