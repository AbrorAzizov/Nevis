import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';
import 'package:nevis/features/domain/entities/paginated_stories_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/loyalty_card/get_qr_code.dart';
import 'package:nevis/features/domain/usecases/stories/get_stories_usecase.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final GetStoriesUC getStoriesUC;
  final GetQRCodeUC getQRCodeUC;

  MainScreenBloc({
    required this.getStoriesUC,
    required this.getQRCodeUC,
  }) : super(
          MainScreenState(
            newProducts: List.generate(
              10,
              (index) => ProductEntity(
                  productId: 3170071,
                  name:
                      'CareFaсtor Гипоаллергенная гель-пенка д/интимной гигиены 100мл',
                  image:
                      'https://virtual-nevis-test.tw1.ru/upload/iblock/d7a/uqext541kohzcc20anqjmendp0xww02x.jpeg',
                  price: 990),
            ),
            profitableProducts: List.generate(
              10,
              (index) => ProductEntity(
                  productId: 3170071,
                  name:
                      'CareFaсtor Гипоаллергенная гель-пенка д/интимной гигиены 100мл',
                  image:
                      'https://virtual-nevis-test.tw1.ru/upload/iblock/d7a/uqext541kohzcc20anqjmendp0xww02x.jpeg',
                  price: 990),
            ),
          ),
        ) {
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(LoadDataEvent event, Emitter<MainScreenState> emit) async {
    PaginatedStoriesEntity? stories;
    LoyaltyCardQREntity? loyalCard;

    final data = await Future.wait(
      [
        getStoriesUC(0),
        getQRCodeUC()
        //getCategoriesUC(),
        // getDailyProductsUC(),
      ],
    );

    data.forEachIndexed(
      (index, element) {
        element.fold(
          (_) {},
          (result) => switch (index) {
            0 => stories = result as PaginatedStoriesEntity?,
            1 => loyalCard = result as LoyaltyCardQREntity?,
            _ => {},
          },
        );
      },
    );

    emit(state.copyWith(
        isLoading: false, stories: stories, loyalCard: loyalCard));
  }
}
