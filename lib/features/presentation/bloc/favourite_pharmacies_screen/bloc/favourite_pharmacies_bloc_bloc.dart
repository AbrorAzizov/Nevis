import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/content/get_pharmacies.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/info_about_order_screen/info_about_order_screen_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'favourite_pharmacies_bloc_event.dart';
part 'favourite_pharmacies_bloc_state.dart';

class FavouritePharmaciesBloc
    extends Bloc<FavouritePharmaciesEvent, FavouritePharmaciesState> {
  final GetPharmaciesUC getPharmaciesUC;
  FavouritePharmaciesBloc({required this.getPharmaciesUC})
      : super(FavouritePharmaciesInitial()) {
    on<LoadDataEvent>(_onLoadData);
    on<PharmacyMarkerTappedEvent>(_onSelectPharmacy);
  }
  void _onLoadData(
      LoadDataEvent event, Emitter<FavouritePharmaciesState> emit) async {
    emit(FavouritePharmaciesLoading());
    final failureOrLoads = await getPharmaciesUC('');
    List<MapObject> mapObjects = [];
    failureOrLoads.fold(
      (_) =>
          emit(FavouritePharmaciesError(message: 'Something went wrong')),
      (pharmacies) async {
        final icon = await Utils.createBitmapIcon();
        for (PharmacyEntity pharmacy in pharmacies) {
          double latitude =
              double.parse(pharmacy.coordinates!.split(', ').first);
          double longitude =
              double.parse(pharmacy.coordinates!.split(', ').last);

          // Генерация иконки для маркера с количеством аптек

          final marker = PlacemarkMapObject(
            mapId: MapObjectId(pharmacy.pharmacyId.toString()),
            point: Point(latitude: latitude, longitude: longitude),
            icon: PlacemarkIcon.single(
                PlacemarkIconStyle(image: icon, scale: 0.5)),
            onTap: (_, __) {
              add(PharmacyMarkerTappedEvent(pharmacy: pharmacy));
            },
          );
          mapObjects.add(marker);
        }
      },
    );
    emit(FavouritePharmaciesLoaded(mapObjects: mapObjects));
  }

  void _onSelectPharmacy(
      PharmacyMarkerTappedEvent event, Emitter<FavouritePharmaciesState> emit) {
    if (state is FavouritePharmaciesLoaded) {
      final currentState = state as FavouritePharmaciesLoaded;
      emit(currentState.copyWith(selectedPharmacy: event.pharmacy));
      
    }
  }
}
