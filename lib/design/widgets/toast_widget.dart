import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_test/core/constants/app_colors.dart';
import 'package:local_test/core/constants/app_text_styles.dart';

void showToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM}) {
  return FToast().showToast(
    gravity: gravity,
    toastDuration: const Duration(seconds: 3),
    child: GestureDetector(
      onTap: () => FToast().removeQueuedCustomToasts(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.redToast,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.s16White,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
