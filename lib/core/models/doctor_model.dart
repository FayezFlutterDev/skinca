class DoctorModel {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final int experience;
  final String description;
  final double latitude;
  final double longitude;
  final double rating;
  final double clinicFees;
  final List<String> services;
  final String specialization;
  final bool isWorking;
  final String phoneNumber;
  final String address;
  final List<ClinicSchedule> clinicSchedule;
  final String profilePicture;

  DoctorModel({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.experience,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.clinicFees,
    required this.services,
    required this.specialization,
    required this.isWorking,
    required this.phoneNumber,
    required this.address,
    required this.clinicSchedule,
    required this.profilePicture,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      userId: json['userId'] ?? "",
      email: json['email'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      experience: json['experience'] ?? 0,
      description: json['description'] ?? "",
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      rating: json['rating'] ?? 0.0,
      clinicFees: json['clinicFees'] ?? 0.0,
      services: List<String>.from(json['services'] ?? []),
      specialization: json['specialization'] ?? "",
      isWorking: json['isWorking'] ?? false,
      phoneNumber: json['phoneNumber'] ?? "",
      address: json['address'] ?? "",
      clinicSchedule: (json['clinicSchedule'] as List<dynamic>?)
              ?.map((e) => ClinicSchedule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      profilePicture: json['profilePicture'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'experience': experience,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'clinicFees': clinicFees,
      'services': services,
      'specialization': specialization,
      'isWorking': isWorking,
      'phoneNumber': phoneNumber,
      'address': address,
      'clinicSchedule': clinicSchedule.map((e) => e.toJson()).toList(),
      'profilePicture': profilePicture,
    };
  }
}

class ClinicSchedule {
  final String openAt;
  final String closeAt;
  final String day;

  ClinicSchedule({
    required this.openAt,
    required this.closeAt,
    required this.day,
  });

  factory ClinicSchedule.fromJson(Map<String, dynamic> json) {
    return ClinicSchedule(
      openAt: json['openAt'] ?? "",
      closeAt: json['closeAt'] ?? "",
      day: json['day'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'openAt': openAt,
      'closeAt': closeAt,
      'day': day,
    };
  }
}
