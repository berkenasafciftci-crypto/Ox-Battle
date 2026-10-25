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

  static const _foregroundColor = Color(0xFF7D8388);

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
          color: _foregroundColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _foregroundColor,
          ),
          filled: true,
          fillColor: const Color(0xFFF4F4F5),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 16, right: 8),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CustomPaint(painter: _SearchIconPainter()),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            maxWidth: 40,
            minHeight: 40,
            maxHeight: 40,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _SearchIconPainter extends CustomPainter {
  const _SearchIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7D8388)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(const Offset(6.5, 6.5), 4.5, paint);
    canvas.drawLine(const Offset(10, 10), const Offset(14, 14), paint);
  }

  @override
  bool shouldRepaint(covariant _SearchIconPainter oldDelegate) => false;
}
