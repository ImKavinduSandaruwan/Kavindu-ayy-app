import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _minINRController = TextEditingController();
  final _maxINRController = TextEditingController();
  final _warfarinDoseController = TextEditingController();
  String? _selectedGender;
  String? _selectedValveType;
  String? _selectedValvePosition;
  TimeOfDay? _selectedDoseTime;

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _minINRController.dispose();
    _maxINRController.dispose();
    _warfarinDoseController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedDoseTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedDoseTime) {
      setState(() {
        _selectedDoseTime = picked;
      });
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '12:30';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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
          'Create Account',
          style: TextStyle(
            color: Color(0xFF1A3B5D),
            fontSize: 24,
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
              const SizedBox(height: 16),

              // Personal Information Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Full Name
                    const Text(
                      'Full Name *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your full name',
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
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Age and Weight Row
                    Row(
                      children: [
                        // Age Field
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Age *',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A3B5D),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextField(
                                  controller: _ageController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Age',
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
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Weight Field
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Weight (kg) *',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A3B5D),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextField(
                                  controller: _weightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Weight',
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Gender Dropdown
                    const Text(
                      'Gender *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedGender,
                          hint: const Text(
                            'Select gender',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 16,
                            ),
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF9CA3AF),
                          ),
                          items: ['Male', 'Female', 'Other'].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGender = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Medical Information Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Medical Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Valve Type Dropdown
                    const Text(
                      'Valve Type *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedValveType,
                          hint: const Text(
                            'Select valve type',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 16,
                            ),
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF9CA3AF),
                          ),
                          items:
                              [
                                'Mechanical Valve',
                                'Bioprosthetic Valve',
                                'Tissue Valve',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValveType = newValue;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Valve Position Dropdown
                    const Text(
                      'Valve Position *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedValvePosition,
                          hint: const Text(
                            'Select valve position',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 16,
                            ),
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF9CA3AF),
                          ),
                          items: ['Aortic', 'Mitral', 'Tricuspid', 'Pulmonary']
                              .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              })
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValvePosition = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Warfarin Information Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Warfarin Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Target INR Range
                    const Text(
                      'Target INR Range *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        // Min INR
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _minINRController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Min (e.g., 2.0)',
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
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Max INR
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _maxINRController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Max (e.g., 3.0)',
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
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Prescribed Warfarin Dose
                    const Text(
                      'Prescribed Warfarin Dose (mg) *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _warfarinDoseController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'e.g., 5.0',
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
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Warfarin Dose Time
                    const Text(
                      'Warfarin Dose Time *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),

                    const SizedBox(height: 8),

                    InkWell(
                      onTap: () => _selectTime(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            Text(
                              _formatTime(_selectedDoseTime),
                              style: TextStyle(
                                color: _selectedDoseTime == null
                                    ? const Color(0xFF9CA3AF)
                                    : const Color(0xFF1A3B5D),
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.access_time,
                              color: Color(0xFF9CA3AF),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/onboard1');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B7EF8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
