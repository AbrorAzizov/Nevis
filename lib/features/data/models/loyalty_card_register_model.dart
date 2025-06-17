import 'package:equatable/equatable.dart';

class LoyaltyCardRegisterModel extends Equatable {
  final String cardNumber;
  final String phoneNumber;
  final String birthDate;
  final String gender;
  final String firstName;
  final String lastName;
  final String email;

  const LoyaltyCardRegisterModel({
    required this.cardNumber,
    required this.phoneNumber,
    required this.birthDate,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'card_number': cardNumber,
        'phone_number': phoneNumber,
        'birth_date': birthDate,
        'gender': gender,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      };

  @override
  List<Object?> get props => [
        cardNumber,
        phoneNumber,
        birthDate,
        gender,
        firstName,
        lastName,
        email,
      ];
}
