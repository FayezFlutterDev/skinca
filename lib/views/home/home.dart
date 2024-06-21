import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/constants/constants.dart';
import 'package:skinca/core/models/banner_model.dart';
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
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeInitial) {
                      context.read<HomeCubit>().getBanners();
                    }
                    if (state is BannersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BannersSuccess) {
                      return SizedBox(
                        height: SizeConfig.screenHeight * 0.244,
                        width: double.infinity,
                        child: CarouselSliderCard(
                          banners: state.banners,
                          textTheme: textTheme,
                        ),
                      );
                    } else if (state is BannersFailure) {
                      return Center(child: Text(state.error));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: const DiseaseItem(),
                        onTap: () {
                          Navigator.pushNamed(
                              context, DiseaseDetailsPage.routeName);
                        },
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
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right: getProportionateScreenWidth(12)),
                          child: GestureDetector(
                            child: const DoctorCard(),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, DoctorDetailsPage.routeName);
                            },
                          ),
                        );
                      })),
                ),
              ]),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage("assets/images/doctor.png"),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            const Text(
              "Dr. Alina James",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Expanded(
              child: Text(
                "B.Sc, MBBS, DDVL,\n MD- Dermitologist",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.star,
                  color: Color(0xffEFCE4A),
                ),
                Text(
                  '4.2',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DiseaseItem extends StatelessWidget {
  const DiseaseItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getProportionateScreenWidth(8)),
      child: Card(
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
          child: Image.asset('assets/images/new.png'),
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
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(16),
                left: getProportionateScreenWidth(20),
              ),
              child: Image.memory(
                const Base64Decoder().convert(banner.imageUrl),
                fit: BoxFit.cover,
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
    return Container(
      width: getProportionateScreenWidth(118),
      margin: EdgeInsets.only(right: getProportionateScreenWidth(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(10)),
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
