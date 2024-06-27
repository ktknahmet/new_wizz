import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/widgets/multiSelect/util/multi_select_actions.dart';
import 'package:wizzsales/widgets/multiSelect/util/multi_select_item.dart';
import 'package:wizzsales/widgets/multiSelect/util/multi_select_list_type.dart';

import '../../../constants/colorsUtil.dart';

/// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
class MultiSelectBottomSheet<V> extends StatefulWidget
    with MultiSelectActions<V> {
  /// List of items to select from.
  final List<MultiSelectItem<V>>? items;

  /// The list of selected values before interaction.
  final List<V>? initialValue;

  /// The text at the top of the BottomSheet.
  final Widget? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<V>)? onConfirm;

  final void Function(MultiSelectItem<V>)? selectedItem;

  /// Toggles search functionality.
  final bool? searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Set the initial height of the BottomSheet.
  final double? initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double? minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double? maxChildSize;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color Function(V)? colorator;

  /// Color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Icon button that shows the search field.
  final Icon? searchIcon;

  /// Icon button that hides the search field
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  MultiSelectBottomSheet({super.key,
    @required this.items,
    @required this.initialValue,
    this.title,
    this.onSelectionChanged,
    this.selectedItem,
    this.onConfirm,
    this.listType,
    this.cancelText,
    this.confirmText,
    this.searchable,
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.colorator,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHint,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.checkColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MultiSelectBottomSheetState<V> createState() =>
      // ignore: no_logic_in_create_state
      _MultiSelectBottomSheetState<V>(items ?? []);
}

class _MultiSelectBottomSheetState<V> extends State<MultiSelectBottomSheet<V>> {
  List<V> _selectedValues = [];

  final List<MultiSelectItem<V>> _items;

  _MultiSelectBottomSheetState(this._items);

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedValues.addAll(widget.initialValue!);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<V> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
        // ignore: deprecated_member_use
        hintColor: ColorUtil().getColor(context, ColorEnums.primary),
      ),
      child: ListTileTheme(
        contentPadding: const EdgeInsets.all(0),
        child: CheckboxListTile(
          dense: true,
          checkColor: widget.checkColor,
          value: _selectedValues.contains(item.value),
          activeColor: ColorUtil().getColor(context, ColorEnums.primary),
          title: Text(item.label,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (checked) {
            setState(() {
              _selectedValues = widget.onItemCheckedChange(
                  _selectedValues, item.value, checked ?? false);
            });
            if (widget.onSelectionChanged != null) {
              widget.onSelectionChanged!(_selectedValues);
            }
          },
        ),
      ),
    );
  }

  /// Returns a ChoiceChip
  Widget _buildChipItem(MultiSelectItem<V> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        selectedColor:
            widget.colorator != null
                ? widget.colorator!(item.value)
                : AppColors.wizzColor,
        label: Text(item.label,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        selected: _selectedValues.contains(item.value),
        onSelected: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked);
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
          if (widget.selectedItem != null) {
            widget.selectedItem!(item);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: widget.initialChildSize ?? 0.3,
        minChildSize: widget.minChildSize ?? 0.3,
        maxChildSize: widget.maxChildSize ?? 0.6,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: widget.title ??
                    const Text(
                      "Seç",
                      style: TextStyle(fontSize: 18),
                    ),
              ),
              Expanded(
                child: widget.listType == null ||
                        widget.listType == MultiSelectListType.list
                    ? ListView.builder(
                        controller: scrollController,
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: _buildListItem(_items[index]),
                          );
                        },
                      )
                    : SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Wrap(
                            children: _items.map(_buildChipItem).toList(),
                          ),
                        ),
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.only(left: 32, bottom: 32, right: 32),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 44,
                          child: Center(
                              child: ElevatedButton(
                                onPressed: (){
                                  widget.onCancelTap(context, widget.initialValue!);
                                },
                                child: Text("cancel".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              )
                          ),
                        )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 44,
                        child: Center(

                            child: ElevatedButton(
                              onPressed: (){
                                widget.onConfirmTap(context, _selectedValues, widget.onConfirm!);
                              },
                              child: Text("continue".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
