class ScanResponse {
  final String message;
  final bool status;

  ScanResponse({
    required this.message,
    required this.status,
  });

  factory ScanResponse.fromJson(Map<String, dynamic> json) {
    return ScanResponse(
      message: json['content'] ?? '',
      status: json['status'] ?? false,
    );
  }
}
