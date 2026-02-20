import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EBF0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome,',
              style: TextStyle(
                color: Color(0xFF1A3B5D),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'User\'s Health Dashboard',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF6B7280),
              size: 26,
            ),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2B7EF8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                // TODO: Navigate to recovery
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Daily Adherence Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daily Adherence',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A3B5D),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1FAE5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Excellent',
                            style: TextStyle(
                              color: Color(0xFF059669),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Compliance Rate',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const Text(
                          '95%',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A3B5D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.95,
                        backgroundColor: const Color(0xFFE5E7EB),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF1A3B5D),
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Today's Actions
              const Text(
                'Today\'s Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3B5D),
                ),
              ),

              const SizedBox(height: 12),

              // Stop Food Action
              _buildActionCard(
                icon: Icons.remove,
                iconColor: Colors.white,
                iconBgColor: const Color(0xFF10B981),
                title: 'Stop Food',
                time: '18:00',
                borderColor: const Color(0xFF10B981),
                isCompleted: true,
              ),

              const SizedBox(height: 12),

              // Take Warfarin Action
              _buildActionCard(
                icon: Icons.medication_outlined,
                iconColor: Colors.white,
                iconBgColor: const Color(0xFF2B7EF8),
                title: 'Take Warfarin',
                time: '19:00',
                borderColor: const Color(0xFF2B7EF8),
                isCompleted: false,
              ),

              const SizedBox(height: 12),

              // Confirm Dose Taken
              _buildSimpleActionCard(
                icon: Icons.check,
                title: 'Confirm Dose Taken',
                isCompleted: false,
              ),

              const SizedBox(height: 12),

              // Start Food
              _buildSimpleActionCard(
                icon: Icons.restaurant_outlined,
                title: 'Start Food',
                subtitle: '20:00',
                isCompleted: false,
              ),

              const SizedBox(height: 24),

              // Daily Trackers
              const Text(
                'Daily Trackers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3B5D),
                ),
              ),

              const SizedBox(height: 12),

              // Extra Dose Taken
              _buildTrackerCard(
                context: context,
                icon: Icons.medication_outlined,
                iconBgColor: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFF59E0B),
                title: 'Extra Dose Taken',
                subtitle: 'Additional warfarin dose',
                buttonText: 'Record',
                route: '/extra-dose',
              ),

              const SizedBox(height: 12),

              // Vitamin K Intake
              _buildTrackerCard(
                context: context,
                icon: Icons.restaurant_outlined,
                iconBgColor: const Color(0xFFD1FAE5),
                iconColor: const Color(0xFF10B981),
                title: 'Vitamin K Intake',
                subtitle: 'Green leafy vegetables',
                buttonText: 'Track',
                route: '/vitamin-k',
              ),

              const SizedBox(height: 12),

              // Extra Medication
              _buildTrackerCard(
                context: context,
                icon: Icons.medication_liquid_outlined,
                iconBgColor: const Color(0xFFE9D5FF),
                iconColor: const Color(0xFF9333EA),
                title: 'Extra Medication',
                subtitle: 'Other medicines today',
                buttonText: 'Add',
                route: '/extra-medication',
              ),

              const SizedBox(height: 12),

              // Symptoms
              _buildTrackerCard(
                context: context,
                icon: Icons.warning_amber_outlined,
                iconBgColor: const Color(0xFFFEE2E2),
                iconColor: const Color(0xFFEF4444),
                title: 'Symptoms',
                subtitle: 'Report any symptoms',
                buttonText: 'Report',
                route: '/symptoms',
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String time,
    required Color borderColor,
    required bool isCompleted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A3B5D),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Color(0xFF9CA3AF),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF10B981) : Colors.white,
              border: Border.all(
                color: isCompleted
                    ? const Color(0xFF10B981)
                    : const Color(0xFFD1D5DB),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleActionCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool isCompleted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6B7280), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A3B5D),
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF10B981) : Colors.white,
              border: Border.all(
                color: isCompleted
                    ? const Color(0xFF10B981)
                    : const Color(0xFFD1D5DB),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerCard({
    required BuildContext context,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String buttonText,
    required String route,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A3B5D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B7EF8),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
