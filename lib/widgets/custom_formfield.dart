import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String errorMessage;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool isRequired;

  const CustomFormField({super.key, 
    required this.label,
    required this.errorMessage,
    this.controller,
    this.validator,
    this.textInputType,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isRequired)
                const Text(
                  '* ',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Text(label.toUpperCase()),
            ],
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: textInputType,
            validator: validator ??
                (value) {
                  if (isRequired && (value == null || value.isEmpty)) {
                    return errorMessage;
                  }
                  return null;
                },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


