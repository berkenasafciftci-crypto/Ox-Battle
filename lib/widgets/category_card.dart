import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.isHorizontal = false,
    this.onTap,
    this.width,
  });

  final String imagePath;
  final String title;
  final bool isHorizontal;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _buildHorizontalCard();
    }

    final cardWidth = width ?? 68;
    final imageHeight = cardWidth * 71 / 68;
    final labelHeight = cardWidth * 21 / 68;
    final uri = Uri.tryParse(imagePath);
    final imageProvider =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https')
        ? Image.network(
            imagePath,
            width: cardWidth,
            height: imageHeight,
            fit: BoxFit.cover,
            errorBuilder: _buildImageFallback,
          )
        : Image.asset(
            imagePath,
            width: cardWidth,
            height: imageHeight,
            fit: BoxFit.cover,
            errorBuilder: _buildImageFallback,
          );

    return SizedBox(
      width: cardWidth,
      height: cardWidth * 102 / 68,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(cardWidth * 10 / 68),
            child: imageProvider,
          ),
          SizedBox(height: cardWidth * 10 / 68),
          SizedBox(
            width: cardWidth,
            height: labelHeight,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF1C1C1C),
                  fontFamily: 'Nunito',
                  fontSize: cardWidth * 12 / 68,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCard() {
    final uri = Uri.tryParse(imagePath);
    final image = uri != null && (uri.scheme == 'http' || uri.scheme == 'https')
        ? Image.network(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: _buildImageFallback,
          )
        : Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: _buildImageFallback,
          );

    return SizedBox(
      width: double.infinity,
      height: 84,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1C1C1C),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFF3F3F5), width: 2),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(8), child: image),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageFallback(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    final imageSize = isHorizontal ? 60.0 : (width ?? 68);
    final imageHeight = isHorizontal ? 60.0 : imageSize * 71 / 68;

    return SizedBox(
      width: imageSize,
      height: imageHeight,
      child: const ColoredBox(
        color: Color(0xFFF0F2F5),
        child: Center(
          child: Icon(Icons.image_outlined, color: Color(0xFF9AA0A6), size: 24),
        ),
      ),
    );
  }
}
