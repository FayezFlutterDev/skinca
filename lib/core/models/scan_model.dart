class ScanResponse {
  final String prediction;
  final bool status;

  ScanResponse({
    required this.prediction,
    required this.status,
  });

  factory ScanResponse.fromJson(Map<String, dynamic> json) {
    return ScanResponse(
      prediction: json['prediction'] ?? '',
      status: json['status'] ?? false,
    );
  }
}
