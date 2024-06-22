import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/constants/constants.dart';
import 'package:skinca/core/models/banner_model.dart';
import 'package:skinca/core/models/disease_model.dart';
import 'package:skinca/core/models/doctor_model.dart';
import 'package:skinca/views/auth/auth_cubit/user_cubit.dart';
import 'package:skinca/views/disease_details/disease_details.dart';
import 'package:skinca/views/doctor_details/doctor_details.dart';
import 'package:skinca/views/home/home_cubit/home_cubit.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';
import 'package:skinca/views/profile/screens/profile_info.dart';

import 'components/color_button.dart';
import 'components/theme_button.dart';
import 'theme_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getProportionateScreenHeight(65)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16),
            vertical: getProportionateScreenHeight(8),
          ),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            leadingWidth: getProportionateScreenWidth(300),
            leading: Row(
              children: [
                CircleAvatar(
                  radius: getProportionateScreenWidth(16),
                  backgroundImage: context.read<UserCubit>().user?.picture !=
                          null
                      ? Image.memory(
                          const Base64Decoder().convert(
                              context.read<UserCubit>().user!.picture!),
                          fit: BoxFit.cover,
                        ).image
                      : context.read<UserCubit>().registerResponse?.picture !=
                              null
                          ? Image.memory(
                              const Base64Decoder().convert(context
                                  .read<UserCubit>()
                                  .registerResponse!
                                  .picture!),
                              fit: BoxFit.cover,
                            ).image
                          : const AssetImage("assets/images/avatar.png")
                              as ImageProvider,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProfileInfoPage.routeName);
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(5),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Welcome, ${context.read<UserCubit>().user?.name ?? context.read<UserCubit>().registerResponse?.name}",
                        style: textTheme.titleMedium),
                    Text(
                      "How are you today?",
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return ThemeButton(
                    changeThemeMode: (bool useLightMode) {
                      context.read<ThemeCubit>().changeThemeMode(useLightMode);
                    },
                  );
                },
              ),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return ColorButton(
                    changeColor: (int value) {
                      context.read<ThemeCubit>().changeColor(value);
                    },
                    colorSelected: state.colorSelected,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeInitial) {
            context.read<HomeCubit>().getBanners();
            context.read<HomeCubit>().getDiseases();
            context.read<HomeCubit>().getDoctors();
          }
          if (state is BannersFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is DiseasesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is DoctorsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is BannersLoading ||
                      state is DiseasesLoading ||
                      state is DoctorsLoading)
                    const Center(child: CircularProgressIndicator())
                  else ...[
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.244,
                      width: double.infinity,
                      child: CarouselSliderCard(
                        banners: context.read<HomeCubit>().banners,
                        textTheme: textTheme,
                      ),
                    ),
                    Row(
                      children: [
                        HeaderText(
                          text: "Diseases & Conditions",
                          textTheme: textTheme,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Show All",
                            style: textTheme.bodyMedium!.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(100),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: context.read<HomeCubit>().diseases.length,
                        itemBuilder: (context, index) {
                          final disease =
                              context.read<HomeCubit>().diseases[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, DiseaseDetailsPage.routeName,
                                  arguments: disease);
                            },
                            child: DiseaseItem(
                              disease: disease,
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        HeaderText(
                          text: "Doctors nearby you",
                          textTheme: textTheme,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "See All",
                            style: textTheme.bodyMedium!.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.2334,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: context.read<HomeCubit>().doctors.length,
                        itemBuilder: (context, index) {
                          final doctor =
                              context.read<HomeCubit>().doctors[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                right: getProportionateScreenWidth(12)),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, DoctorDetailsPage.routeName,
                                    arguments: doctor);
                              },
                              child: DoctorCard(doctor: doctor),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(130),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(12)),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              CircleAvatar(
                radius: 28,
                backgroundImage: doctor.profilePicture.isNotEmpty
                    ? Image.memory(
                        const Base64Decoder().convert(doctor.profilePicture),
                        fit: BoxFit.cover,
                      ).image
                    : const AssetImage("assets/images/avatar.png"),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                "${doctor.firstName} ${doctor.lastName}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Expanded(
                child: Text(
                  doctor.specialization,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xffEFCE4A),
                  ),
                  Text(
                    '${doctor.rating}',
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DiseaseItem extends StatelessWidget {
  const DiseaseItem({
    super.key,
    required this.disease,
  });

  final DiseaseModel disease;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getProportionateScreenWidth(8)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(14)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(14)),
          child: Image.memory(
            const Base64Decoder().convert(disease.image),
            fit: BoxFit.cover,
            width: getProportionateScreenWidth(100),
          ),
        ),
      ),
    );
  }
}

class CarouselSliderCard extends StatelessWidget {
  const CarouselSliderCard({
    super.key,
    required this.textTheme,
    required this.banners,
  });

  final TextTheme textTheme;
  final List<BannerModel> banners;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
      ),
      items: banners.map((banner) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.memory(
                const Base64Decoder().convert(banner.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class PopularArticleCard extends StatelessWidget {
  const PopularArticleCard({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = getProportionateScreenWidth(118);
    final double margin = getProportionateScreenWidth(10);
    final double borderRadius = getProportionateScreenWidth(10);

    return Container(
      width: cardWidth.isNaN || cardWidth.isInfinite ? 0 : cardWidth,
      margin: EdgeInsets.only(
          right: margin.isNaN || margin.isInfinite ? 0 : margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            borderRadius.isNaN || borderRadius.isInfinite ? 0 : borderRadius),
        color: AppColors.primary,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter'),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.text,
    required this.textTheme,
  });
  final String text;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ));
  }
}
