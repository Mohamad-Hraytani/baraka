class UserInfo {
  int? userId;
  int? userType;
  int? loginType;
  String? loginTypeFirst;
  String? twitterId;
  String? instagramId;
  String? googleId;
  String? facebookId;
  String? otp;
  int? otpVerify;
  int? profileComplete;
  String? fName;
  String? lName;
  String? name;
  String? dob;
  int? mobile;
  String? email;
  String? password;
  String? image;
  int? languageId;
  int? activeFlag;
  int? notificationStatus;
  int? deleteFlag;
  String? createtime;
  String? updatetime;
  String? address;
  int? phoneCode;
  int? countryId;
  String? versionArr;
  String? countrtName;
  String? paymentModeStatus;
  String? otpAutofillStatus;

  UserInfo(
      {this.userId,
      this.userType,
      this.countryId,
      this.loginType,
      this.image,
      this.loginTypeFirst,
      this.twitterId,
      this.instagramId,
      this.countrtName,
      this.googleId,
      this.facebookId,
      this.otp,
      this.otpVerify,
      this.profileComplete,
      this.fName,
      this.lName,
      this.name,
      this.dob,
      this.mobile,
      this.email,
      this.password,
      this.languageId,
      this.activeFlag,
      this.notificationStatus,
      this.deleteFlag,
      this.createtime,
      this.updatetime,
      this.address,
      this.phoneCode,
      this.versionArr,
      this.paymentModeStatus,
      this.otpAutofillStatus});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    countryId = json['country_id'];
    countrtName = json['country_name'];
    userType = json['user_type'];
    loginType = json['login_type'];
    loginTypeFirst = json['login_type_first'];
    twitterId = json['twitter_id'];
    instagramId = json['instagram_id'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    otp = json['otp'];
    otpVerify = json['otp_verify'];
    profileComplete = json['profile_complete'];
    fName = json['f_name'];
    lName = json['l_name'];
    name = json['name'];
    dob = json['dob'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    image = json['image'];

    languageId = json['language_id'];
    activeFlag = json['active_flag'];
    notificationStatus = json['notification_status'];
    deleteFlag = json['delete_flag'];
    createtime = json['createtime'];
    updatetime = json['updatetime'];
    address = json['address'];
    phoneCode = json['phone_code'];
    versionArr = json['version_arr'];
    paymentModeStatus = json['payment_mode_status'];
    otpAutofillStatus = json['otp_autofill_status'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['login_type'] = this.loginType;
    data['login_type_first'] = this.loginTypeFirst;
    data['twitter_id'] = this.twitterId;
    data['instagram_id'] = this.instagramId;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['otp'] = this.otp;
    data['otp_verify'] = this.otpVerify;
    data['profile_complete'] = this.profileComplete;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['image'] = this.image;
    data['language_id'] = this.languageId;
    data['active_flag'] = this.activeFlag;
    data['notification_status'] = this.notificationStatus;
    data['delete_flag'] = this.deleteFlag;
    data['createtime'] = this.createtime;
    data['updatetime'] = this.updatetime;
    data['address'] = this.address;
    data['phone_code'] = this.phoneCode;
    data['version_arr'] = this.versionArr;
    data['payment_mode_status'] = this.paymentModeStatus;
    data['otp_autofill_status'] = this.otpAutofillStatus;
    data['country_name'] = this.countrtName;
    data['country_id'] = this.countryId;

    return data;
  }
}
