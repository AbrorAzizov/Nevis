import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/adress_entity.dart';

class ProfileEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? dateOfBirth;
  final String? gender;
  final String? email;
  final String? card;
  final bool? subscribeToMarketing;
  final AddressEntity? deliveryAddress;

  const ProfileEntity({
    this.card,
    this.firstName,
    this.lastName,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.email,
    this.subscribeToMarketing,
    this.deliveryAddress,
  });

  ProfileEntity copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? dateOfBirth,
    String? gender,
    String? email,
    String? card,
    bool? subscribeToMarketing,
    AddressEntity? deliveryAddress,
  }) =>
      ProfileEntity(
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          phone: phone ?? this.phone,
          dateOfBirth: dateOfBirth ?? this.dateOfBirth,
          gender: gender ?? this.gender,
          email: email ?? this.email,
          subscribeToMarketing:
              subscribeToMarketing ?? this.subscribeToMarketing,
          deliveryAddress: deliveryAddress ?? this.deliveryAddress,
          card: card ?? this.card);

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phone,
        dateOfBirth,
        gender,
        email,
        subscribeToMarketing,
        deliveryAddress,
      ];
}
