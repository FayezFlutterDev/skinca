// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skinca/core/api/end_points.dart';
import 'package:skinca/core/cache_helper.dart';
import 'package:skinca/core/errors/exceptions.dart';
import 'package:skinca/core/models/forgot_password_model.dart';
import 'package:skinca/core/models/sign_in_model.dart';
import 'package:skinca/views/auth/auth_cubit/user_state.dart';

import '../../../core/api/api_consumer.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());

  final ApiConsumer api;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  // XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  bool visiblePass = false;
  bool agree = false;
  bool isMailSelected = true;

  TextEditingController forgotemailController = TextEditingController();
  TextEditingController forgotPhoneController = TextEditingController();
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();

  SignInModel? user;

  // uploadProfilePic(XFile image) async {
  //   profilePic = image;
  //   emit(PickedProfilePic());
  // }
  void toggleVisiblePass() {
    visiblePass = !visiblePass;
    emit(UserToggleVisiblePass(visiblePass));
  }

  void toggleAgree(bool value) {
    agree = value;
    emit(UserToggleAgree(value));
    }
    void toggleMail() {
      isMailSelected = !isMailSelected;
      emit(UserToggleMail(isMailSelected));
    }

    Future<void> signIn() async {
      try {
        emit(SignInLoading());

        final response = await api.post(EndPoint.login, data: {
          ApiKey.email: signInEmail.text.trim(),
          ApiKey.password: signInPassword.text.trim()
        });

        // Log the response data for debugging
        print('Response data: $response');

        // Check if the response data is a Map
        if (response is Map<String, dynamic>) {
          // Now create the SignInModel from the parsed JSON
          user = SignInModel.fromJson(response);

          // Log the user details for debugging
          print('User: $user');

          if (user != null && user!.isAuthenticated) {
            // Handle case where token is null or empty
            if (user!.token != null && user!.token!.isNotEmpty) {
              final decodeToken = JwtDecoder.decode(user!.token!);

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('token', user!.token!);
              prefs.setString('id', decodeToken['sub']);

              emit(SignInSuccess());
            } else {
              emit(SignInFailure('Token is missing in the response.'));
            }
          } else {
            emit(SignInFailure(user?.message ?? 'Authentication failed.'));
          }
        } else {
          emit(SignInFailure('Invalid response format from the server.'));
        }
      } on ServerException catch (e) {
        emit(SignInFailure(e.errorModel.message));
      } catch (e) {
        emit(SignInFailure('Unexpected error: $e'));
        print('Unexpected error: $e');
      }
    }

    Future<void> signIn2() async {
      try {
        emit(SignInLoading());

        // Await the API response
        final response = await api.post(EndPoint.login, data: {
          ApiKey.email: signInEmail.text.trim(),
          ApiKey.password: signInPassword.text.trim()
        });

        // Parse the JSON response body
        final Map<String, dynamic> responseBody = json.decode(response.data);

        // Now create the SignInModel from the parsed JSON
        user = SignInModel.fromJson(responseBody);

        final decodeToken = JwtDecoder.decode(user!.token!);

        CacheHelper().saveData(key: 'token', value: user!.token);
        CacheHelper().saveData(key: 'id', value: decodeToken['sub']);

        emit(SignInSuccess());
      } on ServerException catch (e) {
        emit(SignInFailure(e.errorModel.message));
      }
    }

    signUp() async {
      try {
        emit(SignInLoading());
        final response = api.post(EndPoint.register, data: {
          ApiKey.name: signUpName.text.trim(),
          ApiKey.email: signUpEmail.text.trim(),
          ApiKey.password: signUpPassword.text.trim(),
          ApiKey.passwordConfirmation: confirmPassword.text.trim(),
          ApiKey.phone: signUpPhoneNumber.text.trim(),
        });
        user = SignInModel.fromJson(await response);
        final decodeToken = JwtDecoder.decode(user!.token!);

        CacheHelper().saveData(key: 'token', value: user!.token);
        CacheHelper().saveData(key: 'id', value: decodeToken['id']);

        emit(SignInSuccess());
      } on ServerException catch (e) {
        emit(SignInFailure(e.errorModel.message));
      }
    }

    Future<void> signOut() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('id');
      emit(UserInitial());
    }

    Future<void> forgotPassword() async {
    try {
      emit(ForgotPasswordLoading());
      final response = await api.post(EndPoint.forgotPassword, data: {
        ApiKey.email: forgotemailController.text.trim(),
      });
      final forgotPasswordResponse = ForgotPasswordResponse.fromJson(response);
      emit(ForgotPasswordSuccess(forgotPasswordResponse.message));
    } on ServerException catch (e) {
      emit(ForgotPasswordFailure(e.errorModel.message));
    } catch (e) {
      emit(ForgotPasswordFailure('Unexpected error: $e'));
    }
  }
}
  


