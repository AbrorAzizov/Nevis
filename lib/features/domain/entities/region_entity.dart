import 'package:equatable/equatable.dart';

class RegionEntity extends Equatable {
  final int? id;
  final String? name;
  final bool? isDefault;

  const RegionEntity({this.id, this.name, this.isDefault});

  @override
  List<Object?> get props => [id, name, isDefault];
}
