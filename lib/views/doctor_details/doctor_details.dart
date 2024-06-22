import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skinca/core/constants/constants.dart';
import 'package:skinca/core/constants/icon_borken.dart';
import 'package:skinca/core/models/doctor_model.dart';

class DoctorDetailsPage extends StatelessWidget {
  static const String routeName = "/doctor_details";

  const DoctorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor =
        ModalRoute.of(context)!.settings.arguments as DoctorModel;
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.46,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
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
                    top: 120,
                    left: 10,
                    right: 10,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: SizeConfig.screenHeight * 0.3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                getProportionateScreenHeight(20)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Prime",
                                      style: textTheme.bodyLarge!.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 24,
                                        ),
                                        SizedBox(
                                            width: getProportionateScreenHeight(
                                                4)),
                                        Text(
                                          doctor.rating.toString(),
                                          style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                Text(
                                    "Dr.${doctor.firstName} ${doctor.lastName}",
                                    style: textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                  doctor.specialization,
                                  style: textTheme.bodySmall!.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                Row(
                                  children: [
                                    Text(
                                      "${doctor.experience}",
                                      style: textTheme.bodyLarge,
                                    ),
                                    Text(
                                      " Yrs of Experience",
                                      style: textTheme.bodySmall!.copyWith(
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "89%", // Replace with actual votes percentage if available
                                      style: textTheme.bodyLarge,
                                    ),
                                    Text(
                                      "(4432 votes)", // Replace with actual votes count if available
                                      style: textTheme.bodySmall!.copyWith(
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.09,
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      4)),
                                      itemCount: doctor.services.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Chip(
                                          label: Text(doctor.services[index]),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -46,
                          child: CircleAvatar(
                            radius: 44,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: doctor.profilePicture.isNotEmpty
                                  ? Image.memory(
                                      const Base64Decoder()
                                          .convert(doctor.profilePicture),
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    )
                                  : Image.asset(
                                      'assets/images/avatar.png',
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(10)),
              child: Container(
                height: SizeConfig.screenHeight * 0.5,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenHeight(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(20)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "In Clinic Fees : ",
                            style: textTheme.bodySmall!.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          Text("\$${doctor.clinicFees}",
                              style: textTheme.bodySmall),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      const Divider(thickness: 0.9),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doctor.isWorking ? "OPEN TODAY" : "CLOSED TODAY",
                            style: textTheme.labelSmall!.copyWith(
                              color:
                                  doctor.isWorking ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            " - ",
                            style: textTheme.labelSmall,
                          ),
                          Text(
                            "All TIMINGS",
                            style: textTheme.labelSmall!.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      const Divider(thickness: 0.9),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: AppColors.primary),
                          Expanded(
                            child: Text(
                              doctor.address,
                              style: textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(15)),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.26,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(doctor.latitude, doctor.longitude),
                              zoom: 14.4746,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId(doctor.userId),
                                position:
                                    LatLng(doctor.latitude, doctor.longitude),
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
