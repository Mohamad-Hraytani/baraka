class AccountModel {
  String? username;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? role;

  AccountModel(
      {this.username,
      this.displayName,
      this.email,
      this.phoneNumber,
      this.role});

  AccountModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    displayName = json['displayName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['role'] = this.role;
    return data;
  }
}
