// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../resources/colors.dart';

List<String> items = [
  'Ram',
  'Shyam',
  'Har',
  'Ram1222222222222',
];

class CustomDropdownFormField<T> extends StatelessWidget {
  // final List<String>? items;
  final String? value;
  void Function(String?)? onChanged;
  final String Function(String)? displayText;
  final String? hintText;
  final InputDecoration? decoration;
  final OutlineInputBorder? border;
  final String? hint;
  final bool? isFilled;
  final double? height;

  final String? label;

  CustomDropdownFormField({
    super.key,
    // this.items,
    this.value,
    this.onChanged,
    this.displayText,
    this.hintText,
    this.decoration,
    this.label,
    this.border,
    this.height,
    this.isFilled = false,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Text(label!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
        if (label != null) SizedBox(height: 5),
        SizedBox(
          height: height ?? 30,
          child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.arrow_drop_down_rounded,
            ),
            iconSize: 30,
            itemHeight: 50,
            borderRadius: BorderRadius.circular(10),
            value: items.first,
            dropdownColor: Colors.white,
            items: items
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(),
                        overflow: TextOverflow.visible,
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white38.withOpacity(0.5),
              contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              hintText: hintText ?? 'Select an item',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 2.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: secondaryColor,
                  width: 2.0,
                ),
              ),
              focusColor: secondaryColor,
            ),
          )),
        ),
      ],
    );
  }
}
