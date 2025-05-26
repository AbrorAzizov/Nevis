import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

part 'sale_screen_event.dart';
part 'sale_screen_state.dart';

class SaleScreenBloc extends Bloc<SaleScreenEvent, SaleScreenState> {
  SaleScreenBloc()
      : super(
          SaleScreenState(
            products: List.generate(
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
        );
}
