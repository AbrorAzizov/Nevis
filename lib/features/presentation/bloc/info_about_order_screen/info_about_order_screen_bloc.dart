import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/content/get_pharmacies.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'info_about_order_screen_event.dart';
part 'info_about_order_screen_state.dart';

class InfoAboutOrderScreenBloc
    extends Bloc<InfoAboutOrderScreenEvent, InfoAboutOrderScreenState> {
  final GetPharmaciesUC getPharmaciesUC;

  InfoAboutOrderScreenBloc({required this.getPharmaciesUC})
      : super(InfoAboutOrderScreenState()) {
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(
      LoadDataEvent event, Emitter<InfoAboutOrderScreenState> emit) async {
    final failureOrLoads = await getPharmaciesUC('');
    List<MapObject> mapObjects = [];

    failureOrLoads.fold(
      (_) => emit(
        InfoAboutOrderScreenState(isLoading: false),
      ),
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
            icon: PlacemarkIcon.single(PlacemarkIconStyle(image: icon)),
            onTap: (_, __) {},
          );

          mapObjects.add(marker);
        }
      },
    );

    emit(
      InfoAboutOrderScreenState(isLoading: false, mapObjects: mapObjects),
    );
  }
}
