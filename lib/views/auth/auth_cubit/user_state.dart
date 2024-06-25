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

class UserToggleVisibleConfirmPass extends UserState {
  final bool registerVisibleConfirmPass;

  UserToggleVisibleConfirmPass(this.registerVisibleConfirmPass);
}

class UserToggleRegisterVisiblePass extends UserState {
  final bool registerVisiblePass;

  UserToggleRegisterVisiblePass(this.registerVisiblePass);
}


class UserToggleMail extends UserState {
  final bool isMailSelected;

  UserToggleMail(this.isMailSelected);
}

class UserToggleAgree extends UserState {
  final bool agree;

  UserToggleAgree(this.agree);
}

class UserRegisterToggleAgree extends UserState {
  final bool agree;

  UserRegisterToggleAgree(this.agree);
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

// Sign Up

class SignUpLoading extends UserState {}

class SignUpSuccess extends UserState {
  final String message;
  SignUpSuccess(this.message);
}

class SignUpFailure extends UserState {
  final String message;

  SignUpFailure(this.message);
}

class SignOutLoading extends UserState {}

class SignOutSuccess extends UserState {
  final String message;

  SignOutSuccess(this.message);
}

class SignOutFailure extends UserState {
  final String message;

  SignOutFailure(this.message);
}




