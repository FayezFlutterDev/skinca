import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/models/profile_model.dart';
import 'package:skinca/views/home/home_cubit/home_cubit.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});
  static const String routeName = '/profile-info';

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedCountry = 'Egypt';
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Information'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileSuccess) {
            final profile = state.profile;
            _fullNameController.text =
                '${profile.firstName} ${profile.lastName}';
            _phoneController.text = profile.phoneNumber;
            _addressController.text = profile.address;
            _emailController.text = profile.email;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                      hintText: 'Abdullah Fayez',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/egypt.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: '+20-011-2772-0347',
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedCountry,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountry = newValue!;
                      });
                    },
                    items: <String>['Egypt', 'USA', 'UK', 'Canada']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Country',
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGender = newValue!;
                      });
                    },
                    items: <String>['Male', 'Female']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      hintText: '45 New Avenue, New York',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final fullName = _fullNameController.text.split(' ');
                      final firstName = fullName.first;
                      final lastName = fullName.sublist(1).join(' ');
                      final newProfile = ProfileUpdateModel(
                        email: _emailController.text,
                        firstName: firstName,
                        lastName: lastName,
                        phoneNumber: _phoneController.text,
                        latitude:
                            30.0, // Example latitude, update it accordingly
                        longitude:
                            31.2357, // Example longitude, update it accordingly
                        profilePicture: '',
                        address: _addressController
                            .text, // Update this with actual profile picture if available
                      );
                      BlocProvider.of<HomeCubit>(context)
                          .updateProfile(newProfile);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('SUBMIT'),
                  ),
                ],
              ),
            );
          } else if (state is ProfileFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('Unknown state.'));
          }
        },
      ),
    );
  }
}
