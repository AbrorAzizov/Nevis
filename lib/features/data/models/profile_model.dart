import 'package:nevis/features/data/models/adress_model.dart';
import 'package:nevis/features/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    super.firstName,
    super.lastName,
    super.phone,
    super.dateOfBirth,
    super.gender,
    super.email,
    super.subscribeToMarketing,
    super.deliveryAddress,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json["personal_info"]["first_name"],
      lastName: json["personal_info"]["last_name"],
      phone: json["personal_info"]["phone"],
      dateOfBirth: json["personal_info"]["date_of_birth"],
      gender: json["personal_info"]["gender"],
      email: json["personal_info"]["email"],
      subscribeToMarketing: json["personal_info"]["subscribe_to_marketing"],
      deliveryAddress: json["delivery address"] != null
          ? AdressModel.fromJson(json["delivery_address"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "personal_info": {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "email": email,
        "subscribe_to_marketing": subscribeToMarketing.toString(),
      },
      "delivery_address": (deliveryAddress as AdressModel?)?.toJson(),
    };
  }
}
