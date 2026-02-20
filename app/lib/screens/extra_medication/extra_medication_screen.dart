import 'package:flutter/material.dart';

class ExtraMedicationScreen extends StatefulWidget {
  const ExtraMedicationScreen({super.key});

  @override
  State<ExtraMedicationScreen> createState() => _ExtraMedicationScreenState();
}

class _ExtraMedicationScreenState extends State<ExtraMedicationScreen> {
  String? _selectedAnswer;
  String? _selectedCategory;
  final TextEditingController _medicationNameController =
      TextEditingController();
  final TextEditingController _dosageController = TextEditingController();

  @override
  void dispose() {
    _medicationNameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  bool _canSave() {
    if (_selectedAnswer == null) return false;
    if (_selectedAnswer == 'No') return true;
    // For 'Yes', check if all required fields are filled
    return _selectedCategory != null &&
        _medicationNameController.text.isNotEmpty &&
        _dosageController.text.isNotEmpty;
  }

  void _saveRecord() {
    if (_canSave()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Saved Successfully',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF9333EA),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate back after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E8FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF9333EA),
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Extra Medication',
          style: TextStyle(
            color: Color(0xFF6B21A8),
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

              // Main Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9D5FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.medication_liquid_outlined,
                        color: Color(0xFF9333EA),
                        size: 50,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      'Other Medications',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3B5D),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      'Track any additional medicines',
                      style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Question
                    const Text(
                      'Did you take any extra medication today?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    // Yes/No Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedAnswer = 'Yes';
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _selectedAnswer == 'Yes'
                                  ? const Color(0xFF9333EA)
                                  : const Color(0xFF6B7280),
                              side: BorderSide(
                                color: _selectedAnswer == 'Yes'
                                    ? const Color(0xFF9333EA)
                                    : const Color(0xFFD1D5DB),
                                width: 2,
                              ),
                              backgroundColor: _selectedAnswer == 'Yes'
                                  ? const Color(0xFFF3E8FF)
                                  : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedAnswer = 'No';
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _selectedAnswer == 'No'
                                  ? const Color(0xFF9333EA)
                                  : const Color(0xFF6B7280),
                              side: BorderSide(
                                color: _selectedAnswer == 'No'
                                    ? const Color(0xFF9333EA)
                                    : const Color(0xFFD1D5DB),
                                width: 2,
                              ),
                              backgroundColor: _selectedAnswer == 'No'
                                  ? const Color(0xFFF3E8FF)
                                  : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Show content based on selection
              if (_selectedAnswer == 'Yes') ...[
                // Medication Category Dropdown
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Medication Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A3B5D),
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFEF4444),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: const InputDecoration(
                            hintText: 'Select category',
                            hintStyle: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          items:
                              [
                                'Pain Relief',
                                'Antibiotics',
                                'Heart & Blood Pressure',
                                'Diabetes',
                                'Vitamins & Supplements',
                                'Other',
                              ].map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Medication Name
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Medication Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A3B5D),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _medicationNameController,
                        decoration: InputDecoration(
                          hintText: 'e.g., Amoxicillin, Ibuprofen',
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
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Dose & Frequency
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dose & Frequency',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A3B5D),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _dosageController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'e.g., 500mg twice daily',
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
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Warning Card
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFEF4444),
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF991B1B),
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Warning: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'Some medications can interact with warfarin. Please inform your healthcare provider about all medications you\'re taking.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              if (_selectedAnswer == 'No') ...[
                // No medication message card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFD1D5DB),
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Center(
                    child: Text(
                      'No additional medication recorded for today',
                      style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 16),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _canSave() ? _saveRecord : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _canSave()
                        ? const Color(0xFF9333EA)
                        : const Color(0xFFD1D5DB),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFD1D5DB),
                    disabledForegroundColor: const Color(0xFF9CA3AF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Save Medication Info',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
