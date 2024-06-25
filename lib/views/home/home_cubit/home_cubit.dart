// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/api/api_consumer.dart';
import 'package:skinca/core/api/end_points.dart';
import 'package:skinca/core/errors/exceptions.dart';
import 'package:skinca/core/models/banner_model.dart';
import 'package:skinca/core/models/create_chat_model.dart';
import 'package:skinca/core/models/disease_model.dart';
import 'package:skinca/core/models/doctor_model.dart';
import 'package:skinca/core/models/profile_model.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiConsumer api;

  HomeCubit(this.api) : super(HomeInitial());

  List<BannerModel> banners = [];
  List<DiseaseModel> diseases = [];
  List<DoctorModel> doctors = [];
  GlobalKey<FormState> searchKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  Profile profile = Profile(
    email: '',
    firstName: '',
    lastName: '',
    birthDate: DateTime.now(),
    address: '',
    phoneNumber: '',
    latitude: 0.0,
    longitude: 0.0,
    profilePicture: '',
  );

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
      // print("start getDoctors");
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
            .whereType<
                DoctorModel>() // Filter out null values and cast to DoctorModel
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

  Future<void> search(String query) async {
    try {
      emit(SearchLoading());
      print("Starting search with query: $query");

      final dynamic response = await api.get('${EndPoint.search}/$query');
      print('Response data: $response');

      dynamic decodedResponse;
      if (response is String) {
        print("Response is a string");
        decodedResponse = jsonDecode(response);
      } else {
        print('Response is not a string');
        decodedResponse = response;
      }

      print('Decoded Response: $decodedResponse');
      print('Decoded Response Type: ${decodedResponse.runtimeType}');

      if (decodedResponse == null) {
        emit(SearchFailure('No response received from the server.'));
        return;
      }

      if (decodedResponse is Map<String, dynamic> &&
          decodedResponse.containsKey('statusCode') &&
          decodedResponse['statusCode'] == 401) {
        emit(SearchFailure('Unauthorized: Token expired or invalid'));
        return;
      }

      if (decodedResponse is Map<String, dynamic> &&
          decodedResponse.containsKey('diseases') &&
          decodedResponse['diseases'] is List &&
          decodedResponse.containsKey('doctors') &&
          decodedResponse['doctors'] is List) {
        final List<dynamic>? diseasesList = decodedResponse['diseases'];
        final List<dynamic>? doctorsList = decodedResponse['doctors'];

        if (diseasesList == null || doctorsList == null) {
          emit(SearchFailure('Diseases or doctors list is null.'));
          return;
        }

        // Parse diseases from the response
        final List<DiseaseModel> diseases = diseasesList
            .map((e) => DiseaseModel.fromJson(e as Map<String, dynamic>))
            .toList();

        // Parse doctors from the response
        final List<DoctorModel> doctors = doctorsList
            .map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(SearchSuccess(diseases, doctors));
      } else {
        print('Invalid response format: $decodedResponse');
        emit(SearchFailure('Invalid response format from the server.'));
      }
    } on ServerException catch (e) {
      emit(SearchFailure(e.errorModel.message));
    } catch (e) {
      emit(SearchFailure('Unexpected error: $e'));
      print('Unexpected error: $e');
    }
  }

  Future<void> getProfile() async {
    try {
      emit(ProfileLoading());

      final dynamic response = await api.get(EndPoint.profile);
      print(response);

      dynamic decodedResponse;

      if (response is String) {
        decodedResponse = jsonDecode(response);
      } else {
        decodedResponse = response;
      }

      if (decodedResponse != null && decodedResponse is Map<String, dynamic>) {
        if (decodedResponse.containsKey('profile')) {
          profile = Profile.fromJson(decodedResponse['profile']);
          print(profile);
          emit(ProfileSuccess(profile));
        } else {
          emit(ProfileFailure('Profile data is missing.'));
        }
      } else {
        emit(ProfileFailure('Invalid response format from the server.'));
      }
    } on ServerException catch (e) {
      emit(ProfileFailure(e.errorModel.message));
    } catch (e) {
      emit(ProfileFailure('Unexpected error: $e'));
      print('Unexpected error: $e');
    }
  }

  Future<void> updateProfile(ProfileUpdateModel newProfile) async {
    try {
      emit(ProfileLoading());

      final dynamic response = await api.put(
        EndPoint.profile,
        data: {
          ApiKey.email: newProfile.email,
          ApiKey.fName: newProfile.firstName,
          ApiKey.lName: newProfile.lastName,
          ApiKey.phoneNumber: newProfile.phoneNumber,
          // Add other necessary fields here
        },
        isFormData: true,
      );

      print("Response from update profile: $response");

      dynamic decodedResponse;
      if (response is String) {
        try {
          print("Response is a string. Attempting to decode...");
          decodedResponse = jsonDecode(response);
          print('Decoded Response: $decodedResponse');
        } catch (e) {
          print("Failed to decode string response: $e");
          emit(ProfileFailure('Failed to decode string response.'));
          return;
        }
      } else if (response is Map<String, dynamic>) {
        print('Response is already a Map');
        decodedResponse = response;
      } else {
        print('Unexpected response type: ${response.runtimeType}');
        emit(ProfileFailure('Unexpected response type from the server.'));
        return;
      }

      if (decodedResponse == null) {
        emit(ProfileFailure('No response received from the server.'));
        return;
      }

      if (decodedResponse.containsKey('status') &&
          decodedResponse['status'] == true) {
        if (decodedResponse.containsKey('profile')) {
          final profileData = decodedResponse['profile'];
          final updatedProfile = Profile.fromJson(profileData);
          emit(ProfileSuccess(updatedProfile));
        } else {
          emit(ProfileFailure('Profile data is missing in the response.'));
        }
      } else {
        final errorMessage = decodedResponse['message'] ?? 'Unknown error';
        emit(ProfileFailure(errorMessage));
      }
    } on ServerException catch (e) {
      emit(ProfileFailure(e.errorModel.message));
    } catch (e) {
      emit(ProfileFailure('Unexpected error: $e'));
      print('Unexpected error: $e');
    }
  }

  Future<void> updateProfilePicture(String imagePath) async {
    try {
      emit(ProfileLoading());

      final dynamic response = await api.put(
        EndPoint.baseUrl,
        data: {
          ApiKey.profilePicture: imagePath,
        },
        isFormData: true,
      );

      print("Response from update profile picture: $response");

      dynamic decodedResponse;
      if (response is String) {
        try {
          print("Response is a string. Attempting to decode...");
          decodedResponse = jsonDecode(response);
          print('Decoded Response: $decodedResponse');
        } catch (e) {
          print("Failed to decode string response: $e");
          emit(ProfileFailure('Failed to decode string response.'));
          return;
        }
      } else if (response is Map<String, dynamic>) {
        print('Response is already a Map');
        decodedResponse = response;
      } else {
        print('Unexpected response type: ${response.runtimeType}');
        emit(ProfileFailure('Unexpected response type from the server.'));
        return;
      }

      if (decodedResponse == null) {
        emit(ProfileFailure('No response received from the server.'));
        return;
      }

      if (decodedResponse.containsKey('status') &&
          decodedResponse['status'] == true) {
        if (decodedResponse.containsKey('profile')) {
          final profileData = decodedResponse['profile'];
          final updatedProfile = Profile.fromJson(profileData);
          emit(ProfileSuccess(updatedProfile));
        } else {
          emit(ProfileFailure('Profile data is missing in the response.'));
        }
      } else {
        final errorMessage = decodedResponse['message'] ?? 'Unknown error';
        emit(ProfileFailure(errorMessage));
      }
    } on ServerException catch (e) {
      emit(ProfileFailure(e.errorModel.message));
    } catch (e) {
      emit(ProfileFailure('Unexpected error: $e'));
      print('Unexpected error: $e');
    }
  }

  Future<void> createChat(String doctorId) async {
    try {
      emit(CreateChatLoading());

      final response = await api.post(
        "${EndPoint.createChat}$doctorId",
      );
      print('Response chat data: $response');

      if (response.data != null && response.data is Map<String, dynamic>) {
        final chatResponse = ChatResponse.fromJson(response.data);

        if (chatResponse.status) {
          emit(CreateChatSuccess(chatResponse.chat));
        } else {
          emit(CreateChatFailure('Failed to create chat.'));
        }
      } else {
        emit(CreateChatFailure('Invalid response format from the server.'));
      }
    } on ServerException catch (e) {
      emit(ProfileFailure(e.errorModel.message));
    } catch (e) {
      emit(ProfileFailure('Unexpected error: $e'));
      print('Unexpected error: $e');
    }
  }
}
