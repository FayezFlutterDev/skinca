
import 'package:skinca/core/api/end_points.dart';

class ErrorModel {
  final String message;

  ErrorModel({
    required this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json[ApiKey.errorMessage] ?? "An error occurred",
     
    );
  }
}
