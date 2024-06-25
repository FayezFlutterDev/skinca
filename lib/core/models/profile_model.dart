class Profile {
  final String email;
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final String address;
  final String phoneNumber;
  final double? latitude;
  final double? longitude;
  final String? profilePicture;

  Profile({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.profilePicture,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      profilePicture: json['profilePicture'],
    );
  }
}

class ProfileUpdateModel {
  final String email;
  final String firstName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final double? latitude;
  final double? longitude;
  final String? profilePicture;

  ProfileUpdateModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'profilePicture': profilePicture,
    };
  }
}
