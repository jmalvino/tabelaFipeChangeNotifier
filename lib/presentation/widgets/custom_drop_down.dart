import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final bool isExpanded;
  final ButtonStyleData buttonStyleData;
  final DropdownStyleData dropdownStyleData;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.isExpanded = true,
    required this.buttonStyleData,
    required this.dropdownStyleData,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      value: value,
      hint: Text(
        hint,
        style: const TextStyle(color: Colors.white),
      ),
      isExpanded: isExpanded,
      buttonStyleData: buttonStyleData,
      dropdownStyleData: dropdownStyleData,
      items: items,
      onChanged: onChanged,
    );
  }
}
