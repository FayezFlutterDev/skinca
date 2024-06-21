class SignInModel {
  final String message;
  final String token;
  final bool isAuthenticated;
  final String name;
  late final String? picture;

  SignInModel({
    required this.message,
    required this.token,
    required this.isAuthenticated,
    required this.name,
    required this.picture ,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      message: json['message'] as String? ?? '',
      token: json['token'] as String? ?? '',
      isAuthenticated: json['isAuthenticated'] ?? false,
      name: json['userName'] as String? ?? '',
      picture: json['profilePicture'] as String? ?? '',
    );
  }
}
