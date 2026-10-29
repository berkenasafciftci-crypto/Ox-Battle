import 'package:flutter/material.dart';

import '../widgets/avatar_picker_card.dart';
import '../widgets/primary_button.dart';

class AvatarPickerSheet extends StatefulWidget {
  const AvatarPickerSheet({
    super.key,
    required this.avatarAssetPaths,
    this.initialAvatarPath,
  });

  final List<String> avatarAssetPaths;
  final String? initialAvatarPath;

  @override
  State<AvatarPickerSheet> createState() => _AvatarPickerSheetState();
}

class _AvatarPickerSheetState extends State<AvatarPickerSheet> {
  late String? _selectedAvatarPath = widget.initialAvatarPath;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final horizontalPadding = 24.0;
    final spacing = 12.0;
    final avatarSize =
        ((screenSize.width - horizontalPadding * 2 - spacing * 2) / 3).clamp(
          0.0,
          96.0,
        );
    final rowCount = (widget.avatarAssetPaths.length / 3).ceil();
    final gridWidth = avatarSize * 3 + spacing * 2;
    final gridHeight = rowCount == 0
        ? 0.0
        : rowCount * avatarSize + (rowCount - 1) * 16;

    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.8),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: gridWidth,
                  height: gridHeight,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.avatarAssetPaths.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final assetPath = widget.avatarAssetPaths[index];
                      final isSelected = assetPath == _selectedAvatarPath;
                      return Semantics(
                        button: true,
                        selected: isSelected,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            setState(() {
                              _selectedAvatarPath = assetPath;
                            });
                          },
                          child: ClipOval(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AvatarPortrait(
                                  avatarAssetPath: assetPath,
                                  size: avatarSize,
                                ),
                                if (isSelected)
                                  const ColoredBox(color: Color(0x802563EB)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Select',
                  onPressed: () {
                    if (_selectedAvatarPath != null) {
                      Navigator.pop(context, _selectedAvatarPath);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
