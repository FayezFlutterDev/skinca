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
