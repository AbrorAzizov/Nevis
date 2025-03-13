import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/usecases/orders/get_order_history.dart';
import 'package:nevis/features/presentation/bloc/order_screen/order_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/orders/order_screen.dart';

part 'orders_screen_event.dart';
part 'orders_screen_state.dart';

class OrdersScreenBloc extends Bloc<OrdersScreenEvent, OrdersScreenState> {
  final GetOrderHistoryUC getOrderHistoryUC;
  List<OrderEntity> _allOrders = []; 

  OrdersScreenBloc({required this.getOrderHistoryUC})
      : super(OrdersScreenIsLoading()) {
    on<LoadDataEvent>(_onLoadData);
    on<SearchOrderEvent>(_onSearchOrder);
    on<ShowAllLoadedOrdersEvent>(_onShowAllLoadedOrders);
  }

  void _onLoadData(LoadDataEvent event, Emitter<OrdersScreenState> emit) async {
    emit(OrdersScreenIsLoading());

    final failureOrLoads = await getOrderHistoryUC();
    failureOrLoads.fold(
      (_) => emit(OrdersScreenError(error: 'Ошибка загрузки данных')),
      (history) {
        _allOrders = history; // Сохраняем оригинальный список заказов
        emit(OrdersScreenLoaddedSuccesfully(orders: _allOrders));
      },
    );
  }

  void _onSearchOrder(
      SearchOrderEvent event, Emitter<OrdersScreenState> emit) {
    final query = event.query.replaceAll(RegExp(r'[^0-9]'), '');

    if (query.isEmpty) {
      emit(OrdersScreenLoaddedSuccesfully(orders: _allOrders));
    } else {
      final results = _allOrders
          .where((item) => item.orderId.toString().contains(query))
          .toList();
      if(results.isNotEmpty){
         emit(OrdersScreenLoaddedSuccesfully(orders: results));
      }  
      else{
        emit(OrdersScreenNoMatches());
      }
    }
      }

       void _onShowAllLoadedOrders(ShowAllLoadedOrdersEvent event, Emitter<OrdersScreenState> emit) async {

          emit(OrdersScreenLoaddedSuccesfully(orders: _allOrders));

  } 
      }