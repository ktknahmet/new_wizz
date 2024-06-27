import 'package:flutter/material.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import '../../../constants/colorsUtil.dart';
import '../util/horizontal_scrollbar.dart';
import '../util/multi_select_item.dart';

/// A widget meant to display selected values as chips.
// ignore: must_be_immutable
class MultiSelectChipDisplay<V> extends StatelessWidget {
  /// The source list of selected items.
  final List<MultiSelectItem<V>>? items;

  /// Fires when a chip is tapped.
  final Function(V)? onTap;

  /// Set the chip color.
  final Color? chipColor;

  /// Change the alignment of the chips.
  final Alignment? alignment;

  /// Style the Container that makes up the chip display.
  final BoxDecoration? decoration;

  /// Style the text on the chips.
  final TextStyle? textStyle;

  /// A function that sets the color of selected items based on their value.
  final Color Function(V)? colorator;

  /// An icon to display prior to the chip's label.
  final Icon? icon;

  /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
  final ShapeBorder? shape;

  /// Enables horizontal scrolling.
  final bool scroll;

  /// Enables the scrollbar when scroll is `true`.
  final HorizontalScrollBar? scrollBar;

  final ScrollController _scrollController = ScrollController();

  /// Set a fixed height.
  final double? height;

  /// Set the width of the chips.
  final double? chipWidth;

  bool? disabled;

  MultiSelectChipDisplay({super.key,
    this.items,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.colorator,
    this.icon,
    this.shape,
    this.scroll = false,
    this.scrollBar,
    this.height,
    this.chipWidth,
  }) {
    disabled = false;
  }

  MultiSelectChipDisplay.none({super.key,
    this.items = const [],
    this.disabled = true,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.colorator,
    this.icon,
    this.shape,
    this.scroll = false,
    this.scrollBar,
    this.height,
    this.chipWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (items == null || items!.isEmpty) return Container();
    return Container(
      decoration: decoration,
      alignment: alignment ?? Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: scroll ? 0 : 10),
      child: scroll
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: height ?? MediaQuery.of(context).size.height * 0.08,
              child: scrollBar != null
                  ? Scrollbar(
                      // ignore: deprecated_member_use
                      thumbVisibility: scrollBar!.isAlwaysShown,
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: items!.length,
                        itemBuilder: (ctx, index) {
                          return _buildItem(items![index], context);
                        },
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: items!.length,
                      itemBuilder: (ctx, index) {
                        return _buildItem(items![index], context);
                      },
                    ),
            )
          : Wrap(
              children: items != null
                  ? items!.map((item) => _buildItem(item, context)).toList()
                  : <Widget>[
                      Container(),
                    ],
            ),
    );
  }

  Widget _buildItem(MultiSelectItem<V> item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        label: Text(item.label,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
        selected: items!.contains(item),
        selectedColor: Colors.transparent,
        shape: StadiumBorder(side: BorderSide(color: ColorUtil().getColor(context, ColorEnums.wizzColor))),
        onSelected: (_) {
          if (onTap != null) onTap!(item.value);
        },
      ),
    );
  }
}
