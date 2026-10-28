import 'package:flutter/material.dart';

import 'competetion_screen.dart';
import 'dictionary_screen.dart';
import 'homepage_screen.dart';
import 'level_screen.dart';
import 'profile_screen.dart';
import 'review_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final _homeNavigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;
  bool _isCompetitionScreen = false;

  late final _HomeNavigatorObserver _homeNavigatorObserver =
      _HomeNavigatorObserver((routeName) {
        final isCompetition = routeName == CompetitionScreen.routeName;
        if (mounted && _isCompetitionScreen != isCompetition) {
          setState(() {
            _isCompetitionScreen = isCompetition;
          });
        }
      });

  static const _items = <_NavigationItem>[
    _NavigationItem(
      label: 'Home',
      selectedAsset: 'assets/images/figma/nav_home_active.png',
      unselectedAsset: 'assets/images/figma/nav_home_inactive.png',
    ),
    _NavigationItem(
      label: 'Dictionary',
      selectedAsset: 'assets/images/figma/nav_dictionary_active.png',
      unselectedAsset: 'assets/images/figma/nav_dictionary_inactive.png',
    ),
    _NavigationItem(
      label: 'Review',
      selectedAsset: 'assets/images/figma/nav_review_active.png',
      unselectedAsset: 'assets/images/figma/nav_review_inactive.png',
    ),
    _NavigationItem(
      label: 'Me',
      selectedAsset: 'assets/images/figma/nav_me.png',
      unselectedAsset: 'assets/images/figma/nav_me.png',
    ),
  ];

  void _selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openLevelScreen(String categoryTitle) {
    _homeNavigatorKey.currentState!.push(
      MaterialPageRoute<void>(
        settings: const RouteSettings(name: LevelScreen.routeName),
        builder: (context) => LevelScreen(categoryTitle: categoryTitle),
      ),
    );
  }

  Widget _buildHomeNavigator() {
    return NavigatorPopHandler<void>(
      enabled: _selectedIndex == 0,
      onPopWithResult: (_) => _homeNavigatorKey.currentState?.pop(),
      child: Navigator(
        key: _homeNavigatorKey,
        observers: [_homeNavigatorObserver],
        onGenerateRoute: (settings) => MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => HomepageScreen(onOpenLevels: _openLevelScreen),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeNavigator(),
          const DictionaryScreen(),
          const ReviewScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _isCompetitionScreen
          ? null
          : SafeArea(
              top: false,
              child: Container(
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFEAEBEC))),
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

  static const _activeColor = Color(0xFFFE9519);
  static const _inactiveColor = Color(0xFF41474D);

  @override
  Widget build(BuildContext context) {
    final color = selected ? _activeColor : _inactiveColor;
    final icon = Image.asset(
      selected ? item.selectedAsset : item.unselectedAsset,
      width: 24,
      height: 24,
    );

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            item.label == 'Me' && selected
                ? ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      _activeColor,
                      BlendMode.srcIn,
                    ),
                    child: icon,
                  )
                : icon,
            const SizedBox(height: 2),
            Text(
              item.label,
              maxLines: 1,
              style: TextStyle(
                color: color,
                fontFamily: 'Nunito',
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem({
    required this.label,
    required this.selectedAsset,
    required this.unselectedAsset,
  });

  final String label;
  final String selectedAsset;
  final String unselectedAsset;
}

class _HomeNavigatorObserver extends NavigatorObserver {
  _HomeNavigatorObserver(this.onTopRouteChanged);

  final ValueChanged<String?> onTopRouteChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onTopRouteChanged(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onTopRouteChanged(previousRoute?.settings.name);
  }
}
