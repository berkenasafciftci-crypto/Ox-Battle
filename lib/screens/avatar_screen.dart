import 'package:flutter/material.dart';

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
    final rowCount = (widget.avatarAssetPaths.length / 3).ceil();
    final gridHeight = rowCount == 0
        ? 0.0
        : rowCount * 110.0 + (rowCount - 1) * 34.0;

    return SizedBox(
      height: screenSize.height * 0.75,
      child: Material(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: gridHeight,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.avatarAssetPaths.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 34,
                    mainAxisExtent: 110,
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
                        child: Center(
                          child: SizedBox(
                            width: 100,
                            height: 110,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  assetPath,
                                  width: 100,
                                  height: 110,
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                ),
                                if (isSelected)
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Color(0x802563EB),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PrimaryButton(
                  text: 'Select',
                  height: 40,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  onPressed: () {
                    if (_selectedAvatarPath != null) {
                      Navigator.pop(context, _selectedAvatarPath);
                    }
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
