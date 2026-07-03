import 'package:flutter/material.dart';

class AppAdsSection extends StatelessWidget {
  const AppAdsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        spacing: 8,
        children: [
          Container(
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              gradient: LinearGradient(
                colors: [const Color(0xFF141C29), const Color(0xFF1E293B)],
              ),
            ),

            padding: const EdgeInsets.all(20),

            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        'Reduce Monthly Expenses',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        'Track subscriptions and discover recurring charges.',
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                        ),

                        child: const Text(
                          'Analyze Now',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.insights,
                  color: Colors.white.withAlpha(220),
                  size: 64,
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              Container(
                height: 4,
                width: 12,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
