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
    return SizedBox(
      width: 320,
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
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: SizedBox(
              width: 16,
              height: 16,
              child: Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: const Offset(0, 1),
                  child: CustomPaint(
                    size: const Size(16, 16),
                    painter: _SearchIconPainter(),
                  ),
                ),
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
  }

  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  );
}

class _SearchIconPainter extends CustomPainter {
  const _SearchIconPainter();

  static const _iconColor = Color(0xFF7D8388);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _iconColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(const Offset(6.5, 6.5), 4.5, paint);
    canvas.drawLine(const Offset(10, 10), const Offset(14, 14), paint);
  }

  @override
  bool shouldRepaint(covariant _SearchIconPainter oldDelegate) => false;
}
