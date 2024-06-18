// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinca/core/constants/app_defaults.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> items = [
    {
      'text': 'Language',
      'icon': Icons.language,
      'onTap': () => print('Language tapped')
    },
    {
      'text': 'Change Password',
      'icon': Icons.lock,
      'onTap': () => print('Change Password tapped')
    },
    {'text': 'Help', 'icon': Icons.help, 'onTap': () => print('Help tapped')},
    {
      'text': 'Contact Us',
      'icon': Icons.contact_phone,
      'onTap': () => print('Contact Us tapped')
    },
  ];

  bool isExpanded = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      backgroundColor: const Color(0xFF009788),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? 60 : 200,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(
                color: Color(0xFF009788),
              ),
              child: !isExpanded
                  ? FittedBox(
                      child: Column(
                        children: [
                          Stack(children: [
                            CircleAvatar(
                              radius: getProportionateScreenWidth(45),
                              backgroundImage:
                                  const AssetImage("assets/images/user.jpg"),
                            ),
                            Positioned(
                                bottom: 10,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    radius: 10,
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 15,
                                    ),
                                  ),
                                ))
                          ]),
                          SizedBox(height: getProportionateScreenHeight(5)),
                          Text(
                            'Abdullah Fayez',
                            style: textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            SizedBox(
                              width: getProportionateScreenHeight(20),
                            ),
                            CircleAvatar(
                              radius: getProportionateScreenHeight(16),
                              backgroundImage: const AssetImage(
                                "assets/images/user.jpg",
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenHeight(10),
                            ),
                            Text(
                              'Abdullah Fayez',
                              style: textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                      ],
                    ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ExpansionTileItem(
                          textTheme: textTheme,
                          text: 'Profile Info',
                          icon: Icons.person,
                          nextPage: '/profile-info',
                        ),
                        ExpansionTileItem(
                          textTheme: textTheme,
                          text: 'Medical Record',
                          icon: Icons.medical_services,
                          nextPage: '/edit_information',
                        ),
                        ExpansionTileItem(
                          textTheme: textTheme,
                          text: 'Alarm Medication',
                          icon: Icons.alarm,
                          nextPage: '/edit_information',
                        ),
                        ExpansionTile(
                          onExpansionChanged: (v) {
                            setState(() {
                              isExpanded = v;
                            });
                          },
                          title: Text(
                            'Settings',
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                          childrenPadding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          leading: Icon(
                            Icons.settings,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          trailing: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 600),
                            child: isExpanded
                                ? Icon(
                                    Icons.arrow_back_ios,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  )
                                : Icon(
                                    Icons.arrow_forward_ios,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                          ),
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              //onTap: () => null,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children:
                                      List.generate(items.length, (index) {
                                    return ListTile(
                                      leading: Icon(
                                        items[index]['icon'],
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      title: Text(
                                        items[index]['text'],
                                        style: const TextStyle(),
                                      ),
                                      onTap: items[index]['onTap'],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ExpansionTileItem(
                          textTheme: textTheme,
                          text: 'Contact Us',
                          icon: Icons.contact_phone,
                          nextPage: '/edit_information',
                        ),
                        ExpansionTileItem(
                          textTheme: textTheme,
                          text: 'Doctors',
                          icon: Icons.people,
                          nextPage: '/edit_information',
                        ),
                        ExpansionTileItem(
                          textTheme: textTheme,
                          text: 'Bookmarks',
                          icon: Icons.bookmark,
                          nextPage: '/edit_information',
                        ),
                        ExpansionTileItem(
                          textTheme: textTheme,
                          text: 'Log Out',
                          icon: Icons.logout,
                          nextPage: '/edit_information',
                        ),
                      ],
                    ),
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

class ExpansionTileItem extends StatelessWidget {
  const ExpansionTileItem({
    super.key,
    required this.textTheme,
    required this.text,
    required this.icon,
    required this.nextPage,
  });

  final TextTheme textTheme;
  final String text;
  final IconData icon;
  final String nextPage;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      enabled: false,
      title: Text(
        text,
        style: textTheme.titleMedium!,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
        textAlign: TextAlign.center,
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(nextPage);
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
