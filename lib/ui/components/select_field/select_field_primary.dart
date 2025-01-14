import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';
import 'package:tisaneconnect/app/color.dart';

class CustomSelectField extends StatefulWidget {
  final String hint;
  final List<Option<String>> options;
  final ValueChanged<Option<String>> onOptionSelected;
  final Option<String>? initialOption;

  const CustomSelectField({
    Key? key,
    required this.hint,
    required this.options,
    required this.onOptionSelected,
    this.initialOption,
  }) : super(key: key);

  @override
  _CustomSelectFieldState createState() => _CustomSelectFieldState();
}

class _CustomSelectFieldState extends State<CustomSelectField> {
  Option<String>? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    return SelectField<String>(
      key: widget.key,
      options: widget.options,
      hint: widget.hint,
      initialOption: selectedOption,
      onOptionSelected: (option) {
        setState(() {
          selectedOption = option;
        });
        widget.onOptionSelected(option);
      },
      inputStyle: const TextStyle(fontSize: 16),
      menuDecoration: MenuDecoration(
        textStyle: TextStyle(),
        backgroundDecoration: BoxDecoration(
          color: ColorAssets.background,
        ),
      ),
    );
  }
}
