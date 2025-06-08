import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

const Color kAccentGreen = Color(0xFF3FC409);

class PracticeHomeScreen extends StatefulWidget {
  const PracticeHomeScreen({super.key});

  @override
  State<PracticeHomeScreen> createState() => _PracticeHomeScreenState();
}

class _PracticeHomeScreenState extends State<PracticeHomeScreen> {
  // 🔥 MOCK DATA → reemplaza por tu lógica real
  final String userName     = 'Alejandro';
  final int streakDays      = 21;
  final double progressPts  = 520;
  final double progressGoal = 800;
  final List<bool> weekChecks = [true, true, true, true, true, true, true];

  final List<_PracticeCardData> practiceList = [
    _PracticeCardData(
      subtitle:    'A little bit of',
      titleBig:    'Technical\nPractice',
      assetPath:   'assets/img/cards.png',
      isLarge:     true,
    ),
    _PracticeCardData(
      subtitle:     'Practice',
      titleBig:     'Behavioral\nQuestions',
      counter:      '30/60 remain',
      counterColor: CupertinoColors.systemOrange,
      assetPath:    'assets/img/pencil.png',
    ),
    _PracticeCardData(
      subtitle:   'Practice',
      titleBig:   'Interview',
      assetPath:  'assets/img/avion.png',
    ),
    _PracticeCardData(
      subtitle:    'Practice',
      titleBig:    'Star Method',
      description: 'This is so\nimportant!',
      assetPath:   'assets/img/newspapper.png',
    ),
  ];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _TopBar(userName: userName),
              const SizedBox(height: 18),

              // ─── Streak container ─────────────────────
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: kAccentGreen.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.black.withOpacity(0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: _StreakSection(
                  streakDays: streakDays,
                  weekChecks: weekChecks,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'How would you like to practice today?',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.label,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Overall progress',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CupertinoColors.secondaryLabel,
                ),
              ),
              const SizedBox(height: 12),
              _ProgressBar(current: progressPts, goal: progressGoal),
              const SizedBox(height: 28),

              // ─── Bento-style Practice Grid ────────────
              _PracticeGrid(list: practiceList),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      // ─── Original bentogrid menu restored ───────
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: _BottomMenu(
              current: _selectedTab,
              onTap: (i) => setState(() => _selectedTab = i),
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── TOP BAR ─────────────────────────
class _TopBar extends StatelessWidget {
  final String userName;
  const _TopBar({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset('assets/img/avatar2.png', width: 48, height: 48),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $userName',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label,
                ),
              ),
              Text(
                'Keep practicing every day',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CupertinoColors.secondaryLabel,
                ),
              ),
            ],
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Image.asset('assets/img/bell2.png', width: 24, height: 24),
          onPressed: () {},
        ),
      ],
    );
  }
}

// ────────────────────── STREAK SECTION ─────────────────────
class _StreakSection extends StatelessWidget {
  final int streakDays;
  final List<bool> weekChecks;

  const _StreakSection({
    required this.streakDays,
    required this.weekChecks,
  });

  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$streakDays days of streak',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.label,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 36,
              height: 36,
              child: Lottie.asset('assets/lottie/fire.json'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (i) {
            final checked = weekChecks[i];
            return Column(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: checked ? kAccentGreen : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: checked
                          ? kAccentGreen
                          : CupertinoColors.systemGrey4,
                      width: 1.5,
                    ),
                  ),
                  child: checked
                      ? const Icon(Icons.check,
                          size: 12, color: CupertinoColors.white)
                      : null,
                ),
                const SizedBox(height: 4),
                Text(
                  days[i],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: checked
                        ? kAccentGreen
                        : CupertinoColors.label,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

// ───────────────────── PROGRESS BAR ───────────────────────
class _ProgressBar extends StatelessWidget {
  final double current;
  final double goal;
  const _ProgressBar({required this.current, required this.goal});

  @override
  Widget build(BuildContext context) {
    final percent = (current / goal).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            height: 6,
            color: CupertinoColors.systemGrey5,
            child: FractionallySizedBox(
              widthFactor: percent,
              alignment: Alignment.centerLeft,
              child: Container(color: kAccentGreen),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: kAccentGreen,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                current.toInt().toString(),
                style: GoogleFonts.poppins(
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              '${goal.toInt()} pts',
              style: GoogleFonts.poppins(
                color: CupertinoColors.secondaryLabel,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ───────────────────── PRACTICE GRID (Bento) ──────────────────────
class _PracticeGrid extends StatelessWidget {
  final List<_PracticeCardData> list;
  const _PracticeGrid({required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(flex: 2, child: _PracticeCard(data: list[0])),
                const SizedBox(height: 16),
                Expanded(flex: 1, child: _PracticeCard(data: list[2])),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: _PracticeCard(data: list[1])),
                const SizedBox(height: 16),
                Expanded(child: _PracticeCard(data: list[3])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticeCardData {
  final String titleBig;
  final String? subtitle;
  final String? description;
  final String? counter;
  final Color? counterColor;
  final String assetPath;
  final bool isLarge;

  _PracticeCardData({
    required this.titleBig,
    this.subtitle,
    this.description,
    this.counter,
    this.counterColor,
    required this.assetPath,
    this.isLarge = false,
  });
}

// ───────────────────── PRACTICE CARD ─────────────────────
class _PracticeCard extends StatelessWidget {
  final _PracticeCardData data;
  const _PracticeCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.subtitle != null) ...[
              Text(
                data.subtitle!,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
            ],
            Flexible(
              child: Text(
                data.titleBig,
                style: GoogleFonts.poppins(
                  fontSize: data.isLarge ? 17 : 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.1,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (data.description != null) ...[
              const SizedBox(height: 6),
              Flexible(
                child: Text(
                  data.description!,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (data.counter != null)
                  Text(
                    data.counter!,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: data.counterColor,
                    ),
                  ),
                Container(
                  width: 36,
                  height: 36,
                  child: Image.asset(
                    data.assetPath,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────── BOTTOM MENU (Original) ───────────────────────
class _BottomMenu extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;

  const _BottomMenu({
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      'assets/img/casa1.png',
      'assets/img/tareas2.png',
      'assets/img/rocket3.png',
      'assets/img/star4.png',
      'assets/img/avion5.png',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (i) {
          final isActive = i == current;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? kAccentGreen.withOpacity(0.1)
                    : Colors.transparent,
              ),
              child: Image.asset(
                icons[i], 
                width: 32,
                height: 32,
              ),
            ),
          );
        }),
      ),
    );
  }
}
