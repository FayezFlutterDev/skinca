
import 'package:skinca/core/api/end_points.dart';

class ErrorModel {
  final String message;
  final int? code;

  ErrorModel({
    required this.message,
    this.code,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json[ApiKey.errorMessage],
      code: json[ApiKey.status],
    );
  }
}