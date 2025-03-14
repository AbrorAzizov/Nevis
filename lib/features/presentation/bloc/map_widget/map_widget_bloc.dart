import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/usecases/content/get_pharmacies.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';



part 'map_widget_event.dart';
part 'map_widget_state.dart';

class MapWidgetBloc extends Bloc<MapWidgetEvent, MapWidgetState> {
  final GetPharmaciesUC getPharmaciesUC;

  MapWidgetBloc({required this.getPharmaciesUC}) : super(MapWidgetState()) {
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(LoadDataEvent event, Emitter<MapWidgetState> emit) async {}
}
