import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final bool isActive;
  final int step;

  const StepIndicator({super.key, 
    required this.isActive,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.3),
          ),
          child: Center(
            child: Text(
              '$step',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          width: 80,
          child: Text(
            step == 1
                ? "Biodata Diri"
                : step == 2
                    ? "Alamat Pribadi"
                    : "Informasi Perusahaan",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }
}

