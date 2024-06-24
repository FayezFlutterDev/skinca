
import 'disease_model.dart';

class SearchResponseModel {
  final List<DiseaseModel> diseases;

  SearchResponseModel({required this.diseases});

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      diseases: (json['diseases'] as List)
          .map((e) => DiseaseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
