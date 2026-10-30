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
  static const _figmaAvatar = 'assets/images/figma/profile_avatar.png';

  static const _avatarOptions = <String>[
    _figmaAvatar,
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

  String _avatarAssetPath = _figmaAvatar;

  Future<void> _openAvatarPicker() async {
    final selectedAvatar = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AvatarPickerSheet(
        avatarAssetPaths: _avatarOptions,
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
      backgroundColor: const Color(0xFFF8F8F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 18),
              SizedBox(
                height: 172,
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFE9519),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/figma/profile_crown.png',
                                width: 13.5,
                                height: 13.5,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Sena Berken',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 147,
                child: Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: StudyProgressCard(textLeft: 28),
                ),
              ),
              const SizedBox(height: 18),
              const _ScoreboardCard(),
              const SizedBox(height: 10),
              const _DaysLearnedCard(weekdays: _weekdays),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreboardCard extends StatelessWidget {
  const _ScoreboardCard();

  static const _tileBorder = Color(0xFFDFDEE4);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 204,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 20,
            top: 16,
            child: Text(
              'Scoreboard',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 26,
            top: 55,
            height: 135,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: _tileBorder, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 12,
                    right: 10,
                    top: 39,
                    height: 34,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        7,
                        (index) => SizedBox(
                          width: 34,
                          height: 34,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: _tileBorder, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    top: 107,
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Color(0xFF05A660),
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '5',
                          style: TextStyle(
                            color: Color(0xFF05A660),
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DaysLearnedCard extends StatelessWidget {
  const _DaysLearnedCard({required this.weekdays});

  final List<String> weekdays;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA8ACAF).withValues(alpha: 0.11),
              offset: const Offset(4, 0),
              blurRadius: 6,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Stack(
          children: [
            const Positioned(
              left: 20,
              top: 16,
              child: Text(
                'Days learned',
                style: TextStyle(
                  color: Color(0xFF1D1D1D),
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 55,
              width: 264,
              height: 28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(weekdays.length, (index) {
                  final learned = index == 3 || index == 6;

                  return Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: learned ? const Color(0xFF4A83F2) : Colors.white,
                      shape: BoxShape.circle,
                      border: learned
                          ? null
                          : Border.all(color: const Color(0xFFEAEBEC)),
                    ),
                  );
                }),
              ),
            ),
            Positioned(
              left: 20,
              top: 91,
              width: 290,
              height: 21,
              child: Stack(
                children: List.generate(weekdays.length, (index) {
                  final learned = index == 3 || index == 6;

                  return Positioned(
                    left: index * 40,
                    width: 50,
                    child: Center(
                      child: Text(
                        weekdays[index],
                        style: TextStyle(
                          color: learned
                              ? const Color(0xFF404040)
                              : const Color(0xFFA8ACAF),
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
