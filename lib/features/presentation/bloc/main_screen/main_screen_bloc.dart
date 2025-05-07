import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/banner_entity.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/category/get_categories.dart';
import 'package:nevis/features/domain/usecases/content/get_banners.dart';
import 'package:nevis/features/domain/usecases/products/get_daily_products.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final GetBannersUC getBannersUC;
  final GetCategoriesUC getCategoriesUC;
  final GetDailyProductsUC getDailyProductsUC;

  MainScreenBloc({
    required this.getBannersUC,
    required this.getCategoriesUC,
    required this.getDailyProductsUC,
  }) : super(MainScreenState()) {
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(LoadDataEvent event, Emitter<MainScreenState> emit) async {
    List<BannerEntity> banners = [];
    List<CategoryEntity> categories = [];
    List<ProductEntity> daily = [];

    var data = await Future.wait(
      [
        // getBannersUC(),
        getCategoriesUC(),
        // getDailyProductsUC(),
      ],
    );

    data.forEachIndexed(
      (index, element) {
        element.fold(
          (_) {},
          (result) => switch (index) {
            // 0 => banners = result as List<BannerEntity>,
            1 => categories = result,
            // 2 => daily = result as List<ProductEntity>,
            _ => {},
          },
        );
      },
    );

    emit(
      MainScreenState(
          isLoading: false,
          banners: banners,
          categories: categories,
          daily: daily),
    );
  }
}
