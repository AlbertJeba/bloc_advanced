class RefreshTokenResponse {
  final RefreshTokenData data;

  RefreshTokenResponse({required this.data});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      data: RefreshTokenData.fromJson(json['data'] ?? json),
    );
  }
}

class RefreshTokenData {
  final String accessToken;

  RefreshTokenData({required this.accessToken});

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) {
    return RefreshTokenData(
      accessToken: json['accessToken'] ?? json['token'] ?? '',
    );
  }
}
