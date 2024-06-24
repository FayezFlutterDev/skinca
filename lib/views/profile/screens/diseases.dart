import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/models/disease_model.dart';
import 'package:skinca/views/disease_details/disease_details.dart';
import 'package:skinca/views/home/home_cubit/home_cubit.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';

class DiseasesPage extends StatelessWidget {
  const DiseasesPage({super.key});
  static const String routeName = '/diseases';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Diseases'),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
          if (state is DiseasesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        }, builder: (context, state) {
          return ListView.builder(
            itemCount: context.read<HomeCubit>().diseases.length,
            itemBuilder: (context, index) {
              final disease = context.read<HomeCubit>().diseases[index];

              return DiseaseCard(disease: disease);
            },
          );
        }));
   
  }
}
class DiseaseCard extends StatelessWidget {
  const DiseaseCard({
    super.key,
    required this.disease,
  });
  final DiseaseModel disease;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        child: ListTile(
            title: Text(
              disease.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(disease.specialty),
            leading: CircleAvatar(
              backgroundImage: disease.image.isNotEmpty
                  ? Image.memory(
                      const Base64Decoder().convert(disease.image),
                      fit: BoxFit.cover,
                    ).image
                  : const AssetImage("assets/images/avatar.png"),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  DiseaseDetailsPage.routeName,
                  arguments: disease,
                );
              },
            )),
      ),
    );
  }
}
