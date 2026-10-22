import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.imagePath, required this.title});

  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
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

  Widget _buildImageFallback(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return const ColoredBox(
      color: Color(0xFFF0F2F5),
      child: Center(
        child: Icon(Icons.image_outlined, color: Color(0xFF9AA0A6), size: 24),
      ),
    );
  }
}
