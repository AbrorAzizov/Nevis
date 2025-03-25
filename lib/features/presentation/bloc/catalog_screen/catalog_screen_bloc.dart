import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/data/models/category_model.dart';
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
final categories = [
  {
    "category_id": 1,
    "parent": null,
    "pagetitle": "Средства гигиены",
    "alias": "hygiene",
    "image": "https://example.com/images/hygiene.jpg"
  },
  {
    "category_id": 2,
    "parent": 1,
    "pagetitle": "Косметика и уход",
    "alias": "cosmetic",
    "image": "https://example.com/images/cosmetic.jpg"
  },
  {
    "category_id": 3,
    "parent": 1,
    "pagetitle": "Лекарства и БАДы",
    "alias": "medicines",
    "image": "https://example.com/images/medicines.jpg"
  },
  {
    "category_id": 4,
    "parent": null,
    "pagetitle": "Мама и малыш",
    "alias": "motherAndBaby",
    "image": "https://example.com/images/mother_and_baby.jpg"
  },
  {
    "category_id": 5,
    "parent": 4,
    "pagetitle": "Медицинские приборы",
    "alias": "medicineTools",
    "image": "https://example.com/images/medicine_tools.jpg"
  },
  {
    "category_id": 6,
    "parent": null,
    "pagetitle": "Оптика",
    "alias": "optic",
    "image": "https://example.com/images/optic.jpg"
  },
  {
    "category_id": 7,
    "parent": null,
    "pagetitle": "Ортопедический салон",
    "alias": "orthopedic",
    "image": "https://example.com/images/orthopedic.jpg"
  },
  {
    "category_id": 8,
    "parent": null,
    "pagetitle": "Спорт и фитнес",
    "alias": "sport",
    "image": "https://example.com/images/sport.jpg"
  }
];

  void _onLoadCategories(
      LoadCategoriesEvent event, Emitter<CatalogScreenState> emit) async {
    // final failureOrLoads = await getCategoriesUC();

    // failureOrLoads.fold(
    //   (_) => emit(
    //     CatalogScreenState(errorText: 'Ошибка загрузки данных'),
    //   ),
    //   (categories) => emit(
    //     CatalogScreenState(
    //         errorText: null, isLoading: false, categories: categories),
    //   ),
    // );
   final categoriesList =  categories.map((e)=> CategoryModel.fromJson(e)).toList();
    emit(CatalogScreenState(
    errorText: null,
    isLoading: false,
    categories: categoriesList,
  ));
  
  }
}


