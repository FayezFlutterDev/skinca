import 'package:flutter/material.dart';
import 'package:skinca/core/constants/constants.dart';
import 'package:skinca/core/constants/icon_borken.dart';
import 'package:skinca/core/utils/keyboard.dart';
import 'package:skinca/views/chat/chat_page.dart';
import 'package:skinca/views/entrypoint/entrypoint_ui.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = "/search_page";
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isFilter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      IconBroken.Arrow___Left_2,
                      size: 36,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, EntryPointUI.routeName);
                    },
                  ),
                  Expanded(
                    child: _SearchPageHeader(
                      isFilter: isFilter,
                      onFilterToggle: () {
                        setState(() {
                          isFilter = !isFilter;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (isFilter) const SearchFilter(),
              const DoctorCard(
                name: "Dr. Marcus Horizon",
                specialty: "Cardiologist",
                startTime: "10:00 AM",
                endTime: "5:00 PM",
                imageUrl: "https://via.placeholder.com/150",
              ),
              const DoctorCard(
                name: "Dr. Alysa Hana",
                specialty: "Psychiatrist",
                startTime: "9:00 AM",
                endTime: "3:00 PM",
                imageUrl: "https://via.placeholder.com/150",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  String _selectedSegment = 'All';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
        child: SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'All', label: Text('All')),
            ButtonSegment(value: 'Disease', label: Text('Disease')),
            ButtonSegment(value: 'Doctor', label: Text('Doctor')),
          ],
          selected: <String>{_selectedSegment},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() {
              _selectedSegment = newSelection.first;
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.teal; // Color for the selected segment
              }
              return Colors.white; // Color for the unselected segments
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white; // Text color for the selected segment
              }
              return Colors.black; // Text color for the unselected segments
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchPageHeader extends StatelessWidget {
  final bool isFilter;
  final VoidCallback onFilterToggle;

  const _SearchPageHeader({
    required this.isFilter,
    required this.onFilterToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                /// Search Box
                Form(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppDefaults.radius)),
                        borderSide:
                            BorderSide(color: Color(0xFFE5E7EB), width: 1),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(AppDefaults.padding),
                        child: Icon(IconBroken.Search),
                      ),
                      prefixIconConstraints: BoxConstraints(),
                      contentPadding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    textInputAction: TextInputAction.search,
                    //autofocus: true,
                    onChanged: (String? value) {},
                    onFieldSubmitted: (v) {
                      KeyboardUtil.hideKeyboard(context);
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  height: 64,
                  child: SizedBox(
                    width: 64,
                    child: ElevatedButton(
                      onPressed: onFilterToggle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          IconBroken.Filter,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String startTime;
  final String endTime;
  final String imageUrl;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.startTime,
    required this.endTime,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.jpg"),
                    radius: 30.0,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        specialty,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16.0, color: Colors.grey[600]),
                  const SizedBox(width: 4.0),
                  Text(
                    startTime,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16.0),
                  Icon(Icons.access_time, size: 16.0, color: Colors.grey[600]),
                  const SizedBox(width: 4.0),
                  Text(
                    endTime,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ChatPage.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.teal[50],
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Chat'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle see details button press
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('See details'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}