import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_full_screen_intent_platform_interface.dart';

/// An implementation of [FlutterFullScreenIntentPlatform] that uses method channels.
class MethodChannelFlutterFullScreenIntent
    extends FlutterFullScreenIntentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_full_screen_intent');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<bool> openFullScreenWidget([
    String route = '/',
    Map<String, String>? args,
  ]) async {
    return await methodChannel.invokeMethod<bool>('openFullScreenWidget', {
          'route': route,
          if (args != null) "arguments": args,
        }) ??
        false;
  }
}
