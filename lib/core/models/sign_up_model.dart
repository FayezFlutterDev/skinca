class RegisterResponse {
  final String message;
  final bool isAuthenticated;
  final bool isDoctor;
  final String token;
  final String name;
  late final String? picture;

  RegisterResponse({
    required this.message,
    required this.isAuthenticated,
    required this.isDoctor,
    required this.token,
    required this.name,
    required this.picture,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] ?? '',
      isAuthenticated: json['isAuthenticated'] ?? false,
      isDoctor: json['isDoctor'] ?? false,
      token: json['token']  ?? '',
      name: json['userName'] as String? ?? '',
      picture: json['profilePicture'] as String? ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isAuthenticated': isAuthenticated,
      'isDoctor': isDoctor,
      'token': token,
    };
  }
}
