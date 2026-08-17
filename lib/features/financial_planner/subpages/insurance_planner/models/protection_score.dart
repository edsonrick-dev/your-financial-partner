import 'package:flutter/animation.dart';

class ProtectionScore {
  final String title;
  final String description;
  final Color color;

  const ProtectionScore({
    required this.title,
    required this.description,
    required this.color,
  });

  static const financiallySecured = ProtectionScore(
    title: 'Financially Secured',
    description: 'All essential protection goals are covered.',
    color: Color(0xFF16A34A),
  );

  static const almostSecured = ProtectionScore(
    title: 'Almost Secured',
    description: 'Your protection is strong with only minor gaps.',
    color: Color(0xFFCA8A04),
  );

  static const moderatelyProtected = ProtectionScore(
    title: 'Moderately Protected',
    description:
        'Your protection is established but still has room to improve.',
    color: Color(0xFFCA8A04),
  );

  static const unevenProtection = ProtectionScore(
    title: 'Uneven Protection',
    description:
        'Some protection areas are strong while others remain exposed.',
    color: Color(0xFFF97316),
  );

  static const vulnerableCoverage = ProtectionScore(
    title: 'Vulnerable Coverage',
    description: 'Your protection has significant gaps across key areas.',
    color: Color(0xFFF97316),
  );

  static const financiallyExposed = ProtectionScore(
    title: 'Financially Exposed',
    description: 'Your protection is insufficient across all key areas.',
    color: Color(0xFFDC2626),
  );
}
