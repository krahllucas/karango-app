import 'package:flutter/material.dart';
import 'package:karango_app/app/core/colors.dart';

class HighlightCard extends StatelessWidget {
    final String value;
    final IconData icon;
    final String label;

    const HighlightCard({
        Key? key,
        required this.value,
        required this.icon,
        required this.label,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return FractionallySizedBox(
            widthFactor: 1.0,
            child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(26),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                        ),
                    ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                            icon,
                            size: 32,
                            color: AppColors.appColor,
                        ),
                        const SizedBox(height: 12),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                ),
                                textAlign: TextAlign.center,
                            ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            label,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}