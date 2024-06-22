class DiseaseModel {
  final int id;
  final String title;
  final String image;
  final String specialty;
  final List<String> symptoms;
  final List<String> types;
  final List<String> causes;
  final List<String> diagnosticMethods;
  final List<String> prevention;

  DiseaseModel({
    required this.id,
    required this.title,
    required this.image,
    required this.specialty,
    required this.symptoms,
    required this.types,
    required this.causes,
    required this.diagnosticMethods,
    required this.prevention,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      specialty: json['specialty'],
      symptoms: List<String>.from(json['symptoms']),
      types: List<String>.from(json['types']),
      causes: List<String>.from(json['causes']),
      diagnosticMethods: List<String>.from(json['diagnosticMethods']),
      prevention: List<String>.from(json['prevention']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'specialty': specialty,
      'symptoms': symptoms,
      'types': types,
      'causes': causes,
      'diagnosticMethods': diagnosticMethods,
      'prevention': prevention,
    };
  }
}
