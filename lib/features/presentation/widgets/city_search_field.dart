import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

typedef SuggestionFetcher = Future<List<String>> Function(String query);

class CitySearchField extends StatefulWidget {
  const CitySearchField({
    super.key,
    this.value,
    required this.controller,
    this.suggestions,
    this.suggestionFetcher,
    this.suggestionObjects,
    this.hintText,
    this.title,
    this.onSuggestionTap,
    this.onChangeField,
    this.hasSearchWidget = true,
    this.widthOverlay,
    this.validator,
    this.offset = const Offset(0, 55),
  }) : assert(
            suggestions != null ||
                suggestionFetcher != null && suggestionObjects != null,
            'Either suggestions or suggestionFetcher and suggestionObjects must be provided');

  final String? value;
  final TextEditingController controller;
  final List<String>? suggestions;
  final SuggestionFetcher? suggestionFetcher;
  final List<dynamic>? suggestionObjects;
  final String? hintText;
  final String? title;
  final Function(dynamic)? onSuggestionTap;
  final Function(String)? onChangeField;
  final bool hasSearchWidget;
  final double? widthOverlay;
  final Offset offset;
  final String? Function(String?)? validator;

  @override
  State<CitySearchField> createState() => _CitySearchFieldState();
}

class _CitySearchFieldState extends State<CitySearchField> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<String> _filteredSuggestions = [];
  bool _isLoading = false;
  final FocusNode _focusNode = FocusNode();

  void _showOverlay() {
    if (!_focusNode.hasFocus) return;
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: widget.widthOverlay ?? MediaQuery.of(context).size.width - 40.w,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: widget.offset,
          child: Material(
            color: UiConstants.whiteColor,
            elevation: 1,
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              height: _filteredSuggestions.isNotEmpty ? 115.h : 0,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _filteredSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: getMarginOrPadding(
                              left: 16, right: 16, top: 8, bottom: 8),
                          minTileHeight: 0,
                          minVerticalPadding: 0,
                          title: Text(_filteredSuggestions[index]),
                          onTap: () {
                            widget.controller.text =
                                _filteredSuggestions[index];
                            _removeOverlay();
                            if (widget.onSuggestionTap != null) {
                              dynamic onSuggestionSelected =
                                  widget.suggestionObjects != null
                                      ? widget.suggestionObjects![index]
                                      : _filteredSuggestions[index];

                              widget.onSuggestionTap
                                  ?.call(onSuggestionSelected);
                            }
                          },
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<void> _updateSuggestions(String query) async {
    if (query.isEmpty) {
      _removeOverlay();
      setState(() {
        _filteredSuggestions.clear();
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (widget.suggestionFetcher != null) {
      // Динамическая загрузка подсказок
      final suggestions = await widget.suggestionFetcher!(query);
      setState(() {
        _filteredSuggestions = suggestions;
        _isLoading = false;
      });
    } else {
      // Фиксированный список
      setState(() {
        _filteredSuggestions = (widget.suggestions ?? [])
            .where((city) => city.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _isLoading = false;
      });
    }

    if (_filteredSuggestions.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 100), () {
          _removeOverlay();
        });
      }
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: AppTextFieldWidget(
        fillColor: UiConstants.whiteColor,
        focusNode: _focusNode,
        title: widget.title,
        hintText: widget.hintText,
        controller: widget.controller,
        prefixWidget: widget.hasSearchWidget
            ? SvgPicture.asset(Paths.searchIconPath)
            : null,
        suffixWidget: widget.hasSearchWidget
            ? widget.controller.text.isNotEmpty
                ? Skeleton.ignore(
                    child: GestureDetector(
                      onTap: () {
                        widget.controller.clear();
                        _removeOverlay();
                        widget.onChangeField?.call('');
                      },
                      child: SvgPicture.asset(Paths.closeIconPath),
                    ),
                  )
                : null
            : null,
        validator: widget.validator,
        onChangedField: (value) {
          _updateSuggestions(value);
          widget.onChangeField?.call(value);
        },
      ),
    );
  }
}
