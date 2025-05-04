import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_full_screen_intent/flutter_full_screen_intent.dart';
import 'package:flutter_full_screen_intent/flutter_full_screen_intent_platform_interface.dart';
import 'package:flutter_full_screen_intent/flutter_full_screen_intent_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFullScreenIntentPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFullScreenIntentPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterFullScreenIntentPlatform initialPlatform = FlutterFullScreenIntentPlatform.instance;

  test('$MethodChannelFlutterFullScreenIntent is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFullScreenIntent>());
  });

  test('getPlatformVersion', () async {
    FlutterFullScreenIntent flutterFullScreenIntentPlugin = FlutterFullScreenIntent();
    MockFlutterFullScreenIntentPlatform fakePlatform = MockFlutterFullScreenIntentPlatform();
    FlutterFullScreenIntentPlatform.instance = fakePlatform;

    expect(await flutterFullScreenIntentPlugin.getPlatformVersion(), '42');
  });
}
