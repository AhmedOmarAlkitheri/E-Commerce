import 'package:ecommerce_app_client/Core/View/homeScreen/Widget/headerScreen/CircularContainer.dart';
import 'package:ecommerce_app_client/global/constants/Colors.dart';
import 'package:ecommerce_app_client/global/function/helperFunction.dart';
import 'package:flutter/material.dart';

class customChoiceChip extends StatelessWidget {
  const customChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = Helperfunction.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? AppColor.white : null),
        avatar: isColor ? CircularContainer(width: 50, height: 50, backgroundColor: Helperfunction.getColor(text)) : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        shape: isColor ? const CircleBorder() : null,
        backgroundColor: isColor ? Helperfunction.getColor(text) : null,
      ), // ChoiceChip
    ); // Theme
  }
}