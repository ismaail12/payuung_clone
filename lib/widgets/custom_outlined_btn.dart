import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const CustomOutlinedButton({super.key, 
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
      child: OutlinedButton(
        onPressed: onPressed,
        style: isPrimary
            ? null
            : ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
              ),
        child: Text(text),
      ),
    );
  }
}
