import 'package:posthog_flutter/posthog_flutter.dart';

import 'analytics_service.dart';

final class PostHogAnalyticsService implements AnalyticsService {
  final Posthog _posthog;

  PostHogAnalyticsService({Posthog? posthog}) : _posthog = posthog ?? Posthog();

  @override
  Future<void> track(String event, {Map<String, Object>? properties}) async {
    await _posthog.capture(eventName: event, properties: properties);
  }

  @override
  Future<void> identify(
    String userId, {
    Map<String, Object>? properties,
  }) async {
    await _posthog.identify(userId: userId, userProperties: properties);
  }

  @override
  Future<void> reset() async {
    await _posthog.reset();
  }

  @override
  Future<void> screen(String screenName) async {
    await _posthog.screen(screenName: screenName);
  }
}
