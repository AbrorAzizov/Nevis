part of 'info_about_order_screen_bloc.dart';

class InfoAboutOrderScreenState extends Equatable {
  final bool isLoading;
  final List<MapObject<dynamic>>? mapObjects;

  const InfoAboutOrderScreenState({
    this.isLoading = true,
    this.mapObjects,
  });

  InfoAboutOrderScreenState copyWith({
    bool? isLoading,
    List<MapObject<dynamic>>? mapObjects,
  }) {
    return InfoAboutOrderScreenState(
      isLoading: isLoading ?? this.isLoading,
      mapObjects: mapObjects ?? this.mapObjects,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        mapObjects,
      ];
}
