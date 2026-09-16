import 'package:posthog_flutter/posthog_flutter.dart';

import 'package:getx_drift_app/core/config/app_environment.dart';

abstract final class PostHogInitializer {
  static Future<void> initialize() async {
    const token = AppEnvironment.posthogProjectToken;

    if (token.isEmpty) {
      return;
      // TODO: Remove return; and uncomment the throw on production
      // throw StateError('POSTHOG_PROJECT_TOKEN is not configured.');
    }

    final config = PostHogConfig(token);

    config.host = 'https://us.i.posthog.com';

    config.debug = true;

    config.captureApplicationLifecycleEvents = true;

    config.sessionReplay = true;

    config.errorTrackingConfig.captureFlutterErrors = true;
    config.errorTrackingConfig.capturePlatformDispatcherErrors = true;
    config.errorTrackingConfig.captureIsolateErrors = true;
    config.errorTrackingConfig.captureNativeExceptions = true;

    await Posthog().setup(config);
  }
}
