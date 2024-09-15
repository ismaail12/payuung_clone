import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final String errorMessage;
  final TextEditingController? controller;
  final bool isRequired;

  const CustomDatePicker({super.key, 
    required this.label,
    required this.errorMessage,
    this.controller,
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
            readOnly: true,
            onTap: () async {
              FocusScope.of(context).unfocus();
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (controller != null && picked != null) {
                controller!.text = DateFormat('dd MMMM yyyy').format(picked);
              }
            },
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return errorMessage;
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.calendar_today),
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
