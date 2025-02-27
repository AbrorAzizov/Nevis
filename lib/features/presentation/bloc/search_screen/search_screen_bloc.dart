import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  TextEditingController searchController = TextEditingController();
  TextEditingController minValueController = TextEditingController();
  TextEditingController maxValueController = TextEditingController();

  FocusNode focusNode = FocusNode();

  SearchScreenBloc()
      : super(
          SearchScreenState(
            minAllowedPrice: 0,
            maxAllowedPrice: 50,
            minSelectedPrice: 0,
            maxSelectedPrice: 50,
            releaseForms: [
              'Гранулы',
              'Гранулы для приема внутрь',
              'Капли',
              'Суппозитории'
            ],
            selectedReleaseFormsId: {},
            manufacturers: [
              'Белмедпрепараты',
              'Зеленая Дубрава',
              'Нижфарм',
              'Рубикон',
              'Рускерн',
              'Bayer'
            ],
            selectedManufacturersId: {},
            countries: ['Беларусь', 'Германия', 'Индия', 'Россия'],
            selectedCountriesId: {},
            isWithoutPrescription: false,
            isParticipatesInCampaign: false,
            isDeliveryPossible: false,
            isExpanded: false,
            query: '',
            suggestions: [
              'Терафлю',
              'Виши',
              'Солгар',
              'Термометр',
              'Хлоргексидина биклюконат',
              'Биодерма',
              'Ля Рош Позе',
              'Урьяж'
            ],
          ),
        ) {
    on<ChangePriceEvent>(_onChangePrice);
    on<SelectReleaseFormEvent>(_onSelectReleaseForm);
    on<SelectManufacturerEvent>(_onSelectManufacturer);
    on<SelectCountryEvent>(_onSelectCountry);
    on<ToggleWithoutPrescriptionEvent>(_onToggleWithoutPrescription);
    on<ToggleParticipatesInCampaignEvent>(_onToggleParticipatesInCampaign);
    on<ToggleDeliveryPossibleEvent>(_onToggleDeliveryPossible);
    on<ClearEvent>(_onClear);
    on<ToggleExpandCollapseEvent>(_onToggleExpandCollapse);
    on<ClearQueryEvent>(_onClearQuery);
    on<ChangeQueryEvent>(_onChangeQuery);
    on<SelectSuggestionsEvent>(_onSelectSuggestions);

    minValueController.text = '0';
    maxValueController.text = '50';
  }

  void _onChangeQuery(ChangeQueryEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(query: event.text));
  }

  void _onSelectSuggestions(
      SelectSuggestionsEvent event, Emitter<SearchScreenState> emit) {
    searchController.clear();
    emit(state.copyWith(isExpanded: false, query: ''));
  }

  void _onClearQuery(ClearQueryEvent event, Emitter<SearchScreenState> emit) {
    searchController.clear();
    emit(state.copyWith(isExpanded: false, query: ''));
  }

  void _onToggleExpandCollapse(
      ToggleExpandCollapseEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(isExpanded: event.isExpanded));
  }

  void _onChangePrice(ChangePriceEvent event, Emitter<SearchScreenState> emit) {
    if (event.newPrice == null) return;

    // Ограничиваем цену в рамках допустимых значений
    final clampedPrice =
        event.newPrice!.clamp(state.minAllowedPrice, state.maxAllowedPrice);

    if (event.isMinPrice == true) {
      minValueController.text = clampedPrice.round().toString();
      emit(state.copyWith(minSelectedPrice: clampedPrice));
    } else {
      maxValueController.text = clampedPrice.round().toString();
      emit(state.copyWith(maxSelectedPrice: clampedPrice));
    }
  }

  void _onSelectReleaseForm(
      SelectReleaseFormEvent event, Emitter<SearchScreenState> emit) {
    final updatedReleaseForms = Set<int>.from(state.selectedReleaseFormsId);
    if (event.isChecked == true) {
      updatedReleaseForms.add(event.releaseFormId);
    } else {
      updatedReleaseForms.remove(event.releaseFormId);
    }
    emit(state.copyWith(selectedReleaseFormsId: updatedReleaseForms));
  }

  void _onSelectManufacturer(
      SelectManufacturerEvent event, Emitter<SearchScreenState> emit) {
    final updatedManufacturers = Set<int>.from(state.selectedManufacturersId);
    if (event.isChecked == true) {
      updatedManufacturers.add(event.manufacturerId);
    } else {
      updatedManufacturers.remove(event.manufacturerId);
    }
    emit(state.copyWith(selectedManufacturersId: updatedManufacturers));
  }

  void _onSelectCountry(
      SelectCountryEvent event, Emitter<SearchScreenState> emit) {
    final updatedCountries = Set<int>.from(state.selectedCountriesId);
    if (event.isChecked == true) {
      updatedCountries.add(event.countryId);
    } else {
      updatedCountries.remove(event.countryId);
    }
    emit(state.copyWith(selectedCountriesId: updatedCountries));
  }

  void _onToggleWithoutPrescription(
      ToggleWithoutPrescriptionEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(isWithoutPrescription: event.isWithoutPrescription));
  }

  void _onToggleParticipatesInCampaign(ToggleParticipatesInCampaignEvent event,
      Emitter<SearchScreenState> emit) {
    emit(state.copyWith(
        isParticipatesInCampaign: event.isParticipatesInCampaign));
  }

  void _onToggleDeliveryPossible(
      ToggleDeliveryPossibleEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(isDeliveryPossible: event.isDeliveryPossible));
  }

  void _onClear(ClearEvent event, Emitter<SearchScreenState> emit) {
    minValueController.text = '0';
    maxValueController.text = '50';
    emit(
      state.copyWith(
          selectedCountriesId: {},
          selectedManufacturersId: {},
          selectedReleaseFormsId: {},
          isDeliveryPossible: false,
          isParticipatesInCampaign: false,
          isWithoutPrescription: false,
          minSelectedPrice: 0,
          maxSelectedPrice: 50),
    );
  }

  @override
  Future<void> close() {
    // Clean up the controller and focus node when the bloc is closed
    minValueController.dispose();
    maxValueController.dispose();

    return super.close();
  }
}
