 class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}


final class SignInLoading extends UserState {}


final class SignInFailure extends UserState {
  final String message;
  SignInFailure(this.message);
}

final class PickedProfilePic extends UserState {}
class UserToggleVisiblePass extends UserState {
  final bool visiblePass;

  UserToggleVisiblePass(this.visiblePass);
}
class UserToggleMail extends UserState {
  final bool isMailSelected;

  UserToggleMail(this.isMailSelected);
}

class UserToggleAgree extends UserState {
  final bool agree;

  UserToggleAgree(this.agree);
}
class ForgotPasswordLoading extends UserState {}

class ForgotPasswordSuccess extends UserState {
  final String message;

  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordFailure extends UserState {
  final String message;

  ForgotPasswordFailure(this.message);
}


