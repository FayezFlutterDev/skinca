class SignInModel {
  final String message;
  final String? token;
  final bool isAuthenticated;

  SignInModel({
    required this.message,
    required this.token,
    required this.isAuthenticated,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      message: json['message'] as String? ?? '',
      token: json['token'] as String?,
      isAuthenticated: json['isAuthenticated'] ?? false,
    );
  }
}
