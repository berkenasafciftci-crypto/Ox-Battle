import 'package:flutter/material.dart';

import 'dictionary_screen.dart';
import 'homepage_screen.dart';
import 'profile_screen.dart';
import 'review_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _selectedIndex = 0;

  static const _screens = <Widget>[
    HomepageScreen(),
    DictionaryScreen(),
    ReviewScreen(),
    ProfileScreen(),
  ];

  static const _items = <_NavigationItem>[
    _NavigationItem(label: 'Home', icon: Icons.home_outlined),
    _NavigationItem(label: 'Dictionary', icon: Icons.menu_book_outlined),
    _NavigationItem(label: 'Review', icon: Icons.library_books_outlined),
    _NavigationItem(label: 'Me', icon: Icons.person_outline),
  ];

  void _selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 56,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE7E7E7))),
          ),
          child: Row(
            children: [
              for (var index = 0; index < _items.length; index++)
                Expanded(
                  child: _NavigationBarButton(
                    item: _items[index],
                    selected: index == _selectedIndex,
                    onTap: () => _selectIndex(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarButton extends StatelessWidget {
  const _NavigationBarButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavigationItem item;
  final bool selected;
  final VoidCallback onTap;

  static const _activeColor = Color(0xFFFF7800);
  static const _inactiveColor = Color(0xFF454B52);

  @override
  Widget build(BuildContext context) {
    final color = selected ? _activeColor : _inactiveColor;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 24, color: color),
            const SizedBox(height: 2),
            Text(
              item.label,
              maxLines: 1,
              style: TextStyle(
                color: color,
                fontFamily: 'Nunito',
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
