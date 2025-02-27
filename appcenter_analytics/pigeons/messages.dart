// ignore_for_file: avoid_positional_boolean_parameters, prefer-match-file-name

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    swiftOut: 'ios/Classes/Messages.g.swift',
    kotlinOut:
        'android/src/main/kotlin/com/optimizely/plugin/appcenter_analytics/Messages.g.kt',
    kotlinOptions:
        KotlinOptions(package: 'com.optimizely.plugin.appcenter_analytics'),
  ),
)
@HostApi()
abstract class AppCenterApi {
  void setUserId(final String userId);
  void start(final String secret);
  @async
  void setEnabled(final bool enabled);
  @async
  bool isEnabled();
  bool isConfigured();
  @async
  String getInstallId();
  bool isRunningInAppCenterTestCloud();
}

@HostApi()
abstract class AppCenterAnalyticsApi {
  void trackEvent(
    final String name,
    final Map<String, String>? properties,
    final int? flags,
  );
  void pause();
  void resume();
  @async
  void analyticsSetEnabled(final bool enabled);
  @async
  bool analyticsIsEnabled();
  void enableManualSessionTracker();
  void startSession();
  bool setTransmissionInterval(final int seconds);
}

@HostApi()
abstract class AppCenterCrashesApi {
  void generateTestCrash();
  @async
  bool hasReceivedMemoryWarningInLastSession();
  @async
  bool hasCrashedInLastSession();
  @async
  void crashesSetEnabled(final bool enabled);
  @async
  bool crashesIsEnabled();
  void trackException(
    final String message,
    final String? type,
    final String? stackTrace,
    final Map<String, String>? properties,
  );
}
