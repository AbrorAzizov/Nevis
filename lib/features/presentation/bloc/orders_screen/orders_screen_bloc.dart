import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/usecases/orders/get_order_history.dart';


part 'orders_screen_event.dart';
part 'orders_screen_state.dart';

class OrdersScreenBloc extends Bloc<OrdersScreenEvent, OrdersScreenState> {
  final GetOrderHistoryUC getOrderHistoryUC;

  TextEditingController startDateController =
      TextEditingController(text: '23 / 08 / 2024');
  TextEditingController endDateController =
      TextEditingController(text: '30 / 08 / 2024');

  OrdersScreenBloc({required this.getOrderHistoryUC})
      : super(
          OrdersScreenState(
            isOnlyActive: false,
            typesReceiving: ['Доставка', 'Самовывоз'],
            selectedTypesReceivingIds: {},
            selectedStatuses: {},
          ),
        ) {
    on<LoadDataEvent>(_onLoadData);
    on<ChangeOnlyActiveOrdersEvent>(_onChangeOnlyActiveOrdersEvent);
    on<SelectTypeReceivingEvent>(_onSelectTypeReceivingEvent);
    on<SelectStatusEvent>(_onSelectStatusEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
    on<ApplyFiltersEvent>(_onApplyFilters);
    on<ClearFilterEvent>(_onClearEvent);
  }

  void _onLoadData(LoadDataEvent event, Emitter<OrdersScreenState> emit) async {
    final failureOrLoads = await getOrderHistoryUC();

    failureOrLoads.fold(
      (_) => emit(
        state.copyWith(isLoading: false, error: 'Ошибка загрузки данных'),
      ),
      (history) => emit(
        state.copyWith(
            error: null,
            isLoading: false,
            orders: history,
            filteredOrders: history),
      ),
    );
  }

  void _onChangeOnlyActiveOrdersEvent(
      ChangeOnlyActiveOrdersEvent event, Emitter<OrdersScreenState> emit) {
    emit(state.copyWith(isOnlyActive: event.isChecked));
  }

  void _onSelectTypeReceivingEvent(
      SelectTypeReceivingEvent event, Emitter<OrdersScreenState> emit) {
    final updatedTypesReceivingIds =
        Set<int>.from(state.selectedTypesReceivingIds!);
    if (event.isChecked == true) {
      updatedTypesReceivingIds.add(event.typeReceivingId);
    } else {
      updatedTypesReceivingIds.remove(event.typeReceivingId);
    }
    emit(state.copyWith(selectedTypesReceivingIds: updatedTypesReceivingIds));
  }

  void _onSelectStatusEvent(
      SelectStatusEvent event, Emitter<OrdersScreenState> emit) {
    final updatedStatusesIds = Set<OrderStatus>.from(state.selectedStatuses!);
    if (event.isChecked == true) {
      updatedStatusesIds.add(event.status);
    } else {
      updatedStatusesIds.remove(event.status);
    }
    emit(state.copyWith(selectedStatuses: updatedStatusesIds));
  }

  void _onSelectDateEvent(
      SelectDateEvent event, Emitter<OrdersScreenState> emit) {
    emit(state.copyWith());
  }

  void _onApplyFilters(
      ApplyFiltersEvent event, Emitter<OrdersScreenState> emit) {
    List<OrderEntity> filteredOrders = List.of(state.orders ?? []);

    if (state.selectedStatuses!.isNotEmpty) {
      filteredOrders = filteredOrders
          .where(
            (e) => state.selectedStatuses!.contains(e.status),
          )
          .toList();
    }

    if (state.selectedTypesReceivingIds!.isNotEmpty) {
      filteredOrders = filteredOrders
          .where(
            (e) => state.selectedTypesReceivingIds!.contains(
              state.typesReceiving!.indexOf(e.deliveryTitle == 'Самовывоз'
                  ? e.deliveryTitle!
                  : 'Доставка'),
            ),
          )
          .toList();
    }

    DateTime? startDate =
        DateFormat('dd / MM / yyyy').tryParse(startDateController.text);
    DateTime? endDate =
        DateFormat('dd / MM / yyyy').tryParse(endDateController.text);

    if (startDate != null && endDate != null) {
      endDate =
          endDate.add(Duration(days: 1)).subtract(Duration(milliseconds: 1));
      filteredOrders = filteredOrders
          .where((e) =>
              e.createdAt!.isAfter(startDate) &&
              e.createdAt!.isBefore(endDate!))
          .toList();
    }

    emit(
      state.copyWith(filteredOrders: filteredOrders),
    );
  }

  void _onClearEvent(ClearFilterEvent event, Emitter<OrdersScreenState> emit) {
    startDateController = TextEditingController(text: '23 / 08 / 2024');
    endDateController = TextEditingController(text: '30 / 08 / 2024');
    emit(state.copyWith(
      selectedTypesReceivingIds: {},
      selectedStatuses: {},
    ));
  }
}
