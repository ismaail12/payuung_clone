import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const CustomButton({super.key, 
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isPrimary
          ? MediaQuery.of(context).size.width - 38
          : (MediaQuery.of(context).size.width - 38) / 2,
      child: ElevatedButton(
        onPressed: onPressed,
        style: isPrimary
            ? null
            : ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
        child: Text(text),
      ),
    );
  }
}


