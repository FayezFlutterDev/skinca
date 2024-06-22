import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skinca/core/constants/app_defaults.dart';
import 'package:skinca/core/constants/icon_borken.dart';
import 'package:skinca/core/models/disease_model.dart';
import '../../core/constants/app_colors.dart';

class DiseaseDetailsPage extends StatelessWidget {
  const DiseaseDetailsPage({super.key});
  static const String routeName = '/disease-details';

  @override
  Widget build(BuildContext context) {
    final DiseaseModel disease =
        ModalRoute.of(context)!.settings.arguments as DiseaseModel;
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
                    disease.title,
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
                            child: disease.image.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.memory(
                                      const Base64Decoder()
                                          .convert(disease.image),
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                                  )
                                : Image.asset("assets/images/new.png")),
                        const SizedBox(height: 16),
                        Text(
                          "Specialty",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          disease.specialty,
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
                        ...disease.symptoms.map((symptom) => Text(
                          symptom,
                          style: textTheme.bodyMedium,
                        )),
                        const SizedBox(height: 16),
                        Text(
                          "Types",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...disease.types.map((type) => Text(
                          type,
                          style: textTheme.bodyMedium,
                        )),
                        const SizedBox(height: 16),
                        Text(
                          "Causes",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...disease.causes.map((cause) => Text(
                          cause,
                          style: textTheme.bodyMedium,
                        )),
                        const SizedBox(height: 16),
                        Text(
                          "Diagnostic Methods",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...disease.diagnosticMethods.map((method) => Text(
                          method,
                          style: textTheme.bodyMedium,
                        )),
                        const SizedBox(height: 16),
                        Text(
                          "Prevention",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...disease.prevention.map((prevention) => Text(
                          prevention,
                          style: textTheme.bodyMedium,
                        )),
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
