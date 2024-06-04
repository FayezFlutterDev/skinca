import 'package:flutter/material.dart';
import 'package:skinca/core/constants/app_defaults.dart';
import 'package:skinca/core/constants/icon_borken.dart';
class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
 const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   List<Map<String, dynamic>> items = [
    {'text': 'Language', 'icon': Icons.language, 'onTap': () => print('Language tapped')},
    {'text': 'Change Password', 'icon': Icons.lock, 'onTap': () => print('Change Password tapped')},
    {'text': 'Help', 'icon': Icons.help, 'onTap': () => print('Help tapped')},
    {'text': 'Contact Us', 'icon': Icons.contact_phone, 'onTap': () => print('Contact Us tapped')},
  ];

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: SizeConfig.screenHeight * 0.3,
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              color: Colors.teal,
              child: const Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        "assets/images/user.jpg"), // Replace with the user's image URL
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Abdullah Fayez',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    children: [
                      ProfileItem(
                        icon: IconBroken.Edit,
                        text: "Edit Information",
                        onTap: () {},
                      ),
                      const Divider(),
                      ProfileItem(
                        icon: IconBroken.Calendar,
                        text: "My Medical Record",
                        onTap: () {},
                      ),
                      const Divider(),
                      Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                onExpansionChanged: (v) {
                  setState(() {
                    isExpanded = v;
                  });
                },
                title: Text(
                  'الإعدادات',
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                childrenPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                leading: Icon(Icons.settings,color:isExpanded? Colors.lightBlueAccent:null,),
                trailing: AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  child: isExpanded ? Icon(Icons.keyboard_arrow_down,color: Colors.lightBlueAccent,) : Icon(Icons.keyboard_arrow_left,color: Colors.grey,),
                ),
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => null,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: List.generate(items.length, (index) {
                          return ListTile(
                            leading: Icon(items[index]['icon'],color: Colors.lightBlueAccent,),
                            title: Text(items[index]['text'],style: TextStyle(color: Colors.lightBlueAccent,),),
                            onTap: items[index]['onTap'],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                    
                      const Divider(),
                      ProfileItem(
                        icon: IconBroken.Call,
                        text: "Contact",
                        onTap: () {},
                      ),
                      const Divider(),
                      ProfileItem(
                        icon: IconBroken.Logout,
                        text: "Log out",
                        isLogout: true,
                        onTap: () {},
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

// ignore: must_be_immutable
class ProfileItem extends StatelessWidget {
  ProfileItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.isLogout = false,
  });
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  bool isLogout = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          // foregroundColor: Theme.of(context).colorScheme.onSurface,
          child: Icon(icon,
              color: isLogout ? Colors.red : const Color(0xFF00A896))),
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
