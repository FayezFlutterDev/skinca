import 'package:skinca/core/models/create_chat_model.dart';
import 'package:skinca/core/models/disease_model.dart';
import 'package:skinca/core/models/doctor_model.dart';
import 'package:skinca/core/models/profile_model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class BannersLoading extends HomeState {}

class BannersSuccess extends HomeState {}

class BannersFailure extends HomeState {
  final String error;

  BannersFailure(this.error);
}

class DiseasesLoading extends HomeState {}

class DiseasesSuccess extends HomeState {}

class DiseasesFailure extends HomeState {
  final String error;

  DiseasesFailure(this.error);
}


class DoctorsLoading extends HomeState {}

class DoctorsSuccess extends HomeState {}

class DoctorsFailure extends HomeState {
  final String error;

  DoctorsFailure(this.error);
}

class SearchLoading extends HomeState {}

class SearchSuccess extends HomeState {
  final List<DiseaseModel> diseases;
  final List<DoctorModel> doctors;

  SearchSuccess(this.diseases, this.doctors);
}

class SearchFailure extends HomeState {
  final String error;

  SearchFailure(this.error);
}

class ProfileLoading extends HomeState {}

class ProfileSuccess extends HomeState {
  final Profile profile;

  ProfileSuccess(this.profile);
}

class ProfileFailure extends HomeState {
  final String error;

  ProfileFailure(this.error);
}

class CreateChatLoading extends HomeState {}

class CreateChatSuccess extends HomeState {
  final Chat chat;
  CreateChatSuccess(this.chat);
}

class CreateChatFailure extends HomeState {
  final String error;
  CreateChatFailure(this.error);
}
class PickImageLoading extends HomeState {}

class ScanLoading extends HomeState {}

class ScanSuccess extends HomeState {
  final String prediction;
  final bool status;

  ScanSuccess(this.prediction, this.status);
}

class ScanFailure extends HomeState {
  final String error;

  ScanFailure(this.error);
}
