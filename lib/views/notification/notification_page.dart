import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = "/notification";
  const NotificationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isNotificationTab = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          actions: [
            TextButton(
              onPressed: () {
                // Clear all notifications action
              },
              child:
                  const Text('Clear all', style: TextStyle(color: Colors.teal)),
            ),
          ],
        ),
        body: Column(
          children: [
            NotificationTabs(
              isNotificationTab: isNotificationTab,
              textTheme: textTheme,
              onTabSelected: (isNotification) {
                setState(() {
                  isNotificationTab = isNotification;
                });
              },
            ),
            Expanded(
              child: NotificationList(
                  isNotificationTab: isNotificationTab, textTheme: textTheme),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "message",
          onPressed: () {
            // Add new notification action
          },
          child: const Icon(Icons.chat_sharp),
        ));
  }
}

class NotificationTabs extends StatelessWidget {
  final bool isNotificationTab;
  final Function(bool) onTabSelected;
  final TextTheme textTheme;

  const NotificationTabs({
    super.key,
    required this.isNotificationTab,
    required this.onTabSelected,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NotificationTab(
          label: 'All notification',
          count: '16+',
          isActive: isNotificationTab,
          onTap: () => onTabSelected(true),
          textTheme: textTheme,
        ),
        NotificationTab(
          label: 'All message',
          count: '2',
          isActive: !isNotificationTab,
          onTap: () => onTabSelected(false),
          textTheme: textTheme,
        ),
      ],
    );
  }
}

class NotificationTab extends StatelessWidget {
  final String label;
  final String count;
  final bool isActive;
  final VoidCallback onTap;
  final TextTheme textTheme;

  const NotificationTab({
    super.key,
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color:
              isActive ? Theme.of(context).highlightColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Text(label, style: textTheme.bodyMedium!),
            const SizedBox(width: 8.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                count,
                style: textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  final bool isNotificationTab;
  final List<Map<String, String>> notifications = [
    {
      'title': 'Dr. Marcus Horizon',
      'message': 'sent message to you',
      'time': '10:24',
      'image': 'assets/images/doctor.png'
    },
    {
      'title': 'Dr. Alysa Hana',
      'message': 'sent message to you',
      'time': '09:04',
      'image': 'assets/images/doctor.png'
    },
    {
      'title': 'Your result is ready',
      'message': 'show your result now',
      'time': '11:04',
      'image': 'assets/images/chatbot.png'
    },
    {
      'title': 'Chat bot',
      'message': 'new feature',
      'time': '08:25',
      'image': 'assets/images/chatbot.png'
    },
    {
      'title': 'Chat bot',
      'message': 'send your Diagnosis',
      'time': '05:04',
      'image': 'assets/images/chatbot.png'
    },
    {
      'title': 'Dr. Alysa Hana',
      'message': 'sent message to you',
      'time': '09:16',
      'image': 'assets/images/doctor.png'
    },
    {
      'title': 'Chat bot',
      'message': 'new feature',
      'time': '01:09',
      'image': 'assets/images/chatbot.png'
    },
  ];

  final List<Map<String, String>> messages = [
    {
      'title': 'Dr. Marcus Horizon',
      'message': 'I don\'t have any fever, but headache...',
      'time': '10:24',
      'image': 'assets/images/doctor.png'
    },
    {
      'title': 'Dr. Alysa Hana',
      'message': 'Hello, How can i help you?',
      'time': '09:04',
      'image': 'assets/images/doctor.png'
    },
  ];

  NotificationList(
      {super.key, required this.isNotificationTab, required this.textTheme});
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items =
        isNotificationTab ? notifications : messages;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(item['image']!),
          ),
          title: Text(
            item['title']!,
            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            item['message']!,
            style: textTheme.bodySmall,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item['time']!,
                style: textTheme.bodySmall,
              ),
              if (isNotificationTab && index == 2)
                const Icon(Icons.check, size: 16),
              if (!isNotificationTab)
                const Icon(Icons.check_circle_outline, size: 16),
            ],
          ),
        );
      },
    );
  }
}
