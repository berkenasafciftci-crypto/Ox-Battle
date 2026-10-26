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
    (imagePath: 'https://picsum.photos/seed/category1/100', title: 'Kategori1'),
    (imagePath: 'https://picsum.photos/seed/category2/100', title: 'Kategori2'),
    (imagePath: 'https://picsum.photos/seed/category3/100', title: 'Kategori3'),
    (imagePath: 'https://picsum.photos/seed/category4/100', title: 'Kategori4'),
    (imagePath: 'https://picsum.photos/seed/category5/100', title: 'Kategori5'),
    (imagePath: 'https://picsum.photos/seed/category6/100', title: 'Kategori6'),
    (imagePath: 'https://picsum.photos/seed/category7/100', title: 'Kategori7'),
    (imagePath: 'https://picsum.photos/seed/category8/100', title: 'Kategori8'),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Color(0xFF263038),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Dictionary',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263038),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth < 320
                        ? constraints.maxWidth
                        : 320,
                    child: SearchBarWidget(
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              for (final category in _visibleCategories) ...[
                CategoryCard(
                  title: category.title,
                  imagePath: category.imagePath,
                  isHorizontal: true,
                  onTap: () => _openCategory(category.title),
                ),
                const SizedBox(height: 8),
              ],
            ],
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
