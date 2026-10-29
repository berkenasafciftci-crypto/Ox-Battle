import 'package:flutter/material.dart';

class AvatarPickerButton extends StatelessWidget {
  const AvatarPickerButton({
    super.key,
    required this.avatarAssetPath,
    required this.onTap,
    this.size = 90,
  });

  final String avatarAssetPath;
  final VoidCallback onTap;
  final double size;

  static const _editBadgeColor = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    final badgeSize = size * 0.24;

    return Semantics(
      button: true,
      label: 'Change avatar',
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipOval(
                child: AvatarPortrait(
                  avatarAssetPath: avatarAssetPath,
                  size: size,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 1,
                child: Container(
                  width: badgeSize,
                  height: badgeSize,
                  decoration: const BoxDecoration(
                    color: _editBadgeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: badgeSize * 0.62,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvatarPortrait extends StatelessWidget {
  const AvatarPortrait({
    super.key,
    required this.avatarAssetPath,
    required this.size,
  });

  final String avatarAssetPath;
  final double size;

  static const _placeholderColors = <Color>[
    Color(0xFFFFD66B),
    Color(0xFFFFC56E),
    Color(0xFF55C4E8),
    Color(0xFF4AA4C8),
    Color(0xFF9B7B73),
    Color(0xFFFFA34A),
    Color(0xFFFFB74D),
    Color(0xFF36B6D7),
    Color(0xFFEF684A),
  ];

  @override
  Widget build(BuildContext context) {
    if (avatarAssetPath.startsWith('placeholder-avatar-')) {
      final index = int.tryParse(avatarAssetPath.split('-').last) ?? 1;
      final color = _placeholderColors[(index - 1) % _placeholderColors.length];

      return SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(
            Icons.person,
            size: size * 0.72,
            color: const Color(0xFF263238),
          ),
        ),
      );
    }

    return Image.asset(
      avatarAssetPath,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}
