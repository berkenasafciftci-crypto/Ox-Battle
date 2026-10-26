import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.isHorizontal = false,
    this.onTap,
  });

  final String imagePath;
  final String title;
  final bool isHorizontal;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _buildHorizontalCard();
    }

    final uri = Uri.tryParse(imagePath);
    final imageProvider =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https')
        ? Image.network(
            imagePath,
            width: 68,
            height: 71,
            fit: BoxFit.cover,
            errorBuilder: _buildImageFallback,
          )
        : Image.asset(
            imagePath,
            width: 68,
            height: 71,
            fit: BoxFit.cover,
            errorBuilder: _buildImageFallback,
          );

    return SizedBox(
      width: 68,
      height: 102,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: imageProvider,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 68,
            height: 21,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontFamily: 'Nunito', fontSize: 12),
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
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: _buildImageFallback,
          )
        : Image.asset(
            imagePath,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: _buildImageFallback,
          );

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF263038),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFE7E7E7)),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(6), child: image),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
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
    final imageSize = isHorizontal ? 56.0 : 68.0;
    final imageHeight = isHorizontal ? 56.0 : 71.0;

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
