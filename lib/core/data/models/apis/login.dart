class Login {
  int? userId;
  String? token;

  Login({this.userId, this.token});

  Login.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['token'] = this.token;
    return data;
  }
}