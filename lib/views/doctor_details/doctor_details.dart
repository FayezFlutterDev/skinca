import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skinca/core/constants/constants.dart';
import 'package:skinca/core/constants/icon_borken.dart';

class DoctorDetailsPage extends StatelessWidget {
  static const String routeName = "/doctor_details";

  const DoctorDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
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
                                          "4.5",
                                          style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                Text("Dr. Abdullah Fayez",
                                    style: textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                  "B.Sc, MBBS, DDVL, MD- Dermitologist",
                                  style: textTheme.bodySmall!.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                Row(
                                  children: [
                                    Text(
                                      "16",
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
                                      "89%",
                                      style: textTheme.bodyLarge,
                                    ),
                                    Text(
                                      "(4432 votes)",
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
                                      itemCount: 4,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Image.asset(
                                            "assets/images/mask.png");
                                      }),
                                )
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
                                child: Image.asset(
                              "assets/images/user.jpg",
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            )),
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
                          Text("\$10", style: textTheme.bodySmall)
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      const Divider(
                        thickness: 0.9,
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("CLOSED TODAY",
                              style: textTheme.labelSmall!.copyWith(
                                color: Colors.red,
                              )),
                          Text(" - 10:00 AM - 06:00 PM",
                              style: textTheme.labelSmall),
                          Text("All TIMINGS",
                              style: textTheme.labelSmall!.copyWith(
                                color: AppColors.primary,
                              )),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      const Divider(
                        thickness: 0.9,
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: AppColors.primary),
                          Expanded(
                            child: Text(
                                " 123, 4th Floor, 5th Main, 6th Cross, 7th Sector, 8th Phase, 9th Block, 10th City, 11th State, 12th Country, 13th Pincode",
                                style: textTheme.labelSmall),
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
                            initialCameraPosition: const CameraPosition(
                              target: LatLng(29.076361, 31.097000),
                              zoom: 14.4746,
                            ),
                            markers: {
                              const Marker(
                                markerId: MarkerId("1"),
                                position: LatLng(29.076361, 31.097000),
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
