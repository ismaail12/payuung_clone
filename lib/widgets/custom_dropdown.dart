import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String errorMessage;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final bool isRequired;

  const CustomDropdown({super.key, 
    required this.label,
    required this.errorMessage,
    required this.items,
    this.value,
    this.onChanged,
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
          DropdownButtonFormField<String>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
            validator: (value) {
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
