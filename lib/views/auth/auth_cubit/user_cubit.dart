// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skinca/core/api/end_points.dart';
import 'package:skinca/core/errors/exceptions.dart';
import 'package:skinca/core/functions/upload_image_toapi.dart';
import 'package:skinca/core/models/forgot_password_model.dart';
import 'package:skinca/core/models/sign_in_model.dart';
import 'package:skinca/core/models/sign_up_model.dart';
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

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final TextEditingController registerFNameController = TextEditingController();

  final TextEditingController registerLNameController = TextEditingController();

  final TextEditingController registerPhoneController = TextEditingController();

  final TextEditingController registerEmailController = TextEditingController();

  final TextEditingController registerAddressController =
      TextEditingController();

  final TextEditingController registerPasswordController =
      TextEditingController();

  final TextEditingController registerConfirmPasswordController =
      TextEditingController();
  bool visiblePass = false;
  bool agree = false;
  bool registerVisiblePass = false;
  bool registerAgree = false;
  bool registerVisibleConfirmPass = false;
  bool isMailSelected = true;

  TextEditingController forgotemailController = TextEditingController();
  TextEditingController forgotPhoneController = TextEditingController();
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();

  SignInModel? user;
  RegisterResponse? registerResponse;

  XFile? profilePic;
  bool isUploadPic = false;

  uploadProfilePic(XFile image) async {
    profilePic = image;
    emit(PickedProfilePic());
  }

  void toggleVisiblePass() {
    visiblePass = !visiblePass;
    emit(UserToggleVisiblePass(visiblePass));
  }

  void toggleVisibleConfirmPass() {
    registerVisibleConfirmPass = !registerVisibleConfirmPass;
    emit(UserToggleVisibleConfirmPass(registerVisibleConfirmPass));
  }

  void toggleRegisterVisiblePass() {
    registerVisiblePass = !registerVisiblePass;
    emit(UserToggleRegisterVisiblePass(registerVisiblePass));
  }

  void toggleRegisterAgree(bool value) {
    registerAgree = value;
    emit(UserRegisterToggleAgree(value));
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

      if (response is Map<String, dynamic>) {
        // Now create the SignInModel from the parsed JSON
        user = SignInModel.fromJson(response);

        // Log the user details for debugging
        print('User: $user');

        if (user != null && user!.isAuthenticated) {
          // Handle case where token is null or empty
          if (user!.token.isNotEmpty) {
            final decodeToken = JwtDecoder.decode(user!.token);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', user!.token);
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

  Future<void> signUp() async {
    try {
      emit(SignUpLoading());

      final response = await api.post(
        EndPoint.register,
        data: {
          ApiKey.fName: registerFNameController.text.trim(),
          ApiKey.lName: registerLNameController.text.trim(),
          ApiKey.email: registerEmailController.text.trim(),
          ApiKey.password: registerPasswordController.text.trim(),
          ApiKey.address: registerAddressController.text.trim(),
          ApiKey.confirmPassword: registerConfirmPasswordController.text.trim(),
          ApiKey.phoneNumber: registerPhoneController.text.trim(),
          ApiKey.profilePicture: await uploadImageToAPI(profilePic!),
        },
        isFormData: true,
      );

      // Log the response data for debugging
      
      // Check if the response data is a Map
      if (response is Map<String, dynamic>) {
        // Now create the RegisterResponse from the parsed JSON
        registerResponse = RegisterResponse.fromJson(response);

        // Log the user details for debugging
        print('User: $registerResponse');

        if (registerResponse != null && registerResponse!.isAuthenticated) {
          // Handle case where token is null or empty
          if (registerResponse!.token.isNotEmpty) {
            final decodeToken = JwtDecoder.decode(registerResponse!.token);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', registerResponse!.token);
            prefs.setString('id', decodeToken['sub']);

            emit(SignUpSuccess(registerResponse!.message));
          } else {
            emit(SignUpFailure('Token is missing in the response.'));
          }
        } else {
          emit(SignUpFailure(registerResponse?.message ?? 'Authentication failed.'));
        }
      } else {
        emit(SignUpFailure('Invalid response format from the server.'));
      }

      
    } on ServerException catch (e) {
      emit(SignUpFailure(e.errorModel.message));
    } catch (e) {
      emit(SignUpFailure('Unexpected error: $e'));
      print('Unexpected error: $e');
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
