import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});
  static const String routeName = '/contact-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Don\'t hesitate to contact us whether you have a suggestion on our improvement, a complain to discuss or an issue to solve.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.call, size: 40, color: Colors.black),
                      onPressed: () {
                        // Handle call button press
                      },
                    ),
                    const Text(
                      'Call us',
                      style: TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                    const Text(
                      'Our team is on the line\nMon-Fri • 9-17',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.email,
                          size: 40, color: Colors.black),
                      onPressed: () {
                        // Handle email button press
                      },
                    ),
                    const Text(
                      'Email us',
                      style: TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                    const Text(
                      'Our team is online\nMon-Fri • 9-17',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact us in Social Media',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SocialMediaCard(
              icon: Icons.camera_alt,
              platform: 'Instagram',
              followers: '4,6K Followers',
              posts: '118 Posts',
            ),
            const SocialMediaCard(
              icon: Icons.send,
              platform: 'Telegram',
              followers: '1,3K Followers',
              posts: '85 Posts',
            ),
            const SocialMediaCard(
              icon: Icons.facebook,
              platform: 'Facebook',
              followers: '3,8K Followers',
              posts: '136 Posts',
            ),
            const SocialMediaCard(
              icon: Icons.message,
              platform: 'WhatsUp',
              availability: 'Available Mon-Fri • 9-17',
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaCard extends StatelessWidget {
  final IconData icon;
  final String platform;
  final String? followers;
  final String? posts;
  final String? availability;

  const SocialMediaCard({
    super.key,
    required this.icon,
    required this.platform,
    this.followers,
    this.posts,
    this.availability,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.withOpacity(0.1),
          child: Icon(icon, color: Colors.teal),
        ),
        title: Text(platform),
        subtitle: availability != null
            ? Text(availability!)
            : Text('$followers • $posts'),
        trailing: const Icon(Icons.share, color: Colors.teal),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }
}
