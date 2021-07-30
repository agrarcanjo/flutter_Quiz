import 'package:dev_quiz/core/app_colors.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class NextButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color fontColor;
  final String label;
  final VoidCallback onTap;

  NextButtonWidget({
    required this.backgroundColor,
    required this.borderColor,
    required this.fontColor,
    required this.label,
    required this.onTap,
  });

  // criar construtores com parametros padrões

  NextButtonWidget.green({required this.label, required this.onTap})
      : this.backgroundColor = AppColors.darkGreen,
        this.borderColor = AppColors.green,
        this.fontColor = AppColors.white;

  NextButtonWidget.purple({required this.label, required this.onTap})
      : this.backgroundColor = AppColors.purple,
        this.borderColor = AppColors.border,
        this.fontColor = AppColors.white;

  NextButtonWidget.transparent({required this.label, required this.onTap})
      : this.backgroundColor = Colors.transparent,
        this.borderColor = Colors.transparent,
        this.fontColor = AppColors.grey;

  NextButtonWidget.white({required this.label, required this.onTap})
      : this.backgroundColor = AppColors.white,
        this.borderColor = AppColors.border,
        this.fontColor = AppColors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: borderColor),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
