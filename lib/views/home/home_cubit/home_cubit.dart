// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/api/api_consumer.dart';
import 'package:skinca/core/api/end_points.dart';
import 'package:skinca/core/errors/exceptions.dart';
import 'package:skinca/core/models/banner_model.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiConsumer api;

  HomeCubit(this.api) : super(HomeInitial());



  Future<void> getBanners() async {
  try {
    print("start getBanners");
    emit(BannersLoading());

    final dynamic response = await api.get(EndPoint.bannners);

    // Log the raw response data for debugging
    print('Response data: $response');

    dynamic decodedResponse;

    // Check if the response is a String and decode it
    if (response is String) {
      print("response is string ");
      decodedResponse = jsonDecode(response);
    } else {
      // If it's not a String, assume it's already decoded
      print('response is not string ');
      decodedResponse = response;
    }

    // Log the decoded response
    print('Decoded Response: $decodedResponse');
    print('Decoded Response Type: ${decodedResponse.runtimeType}');

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
      final banners = (decodedResponse['banners'] as List)
          .map((e) {
            if (e is Map<String, dynamic>) {
              return BannerModel.fromJson(e);
            } else {
              print('Invalid banner format: $e');
              return null;
            }
          })
          .whereType<BannerModel>() // Filter out null values and cast to BannerModel
          .toList();
      emit(BannersSuccess(banners));
    } else {
      emit(BannersFailure('Invalid response format from the server.'));
    }
  } on ServerException catch (e) {
    emit(BannersFailure(e.errorModel.message));
  } catch (e) {
    emit(BannersFailure('Unexpected error: $e'));
    print('Unexpected error: $e');
  }
}



    Future<void> getBanners2() async {
      try {
        emit(BannersLoading());

        final response = await api.get(EndPoint.bannners);

        // Log the raw response data for debugging
        print('Response data: $response');

        // Decode the JSON response if it's a string
        dynamic decodedResponse = response;
        if (response is String) {
          decodedResponse = jsonDecode(response);
        }

        // Check if the response is an error (401 Unauthorized)
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('statusCode') &&
            decodedResponse['statusCode'] == 401) {
          emit(BannersFailure('Unauthorized: Token expired or invalid'));
        }
        // Check if the decoded response is a List
        else if (decodedResponse is List) {
          final banners = decodedResponse
              .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
              .toList();
          emit(BannersSuccess(banners));
        } else {
          emit(BannersFailure('Invalid response format from the server.'));
        }
      } on ServerException catch (e) {
        emit(BannersFailure(e.errorModel.message));
      } catch (e) {
        emit(BannersFailure('Unexpected error: $e'));
        print('Unexpected error: $e');
      }
    }
  }

