// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/constants/constants.dart';
import 'package:skinca/core/constants/icon_borken.dart';
import 'package:skinca/core/models/disease_model.dart';
import 'package:skinca/core/models/doctor_model.dart';
import 'package:skinca/core/utils/keyboard.dart';
import 'package:skinca/views/disease_details/disease_details.dart';
import 'package:skinca/views/doctor_details/doctor_details.dart';
import 'package:skinca/views/entrypoint/entrypoint_ui.dart';
import 'package:skinca/views/home/home_cubit/home_cubit.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart'; // Import your HomeCubit

class SearchPage extends StatefulWidget {
  static const String routeName = "/search_page";
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isFilter = false;
  String query = "";
  String selectedSegment = 'All';

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
                      onSearch: (value) {
                        setState(() {
                          query = value;
                        });
                        context.read<HomeCubit>().search(value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (isFilter)
                SearchFilter(
                  onSegmentSelected: (String segment) {
                    setState(() {
                      selectedSegment = segment;
                    });
                  },
                ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchSuccess) {
                    final filteredDoctors =
                        selectedSegment == 'All' || selectedSegment == 'Doctor'
                            ? state.doctors
                            : [];
                    final filteredDiseases =
                        selectedSegment == 'All' || selectedSegment == 'Disease'
                            ? state.diseases
                            : [];

                    return Column(
                      children: [
                        for (var doctor in filteredDoctors)
                          DoctorCard(doctor: doctor),
                        for (var disease in filteredDiseases)
                          SearchDiseaseCard(disease: disease),
                      ],
                    );
                  } else if (state is SearchFailure) {
                    return Center(child: Text(state.error));
                  } else {
                    return const Center(child: Text('No results found.'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchDiseaseCard extends StatelessWidget {
  const SearchDiseaseCard({
    super.key,
    required this.disease,
  });

  final DiseaseModel disease;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, DiseaseDetailsPage.routeName,
              arguments: disease);
        },
        child: Card(
          child: ListTile(
            title: Text(
              disease.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              disease.specialty,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(
              backgroundImage: disease.image == null
                  ? const AssetImage('assets/images/new2.png')
                  : Image.memory(const Base64Decoder().convert(
                      disease.image.split(',').last,
                    )).image,
              radius: 30.0,
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
  final Function(String) onSearch;

  const _SearchPageHeader({
    required this.isFilter,
    required this.onFilterToggle,
    required this.onSearch,
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
                    onChanged: onSearch,
                    onFieldSubmitted: (v) {
                      KeyboardUtil.hideKeyboard(context);
                      onSearch(v);
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

class SearchFilter extends StatefulWidget {
  final Function(String) onSegmentSelected;

  const SearchFilter({super.key, required this.onSegmentSelected});

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
            widget.onSegmentSelected(_selectedSegment);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.teal;
              }
              return Colors.white;
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              return Colors.black;
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

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({
    super.key,
    required this.doctor,
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
                  CircleAvatar(
                    backgroundImage: doctor.profilePicture.isNotEmpty
                        ? Image.memory(const Base64Decoder().convert(
                            doctor.profilePicture.split(',').last,
                          )).image
                        : const AssetImage('assets/images/avatar.png'),
                    radius: 30.0,
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${doctor.firstName}${doctor.lastName}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        doctor.specialization,
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
                    "5:00 PM",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16.0),
                  Icon(Icons.access_time, size: 16.0, color: Colors.grey[600]),
                  const SizedBox(width: 4.0),
                  Text(
                    "6:00 PM",
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
                        Navigator.pushNamed(
                            context, DoctorDetailsPage.routeName,
                            arguments: doctor);
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
                        Navigator.pushNamed(
                            context, DoctorDetailsPage.routeName,
                            arguments: doctor);
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
