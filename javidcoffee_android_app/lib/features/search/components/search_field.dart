import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SearchField extends StatelessWidget {
  final void Function()? onTap;

  const SearchField({
    super.key,
   required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [const FadeEffect(delay: Duration(milliseconds: 100))],
      child: TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        readOnly: true,
        autocorrect: true,
        autofocus: true,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          hintText: "جستجو...",
          hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        onTap: onTap,
      ),
    );
  }
}
