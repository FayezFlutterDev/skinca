
class SignInModel {
  String message;
  String token;
  bool isAuthenticated;

  SignInModel({
    required this.message,
    required this.token,
    required this.isAuthenticated,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      message: json['message']??'',
      token: json['token']??'',
      isAuthenticated: json['isAuthenticated']??false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'isAuthenticated': isAuthenticated,
    };
  }
}
