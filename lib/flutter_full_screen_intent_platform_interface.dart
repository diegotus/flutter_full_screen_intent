import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_full_screen_intent_method_channel.dart';

abstract class FlutterFullScreenIntentPlatform extends PlatformInterface {
  /// Constructs a FlutterFullScreenIntentPlatform.
  FlutterFullScreenIntentPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFullScreenIntentPlatform _instance =
      MethodChannelFlutterFullScreenIntent();

  /// The default instance of [FlutterFullScreenIntentPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFullScreenIntent].
  static FlutterFullScreenIntentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFullScreenIntentPlatform] when
  /// they register themselves.
  static set instance(FlutterFullScreenIntentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> openFullScreenWidget([String route = '/']) async {
    throw UnimplementedError(
      'openFullScreenWidget() has not been implemented.',
    );
  }
}
