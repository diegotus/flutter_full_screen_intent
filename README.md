# flutter full screen intent

A plugin to open an app to a specific page even if the app is closed.

## Getting Started

### AndroidManifest.xml setup
Add this those lines into the AndroidManifest.xml inside the /android/app/src/main;

 ```xml
<activity
    android:name="io.flutter.embedding.android.FlutterActivity"
    android:theme="@style/LaunchTheme"
    android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
    android:hardwareAccelerated="true"
    android:windowSoftInputMode="adjustResize"
    android:exported="true"
    android:showWhenLocked="true"
    android:turnScreenOn="true"
>
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
</activity>
```

Add android:showWhenLocked="true" and android:turnScreenOn="true" for full-screen-intent like above. if you dont want full-screen-intent, remove them.

### Utilisation

```dart
import 'package:flutter_full_screen_intent/flutter_full_screen_intent.dart';

await FlutterFullScreenIntent().openFullScreenWidget('/FullScreenTest',{"arguments":"test"});
```
