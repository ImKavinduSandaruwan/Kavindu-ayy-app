import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DoseInrScreen extends StatefulWidget {
  const DoseInrScreen({super.key});

  @override
  State<DoseInrScreen> createState() => _DoseInrScreenState();
}

class _DoseInrScreenState extends State<DoseInrScreen> {
  final TextEditingController _inrController = TextEditingController();
  final double _currentInr = 2.3;
  final double _targetMin = 2.0;
  final double _targetMax = 3.0;

  bool _showDosePrediction = false;
  double _enteredInr = 0.0;
  double _recommendedDose = 0.0;
  String _riskLevel = '';
  String _actionRequired = '';
  int _nextCheckDays = 7;

  @override
  void dispose() {
    _inrController.dispose();
    super.dispose();
  }

  // Sample INR data for the last 2 months
  List<FlSpot> _getInrData() {
    return [
      const FlSpot(0, 2.4),
      const FlSpot(1, 2.6),
      const FlSpot(2, 2.5),
      const FlSpot(3, 2.7),
      const FlSpot(4, 2.6),
      const FlSpot(5, 2.4),
      const FlSpot(6, 2.5),
      const FlSpot(7, 2.8),
      const FlSpot(8, 2.7),
      const FlSpot(9, 2.9),
      const FlSpot(10, 2.8),
      const FlSpot(11, 2.6),
      const FlSpot(12, 2.5),
      const FlSpot(13, 2.7),
      const FlSpot(14, 2.3),
    ];
  }

  void _calculateDose() {
    if (_inrController.text.isNotEmpty) {
      final inr = double.tryParse(_inrController.text);
      if (inr == null || inr <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please enter a valid INR value'),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        return;
      }

      setState(() {
        _enteredInr = inr;
        _showDosePrediction = true;

        // Simple dose calculation logic based on INR
        if (inr < _targetMin) {
          // INR too low - increase dose
          _recommendedDose = 5.5;
          _riskLevel = 'Medium Risk';
          _actionRequired = 'Increase dose';
          _nextCheckDays = 5;
        } else if (inr > _targetMax) {
          // INR too high - decrease dose
          _recommendedDose = 4.0;
          _riskLevel = 'High Risk';
          _actionRequired = 'Decrease dose';
          _nextCheckDays = 3;
        } else {
          // INR in range - maintain dose
          _recommendedDose = 5.0;
          _riskLevel = 'Low Risk';
          _actionRequired = 'Maintain current dose';
          _nextCheckDays = 7;
        }
      });
    }
  }

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
          'Dose & INR',
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

              // Current INR Card
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2B7EF8), Color(0xFF1E5FD9)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current INR',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _currentInr.toString(),
                            style: const TextStyle(
                              fontSize: 48,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (_currentInr - 1) / 3,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Target: $_targetMin - $_targetMax',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.show_chart,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Enter Latest INR Value Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Latest INR Value',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'INR Value',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _inrController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        hintText: 'e.g., 2.5',
                        hintStyle: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF3F4F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _calculateDose,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B7EF8),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Calculate Recommended Dose',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Dose Prediction Card (shown after calculation)
              if (_showDosePrediction) ...[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Dose Prediction',
                            style: TextStyle(
                              fontSize: 20,
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
                              color: _riskLevel == 'Low Risk'
                                  ? const Color(0xFFD1FAE5)
                                  : _riskLevel == 'Medium Risk'
                                  ? const Color(0xFFFEF3C7)
                                  : const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _riskLevel,
                              style: TextStyle(
                                color: _riskLevel == 'Low Risk'
                                    ? const Color(0xFF059669)
                                    : _riskLevel == 'Medium Risk'
                                    ? const Color(0xFFF59E0B)
                                    : const Color(0xFFEF4444),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Current INR',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _enteredInr.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1A3B5D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Recommended Dose',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF059669),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _recommendedDose.toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF059669),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          'mg',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF059669),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.trending_up,
                              color: Color(0xFF10B981),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Action Required',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _actionRequired,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1A3B5D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Color(0xFF2B7EF8),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Next INR Check',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$_nextCheckDays days',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1A3B5D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // INR Trend Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'INR Trend',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            horizontalInterval: 1,
                            verticalInterval: 3,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: const Color(0xFFE5E7EB),
                                strokeWidth: 1,
                                dashArray: [5, 5],
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: const Color(0xFFE5E7EB),
                                strokeWidth: 1,
                                dashArray: [5, 5],
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 3,
                                getTitlesWidget: (value, meta) {
                                  const dates = [
                                    '2026-01-25',
                                    '2026-01-29',
                                    '2026-02-07',
                                  ];
                                  final index = (value ~/ 3).clamp(
                                    0,
                                    dates.length - 1,
                                  );
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      dates[index],
                                      style: const TextStyle(
                                        color: Color(0xFF9CA3AF),
                                        fontSize: 10,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF9CA3AF),
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: 14,
                          minY: 0,
                          maxY: 4,
                          lineBarsData: [
                            // INR Values Line
                            LineChartBarData(
                              spots: _getInrData(),
                              isCurved: true,
                              color: const Color(0xFF2B7EF8),
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4,
                                    color: const Color(0xFF2B7EF8),
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  );
                                },
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                color: const Color(0xFF2B7EF8).withOpacity(0.1),
                              ),
                            ),
                            // Target Range Line
                            LineChartBarData(
                              spots: [
                                FlSpot(0, _targetMin),
                                FlSpot(14, _targetMin),
                              ],
                              isCurved: false,
                              color: const Color(0xFF10B981),
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                              dashArray: [5, 5],
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            enabled: true,
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((spot) {
                                  if (spot.barIndex == 0) {
                                    return LineTooltipItem(
                                      'INR: ${spot.y.toStringAsFixed(1)}',
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  return null;
                                }).toList();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem(
                          color: const Color(0xFF2B7EF8),
                          label: 'INR Values',
                        ),
                        const SizedBox(width: 24),
                        _buildLegendItem(
                          color: const Color(0xFF10B981),
                          label: 'Target Range',
                          isDashed: true,
                        ),
                      ],
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

  Widget _buildLegendItem({
    required Color color,
    required String label,
    bool isDashed = false,
  }) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 3,
          decoration: BoxDecoration(
            color: isDashed ? Colors.transparent : color,
            border: isDashed ? Border.all(color: color, width: 2) : null,
          ),
          child: isDashed
              ? CustomPaint(painter: DashedLinePainter(color: color))
              : null,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 3;
    const dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
