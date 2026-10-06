class RefreshTokenResponse {
  final bool? status;
  final String? message;
  final RefreshTokenData data;

  const RefreshTokenResponse({
    this.status,
    this.message,
    required this.data,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: RefreshTokenData.fromJson(json["data"] ?? {}),
    );
  }
}

class RefreshTokenData {
  final String accessToken;
  final String? refreshToken;

  const RefreshTokenData({
    required this.accessToken,
    this.refreshToken,
  });

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) {
    return RefreshTokenData(
      accessToken: json["accessToken"] ?? "",
      refreshToken: json["refreshToken"] ?? "",
    );
  }
}
