import 'package:flutter/material.dart';
import 'package:skinca/core/constants/constants.dart';

class VerifiedDialog extends StatelessWidget {
  const VerifiedDialog({
    super.key,
    required this.text,
    required this.onPressed,
    required this.text2,
    required this.text3,
    this.isVerified = true,
  });
  final String text;
  final String text2;
  final String text3;

  final Function() onPressed;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppDefaults.borderRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDefaults.padding * 3,
          horizontal: AppDefaults.padding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: isVerified
                    ? Image.network(AppImages.verified)
                    : Image.asset("assets/images/error.png"),
              ),
            ),
            const SizedBox(height: AppDefaults.padding),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDefaults.padding),
            Text(
              text2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDefaults.padding),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppDefaults.borderRadius,
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  text3,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
