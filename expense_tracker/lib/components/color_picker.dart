import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CategoryColorDialog extends StatefulWidget {
  final Color initialColor;
  const CategoryColorDialog({super.key, required this.initialColor});

  @override
  State<CategoryColorDialog> createState() => _CategoryColorDialogState();
}

class _CategoryColorDialogState extends State<CategoryColorDialog> {
  late Color pickerColor;
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    pickerColor = widget.initialColor;
    currentColor = widget.initialColor;
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Got it'),
          onPressed: () {
            setState(() => currentColor = pickerColor);
            Navigator.of(context).pop(currentColor);
          },
        ),
      ],
    );
  }
}
