// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/api/api_consumer.dart';
import 'package:skinca/core/api/end_points.dart';
import 'package:skinca/core/errors/exceptions.dart';
import 'package:skinca/core/models/banner_model.dart';
import 'package:skinca/core/models/disease_model.dart';
import 'package:skinca/core/models/doctor_model.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiConsumer api;

  HomeCubit(this.api) : super(HomeInitial());

  List<BannerModel> banners = [];
  List<DiseaseModel> diseases = [];
  List<DoctorModel> doctors = [];

  Future<void> getBanners() async {
    try {
      // print("start getBanners");
      emit(BannersLoading());

      final dynamic response = await api.get(EndPoint.bannners);

      // Log the raw response data for debugging
      // print('Response data: $response');

      dynamic decodedResponse;

      // Check if the response is a String and decode it
      if (response is String) {
        // print("response is string ");
        decodedResponse = jsonDecode(response);
      } else {
        // If it's not a String, assume it's already decoded
        // print('response is not string ');
        decodedResponse = response;
      }

      // Log the decoded response
      // print('Decoded Response: $decodedResponse');
      // print('Decoded Response Type: ${decodedResponse.runtimeType}');

      // Check if the response is an error (401 Unauthorized)
      if (decodedResponse != null &&
          decodedResponse is Map<String, dynamic> &&
          decodedResponse.containsKey('statusCode') &&
          decodedResponse['statusCode'] == 401) {
        emit(BannersFailure('Unauthorized: Token expired or invalid'));
      }
      // Check if the decoded response is a Map with a 'banners' key
      else if (decodedResponse != null &&
          decodedResponse is Map<String, dynamic> &&
          decodedResponse.containsKey('banners') &&
          decodedResponse['banners'] is List) {
        banners = (decodedResponse['banners'] as List)
            .map((e) {
              if (e is Map<String, dynamic>) {
                return BannerModel.fromJson(e);
              } else {
                // print('Invalid banner format: $e');
                return null;
              }
            })
            .whereType<
                BannerModel>() // Filter out null values and cast to BannerModel
            .toList();
        emit(BannersSuccess());
      } else {
        emit(BannersFailure('Invalid response format from the server.'));
      }
    } on ServerException catch (e) {
      emit(BannersFailure(e.errorModel.message));
    } catch (e) {
      emit(BannersFailure('Unexpected error: $e'));
      // print('Unexpected error: $e');
    }
  }

  Future<void> getDiseases() async {
    try {
      // print("start getDiseases");
      emit(DiseasesLoading());

      final dynamic response = await api.get(EndPoint.diseases);

      // Log the raw response data for debugging
      // print('Response data: $response');

      dynamic decodedResponse;

      // Check if the response is a String and decode it
      if (response is String) {
        // print("response is string ");
        decodedResponse = jsonDecode(response);
      } else {
        // If it's not a String, assume it's already decoded
        // print('response is not string ');
        decodedResponse = response;
      }

      // Log the decoded response
      // print('Decoded Response: $decodedResponse');
      // print('Decoded Response Type: ${decodedResponse.runtimeType}');

      // Check if the decoded response is a List of disease objects
      if (decodedResponse != null && decodedResponse is List) {
        diseases = decodedResponse
            .map((e) {
              if (e is Map<String, dynamic>) {
                return DiseaseModel.fromJson(e);
              } else {
                // print('Invalid disease format: $e');
                return null;
              }
            })
            .whereType<
                DiseaseModel>() // Filter out null values and cast to DiseaseModel
            .toList();
        emit(DiseasesSuccess());
      } else {
        // If the response format is invalid, log the entire response for debugging
        // print('Invalid response format: $decodedResponse');
        emit(DiseasesFailure('Invalid response format from the server.'));
      }
    } on ServerException catch (e) {
      emit(DiseasesFailure(e.errorModel.message));
    } catch (e) {
      emit(DiseasesFailure('Unexpected error: $e'));
      print('Unexpected error: $e');
    }
  }
 
  Future<void> getDoctors() async {
    try {
      print("start getDoctors");
      emit(DoctorsLoading());

      final dynamic response = await api.get(EndPoint.doctors);

      // Log the raw response data for debugging
      // print('Response data: $response');

      dynamic decodedResponse;

      // Check if the response is a String and decode it
      if (response is String) {
        // print("response is string ");
        decodedResponse = jsonDecode(response);
      } else {
        // If it's not a String, assume it's already decoded
        // print('response is not string ');
        decodedResponse = response;
      }

      // Log the decoded response
      // print('Decoded Response: $decodedResponse');
      // print('Decoded Response Type: ${decodedResponse.runtimeType}');

      // Check if the decoded response is a List of doctor objects
      if (decodedResponse != null && decodedResponse is List) {
        doctors = decodedResponse
            .map((e) {
              if (e is Map<String, dynamic>) {
                return DoctorModel.fromJson(e);
              } else {
                // print('Invalid doctor format: $e');
                return null;
              }
            })
            .whereType<DoctorModel>() // Filter out null values and cast to DoctorModel
            .toList();
        emit(DoctorsSuccess());
      } else {
        // If the response format is invalid, log the entire response for debugging
        // print('Invalid response format: $decodedResponse');
        emit(DoctorsFailure('Invalid response format from the server.'));
      }
    } on ServerException catch (e) {
      emit(DoctorsFailure(e.errorModel.message));
    } catch (e) {
      emit(DoctorsFailure('Unexpected error: $e'));
      print('Unexpected error: $e');
    }
  }
}
