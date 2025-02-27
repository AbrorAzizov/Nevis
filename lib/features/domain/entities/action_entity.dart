import 'package:equatable/equatable.dart';

class ActionEntity extends Equatable {
  final int? actionId;
  final String? pageTitle;
  final String? alias;
  final String? createDttm;
  final String? image;
  final String? image1400300;
  final String? image960400;

  const ActionEntity({
    this.actionId,
    this.pageTitle,
    this.alias,
    this.createDttm,
    this.image,
    this.image1400300,
    this.image960400,
  });

  ActionEntity copyWith({
    int? actionId,
    String? pageTitle,
    String? alias,
    String? createDttm,
    String? image,
    String? image1400300,
    String? image960400,
  }) =>
      ActionEntity(
        actionId: actionId ?? this.actionId,
        pageTitle: pageTitle ?? this.pageTitle,
        alias: alias ?? this.alias,
        createDttm: createDttm ?? this.createDttm,
        image: image ?? this.image,
        image1400300: image1400300 ?? this.image1400300,
        image960400: image960400 ?? this.image960400,
      );

  @override
  List<Object?> get props => [
        actionId,
        pageTitle,
        alias,
        createDttm,
        image,
        image1400300,
        image960400,
      ];
}
