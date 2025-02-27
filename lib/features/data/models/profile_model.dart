

import 'package:nevis/features/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  final String? code;

  const ProfileModel({
    super.userId,
    super.phoneNumber,
    super.firstName,
    super.lastName,
    super.gender,
    super.birthday,
    super.emailAddress,
    super.statusNotifications,
    super.acceptPolicy,
    super.oldPassword,
    super.newPassword,
    super.newPasswordConfirm,
    this.code,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userId: json["userId"],
        phoneNumber: json["phone"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        birthday: json["birthday"],
        emailAddress: json["email"],
        statusNotifications: json["statusNotifications"],
        acceptPolicy: json["acceptPolicy"],
        oldPassword: json["old_password"],
        newPassword: json["new_password"],
        newPasswordConfirm: json["new_password_confirm"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "phone": phoneNumber,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "birthday": birthday,
        "email": emailAddress,
        "status_notifications": statusNotifications,
        "accept_policy": acceptPolicy,
        "code": code,
        "old_password": oldPassword,
        "new_password": newPassword,
        "new_password_confirm": newPasswordConfirm,
      };
}
