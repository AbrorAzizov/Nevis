import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/usecases/category/get_categories.dart';

part 'catalog_screen_event.dart';
part 'catalog_screen_state.dart';

class CatalogScreenBloc extends Bloc<CatalogScreenEvent, CatalogScreenState> {
  final GetCategoriesUC getCategoriesUC;
  CatalogScreenBloc({required this.getCategoriesUC})
      : super(CatalogScreenState()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
  }

  void _onLoadCategories(
      LoadCategoriesEvent event, Emitter<CatalogScreenState> emit) async {
    final failureOrLoads = await getCategoriesUC();

    failureOrLoads.fold(
      (_) => emit(
        CatalogScreenState(errorText: 'Ошибка загрузки данных'),
      ),
      (categories) => emit(
        CatalogScreenState(
            errorText: null, isLoading: false, categories: categories),
      ),
    );
  }
}
