import 'package:flutter/material.dart';

import '../widgets/avatar_picker_card.dart';
import '../widgets/study_progress.dart';
import 'avatar_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _placeholderAvatars = <String>[
    'placeholder-avatar-1',
    'placeholder-avatar-2',
    'placeholder-avatar-3',
    'placeholder-avatar-4',
    'placeholder-avatar-5',
    'placeholder-avatar-6',
    'placeholder-avatar-7',
    'placeholder-avatar-8',
    'placeholder-avatar-9',
  ];

  static const _weekdays = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  String _avatarAssetPath = _placeholderAvatars.first;

  Future<void> _openAvatarPicker() async {
    final selectedAvatar = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AvatarPickerSheet(
        avatarAssetPaths: _placeholderAvatars,
        initialAvatarPath: _avatarAssetPath,
      ),
    );

    if (selectedAvatar != null && mounted) {
      setState(() {
        _avatarAssetPath = selectedAvatar;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarPickerButton(
                      avatarAssetPath: _avatarAssetPath,
                      onTap: _openAvatarPicker,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.workspace_premium,
                          color: Color(0xFFFE9519),
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Sena Berken',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: const Color(0xFF1C1C1C),
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 136,
                child: StudyProgressCard(progressSize: 88),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Scoreboard',
                      style: TextStyle(
                        color: Color(0xFF1C1C1C),
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 126,
                      padding: const EdgeInsets.fromLTRB(10, 28, 10, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE0E2E8)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: List.generate(
                              8,
                              (index) => Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: index == 7 ? 0 : 7,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFE0E2E8),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: Color(0xFF45CFA0),
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '5',
                                  style: TextStyle(
                                    color: Color(0xFF45CFA0),
                                    fontFamily: 'Nunito',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Days learned',
                      style: TextStyle(
                        color: Color(0xFF1C1C1C),
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: List.generate(_weekdays.length, (index) {
                        final learned = index == 3 || index == 6;

                        return Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: learned
                                      ? const Color(0xFF4A83F2)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: learned
                                      ? null
                                      : Border.all(
                                          color: const Color(0xFFE8EAED),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _weekdays[index],
                                style: TextStyle(
                                  color: learned
                                      ? const Color(0xFF1C1C1C)
                                      : const Color(0xFF9AA0A6),
                                  fontFamily: 'Nunito',
                                  fontSize: 10,
                                  fontWeight: learned
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
