class SignInModel {
  bool? status;
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;
  int? userId;

  SignInModel(
      {this.status,
        this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.refreshToken,
        this.userId});

  SignInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    data['user_id'] = this.userId;
    return data;
  }
}
