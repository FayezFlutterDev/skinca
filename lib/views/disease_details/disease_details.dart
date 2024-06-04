import 'package:flutter/material.dart';
import 'package:skinca/core/constants/app_defaults.dart';
import 'package:skinca/core/constants/icon_borken.dart';
import '../../core/constants/app_colors.dart';

class DiseaseDetailsPage extends StatelessWidget {
  const DiseaseDetailsPage({super.key});
  static const String routeName = '/disease-details';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight + 200,
              ),
              Container(
                height: SizeConfig.screenHeight * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(getProportionateScreenHeight(24)),
                    bottomRight:
                        Radius.circular(getProportionateScreenHeight(24)),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                    size: 36,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: 50,
                left: 60,
                right: 60,
                child: Center(
                  child: Text(
                    "Skin Cancer",
                    style: textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 10,
                child: IconButton(
                  icon: const Icon(
                    IconBroken.Bookmark,
                    size: 36,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: SizeConfig.screenHeight * 0.15,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: Image.asset("assets/images/new.png")),
                        Text(
                          "Description",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Skin cancer is the uncontrolled growth of abnormal skin cells. It occurs when unrepaired DNA damage to skin cells (most often caused by ultraviolet radiation from sunshine or tanning beds) triggers mutations, or genetic defects, that lead the skin cells to multiply rapidly and form malignant tumors.",
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Symptoms",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Skin cancer symptoms can include many different shapes, sizes, and colors of skin lesions, or moles. The most common sign of skin cancer is a change on the skin, such as a growth or a sore that won't heal.",
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Prevention",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "To reduce your risk of skin cancer, protect your skin from the sun and avoid indoor tanning. Here are some tips to help protect your skin from the sun's harmful UV radiation and reduce your risk of skin cancer.",
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
