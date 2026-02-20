import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EBF0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2B7EF8),
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Tracker Insights',
          style: TextStyle(
            color: Color(0xFF1A3B5D),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Insufficient Data Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.show_chart,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Insufficient Data',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Need more INR readings to make predictions',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Recommendation Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: const Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFF2B7EF8),
                      size: 28,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recommendation',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A3B5D),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Continue tracking your INR regularly to enable predictions.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Recent Tracking Data
              const Text(
                'Recent Tracking Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3B5D),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTrackingItem(
                      color: const Color(0xFF2B7EF8),
                      label: 'Current INR',
                      value: '0.0',
                      valueColor: const Color(0xFF6B7280),
                    ),
                    const SizedBox(height: 16),
                    _buildTrackingItem(
                      color: const Color(0xFFF97316),
                      label: 'Missed Doses',
                      value: '1',
                      valueColor: const Color(0xFFEF4444),
                    ),
                    const SizedBox(height: 16),
                    _buildTrackingItem(
                      color: const Color(0xFFEF4444),
                      label: 'Extra Doses',
                      value: '0',
                      valueColor: const Color(0xFF6B7280),
                    ),
                    const SizedBox(height: 16),
                    _buildTrackingItem(
                      color: const Color(0xFF10B981),
                      label: 'Vitamin K Intake',
                      value: '80g',
                      valueColor: const Color(0xFF6B7280),
                    ),
                    const SizedBox(height: 16),
                    _buildTrackingItem(
                      color: const Color(0xFF9333EA),
                      label: 'Extra Medication',
                      value: 'Yes',
                      valueColor: const Color(0xFFEF4444),
                    ),
                    const SizedBox(height: 16),
                    _buildTrackingItem(
                      color: const Color(0xFFEF4444),
                      label: 'Symptoms',
                      value: '2',
                      valueColor: const Color(0xFFEF4444),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Next Steps Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFDEEBFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Next Steps',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildNextStepItem(
                      'Continue tracking your daily medication and diet consistently',
                    ),
                    const SizedBox(height: 12),
                    _buildNextStepItem(
                      'Monitor INR as scheduled by your healthcare provider',
                    ),
                    const SizedBox(height: 12),
                    _buildNextStepItem(
                      'Report any unusual symptoms immediately',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingItem({
    required Color color,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, color: Color(0xFF1A3B5D)),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildNextStepItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.chevron_right, color: Color(0xFF2B7EF8), size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1A3B5D)),
          ),
        ),
      ],
    );
  }
}
