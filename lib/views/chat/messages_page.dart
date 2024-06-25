import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/models/doctor_model.dart';
import 'package:skinca/views/chat/chat_page.dart';
import 'package:skinca/views/home/home_cubit/home_cubit.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});
  static const String routeName = '/message';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.teal,
      ),
      body: Expanded(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is DoctorsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            return ListView.builder(
              itemCount: context.read<HomeCubit>().doctors.length,
              itemBuilder: (context, index) {
                final doctor = context.read<HomeCubit>().doctors[index];
                return DoctorCard(doctor: doctor);
              },
            );
          },
        ),
      ),
    );
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
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(
            ChatPage.routeName,
            arguments: doctor,
          );
        },
        child: Card(
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: doctor.profilePicture.isNotEmpty
                  ? Image.memory(
                      const Base64Decoder().convert(doctor.profilePicture),
                      fit: BoxFit.cover,
                    ).image
                  : const AssetImage("assets/images/avatar.png"),
            ),
            title: Text(
              '${doctor.firstName} ${doctor.lastName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(doctor.specialization),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('12:50 PM'), // You can replace this with actual time data
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                ChatPage.routeName,
                arguments: doctor,
              );
            },
          ),
        ),
      ),
    );
  }
}
