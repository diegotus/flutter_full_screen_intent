import 'flutter_full_screen_intent_platform_interface.dart';

class FlutterFullScreenIntent {
  Future<String?> getPlatformVersion() {
    return FlutterFullScreenIntentPlatform.instance.getPlatformVersion();
  }

  Future<bool> openFullScreenWidget([
    String route = '/',
    Map<String, String>? args,
  ]) async {
    return await FlutterFullScreenIntentPlatform.instance.openFullScreenWidget(
      route,
      args,
    );
  }
}
