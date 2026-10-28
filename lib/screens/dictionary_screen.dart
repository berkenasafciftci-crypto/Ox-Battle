import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import '../widgets/search_bar_widget.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  static const _categories = <({String imagePath, String title})>[
    (
      imagePath: 'assets/images/figma/dictionary_image_1.jpg',
      title: 'Kategori1',
    ),
    (
      imagePath: 'assets/images/figma/dictionary_image_1.jpg',
      title: 'Kategori2',
    ),
    (
      imagePath: 'assets/images/figma/dictionary_image_1.jpg',
      title: 'Kategori3',
    ),
    (
      imagePath: 'assets/images/figma/dictionary_image_1.jpg',
      title: 'Kategori4',
    ),
    (
      imagePath: 'assets/images/figma/dictionary_image_2.jpg',
      title: 'Kategori5',
    ),
    (
      imagePath: 'assets/images/figma/dictionary_image_2.jpg',
      title: 'Kategori6',
    ),
    (
      imagePath: 'assets/images/figma/dictionary_image_2.jpg',
      title: 'Kategori7',
    ),
    (
      imagePath: 'assets/images/figma/dictionary_image_2.jpg',
      title: 'Kategori8',
    ),
  ];

  String _searchQuery = '';

  List<({String imagePath, String title})> get _visibleCategories {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _categories;
    }

    return _categories
        .where((category) => category.title.toLowerCase().contains(query))
        .toList();
  }

  void _openCategory(String title) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => _CategoryWordsScreen(categoryTitle: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFCFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 44,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dictionary',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            color: Color(0xFF263038),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SearchBarWidget(
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final category in _visibleCategories) ...[
                    CategoryCard(
                      title: category.title,
                      imagePath: category.imagePath,
                      isHorizontal: true,
                      onTap: () => _openCategory(category.title),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryWordsScreen extends StatelessWidget {
  const _CategoryWordsScreen({required this.categoryTitle});

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF263038),
        elevation: 0,
        title: Text(
          categoryTitle,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Bu kategoriye ait kelimeler burada listelenecek.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            color: Color(0xFF7D8388),
          ),
        ),
      ),
    );
  }
}
