import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    this.hintText = 'Search',
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  static const _textColor = Color(0xFF7D8388);
  static const _backgroundColor = Color(0xFFF4F4F5);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth < 320 ? constraints.maxWidth : 320.0;

        return SizedBox(
          width: width,
          height: 40,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            textInputAction: TextInputAction.search,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _textColor,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _textColor,
              ),
              filled: true,
              fillColor: _backgroundColor,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 16, right: 8),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: Image(
                    image: AssetImage('assets/images/figma/search.png'),
                    width: 16,
                    height: 16,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                maxWidth: 40,
                minHeight: 40,
                maxHeight: 40,
              ),
              border: _border,
              enabledBorder: _border,
              focusedBorder: _border,
            ),
          ),
        );
      },
    );
  }

  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  );
}
