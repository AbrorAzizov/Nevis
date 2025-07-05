import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/usecases/category/get_brands.dart';
import 'package:nevis/features/domain/usecases/category/get_countries.dart';
import 'package:nevis/features/domain/usecases/category/get_forms.dart';
import 'package:nevis/features/domain/usecases/category/get_subcategories.dart';

part 'category_screen_event.dart';
part 'category_screen_state.dart';

class CategoryScreenBloc
    extends Bloc<CategoryScreenEvent, CategoryScreenState> {
  final GetSubcategoriesUC getSubcategoriesUC;
  final GetBrandsUC getBrandsUC;
  final GetFormsUC getFormsUC;
  final GetCountriesUC getCountriesUC;

  CategoryScreenBloc({
    required this.getSubcategoriesUC,
    required this.getBrandsUC,
    required this.getFormsUC,
    required this.getCountriesUC,
  }) : super(CategoryScreenState()) {
    on<LoadSubcategoriesEvent>(_onLoadSubcategories);
  }

  void _onLoadSubcategories(
      LoadSubcategoriesEvent event, Emitter<CategoryScreenState> emit) async {
    final failureOrLoads = await getSubcategoriesUC(event.categoryId);

    failureOrLoads.fold(
      (_) => emit(
        CategoryScreenState(errorText: 'Ошибка загрузки данных'),
      ),
      (subcategories) => emit(
        CategoryScreenState(
            errorText: null, isLoading: false, subcategories: subcategories),
      ),
    );
  }
}
