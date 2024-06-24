import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/models/doctor_model.dart';
import 'package:skinca/views/doctor_details/doctor_details.dart';
import 'package:skinca/views/home/home_cubit/home_cubit.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});
  static const String routeName = '/doctors';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Doctors'),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
          if (state is DoctorsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        }, builder: (context, state) {
          return ListView.builder(
            itemCount: context.read<HomeCubit>().doctors.length,
            itemBuilder: (context, index) {
              final doctor = context.read<HomeCubit>().doctors[index];

              return DoctorCard(
                doctor: doctor,
              );
            },
          );
        }));
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        child: ListTile(
            title: Text(
              '${doctor.firstName} ${doctor.lastName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(doctor.specialization),
            leading: CircleAvatar(
              backgroundImage: doctor.profilePicture.isNotEmpty
                  ? Image.memory(
                      const Base64Decoder().convert(doctor.profilePicture),
                      fit: BoxFit.cover,
                    ).image
                  : const AssetImage("assets/images/avatar.png"),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  DoctorDetailsPage.routeName,
                  arguments: doctor,
                );
              },
            )),
      ),
    );
  }
}
