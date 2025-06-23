import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nevis/core/geocoder_manager.dart';
import 'package:nevis/features/presentation/widgets/city_search_field.dart';
import 'package:nevis/locator_service.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class PickAddressWithSuggestionsField extends StatefulWidget {
  final String? value;
  final TextEditingController addressController;
  final String title;
  final String hintText;
  final bool hasSearchWidget;
  final Function(GeoObject? geoObject)? onPickSuggestionObject;

  const PickAddressWithSuggestionsField(
      {super.key,
      this.value,
      required this.addressController,
      this.title = 'Адрес',
      this.hintText = 'Выбрать адрес на карте',
      this.hasSearchWidget = true,
      this.onPickSuggestionObject});

  @override
  State<PickAddressWithSuggestionsField> createState() =>
      _PickAddressWithSuggestionsFieldState();
}

class _PickAddressWithSuggestionsFieldState
    extends State<PickAddressWithSuggestionsField> {
  late List<String> suggestions;
  List<GeoObject?>? suggestionObjects;
  Timer? debounce;

  @override
  void initState() {
    widget.addressController.addListener(scrollToEnd);
    suggestions = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CitySearchField(
      hasSearchWidget: widget.hasSearchWidget,
      hintText: widget.hintText,
      value: widget.value,
      controller: widget.addressController,
      title: widget.title,
      suggestions: suggestions,
      suggestionObjects: suggestionObjects,
      suggestionFetcher: (query) async {
        debounce?.cancel();

        final completer = Completer<List<String>>();

        if (query.length < 3) {
          return completer.future;
        }

        debounce = Timer(Duration(milliseconds: 1500), () async {
          final geocoderManager = sl<GeocoderManager>();
          GeocodeResponse? response =
              await geocoderManager.getGeocodeFromAddress(query);

          suggestionObjects = response
                  ?.response?.geoObjectCollection?.featureMember
                  ?.map((e) => e.geoObject)
                  .toList() ??
              [];

          // Извлекаем все адреса из ответа
          List<String> addresses = suggestionObjects!
              .map((e) =>
                  e?.metaDataProperty?.geocoderMetaData?.address?.formatted ??
                  '')
              .where((address) => address.isNotEmpty)
              .toList();

          setState(() {
            suggestions = addresses;
          });

          completer.complete(addresses);
        });
        return completer.future;
      },
      onSuggestionTap: (p0) {
        widget.onPickSuggestionObject?.call(p0);
      },
    );
  }

  void scrollToEnd() {
    widget.addressController.selection =
        TextSelection.collapsed(offset: widget.addressController.text.length);
  }

  @override
  void dispose() {
    widget.addressController.removeListener(scrollToEnd);
    super.dispose();
  }
}
