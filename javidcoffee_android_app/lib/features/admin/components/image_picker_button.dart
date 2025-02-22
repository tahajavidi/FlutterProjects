import 'package:flutter/material.dart';

class ImagePickerButton extends StatelessWidget {
  final void Function() pickImages;
  const ImagePickerButton({super.key, required this.pickImages});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: pickImages,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.primaryContainer,
      height: 52,
      minWidth: 130,
      child: Text(
        "انتخاب تصویر",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
