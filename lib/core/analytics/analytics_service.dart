abstract class AnalyticsService {
  Future<void> track(String event, {Map<String, Object>? properties});

  Future<void> identify(String userId, {Map<String, Object>? properties});

  Future<void> reset();

  Future<void> screen(String screenName);
}
