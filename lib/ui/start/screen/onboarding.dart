import 'package:evently_c19/core/remote/local/prefs_manager.dart';
import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/app_theme.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController();
  int currentPage = 0;

  // Page 0 is StartScreen, pages 1-3 are the onboarding illustration pages
  static const int totalPages = 4;

  bool get isFirstPage => currentPage == 0;
  bool get isLastPage => currentPage == totalPages - 1;

  List<OnboardingData> get illustrationPages {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      OnboardingData(
        title: StringsManager.onBoardinPageOne,
        description: StringsManager.onBoardinDescOne,
        image: isDark
            ? AssetsManager.onBoardingDarkOne
            : AssetsManager.onBoardingLightOne,
      ),
      OnboardingData(
        title: "Effortless Event Planning",
        description:
        "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we've got you covered.",
        image: isDark
            ? AssetsManager.onBoardingDarkTwo
            : AssetsManager.onBoardingLightTwo,
      ),
      OnboardingData(
        title: "Connect with Friends & Share Moments",
        description:
        "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together.",
        image: isDark
            ? AssetsManager.onBoardingDarkThree
            : AssetsManager.onBoardingLightThree,
      ),
    ];
  }

  void goNext() {
    if (!isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void _goBack() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> finishOnboarding() async {
    await PrefsManager.setOnboardingSeen();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(RoutesManager.loginRouteName);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ───────────────────────────────────────────────
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back arrow (hidden on first page)
                  if (!isFirstPage)
                    GestureDetector(
                      onTap: _goBack,
                      child: Icon(Icons.arrow_back_ios,
                          color: colorScheme.primary, size: 20),
                    )
                  else
                    const SizedBox(width: 24),

                  // Logo
                  Image.asset(
                    AssetsManager.logo,
                    height: 27,
                    fit: BoxFit.fitHeight,
                    color: colorScheme.primary,
                  ),

                  // Skip (hidden on first and last page)
                  if (!isFirstPage && !isLastPage)
                    GestureDetector(
                      onTap: finishOnboarding,
                      child: Text(
                        'Skip',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 32),
                ],
              ),
            ),

            // ── PageView ──────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) =>
                    setState(() => currentPage = index),
                itemCount: totalPages,
                itemBuilder: (context, index) {
                  // Page 0 = StartScreen embedded
                  if (index == 0) {
                    return _StartPageEmbed(
                      themeProvider: themeProvider,
                    );
                  }

                  // Pages 1-3 = illustration pages
                  final page = illustrationPages[index - 1];
                  final isDark =
                      Theme.of(context).brightness == Brightness.dark;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Illustration
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              page.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Dot indicators
                        Row(
                          children: List.generate(
                            3, // dots only for illustration pages
                                (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 6),
                              width: i == (currentPage - 1) ? 20 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: i == (currentPage - 1)
                                    ? colorScheme.primary
                                    : (isDark
                                    ? Colors.white24
                                    : Colors.black26),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Title
                        Text(
                          page.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Description
                        Text(
                          page.description ?? '',
                          style: textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ── Bottom button ─────────────────────────────────────────
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: goNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    isLastPage
                        ? 'Get started'
                        : isFirstPage
                        ? "Let's start"
                        : 'Next',
                    style: textTheme.labelMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Embedded StartScreen content (page 0) ────────────────────────────
class _StartPageEmbed extends StatelessWidget {
  final ThemeProvider themeProvider;
  const _StartPageEmbed({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              AssetsManager.beingCreative,
              color: colorScheme.onTertiary,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 24),
          Text(StringsManager.startTitle, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(StringsManager.startDesc, style: textTheme.bodyMedium),
          const SizedBox(height: 16),
          // Language row
          Row(
            children: [
              Text(StringsManager.language, style: textTheme.titleSmall),
              const Spacer(),
              _LangChip("en", context),
              const SizedBox(width: 8),
              _LangChip("ar", context),
            ],
          ),
          const SizedBox(height: 16),
          // Theme row
          Row(
            children: [
              Text(StringsManager.theme, style: textTheme.titleSmall),
              const Spacer(),
              _ThemeChip(ThemeMode.light, themeProvider, context),
              const SizedBox(width: 8),
              _ThemeChip(ThemeMode.dark, themeProvider, context),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _LangChip(String lang, BuildContext context) {
    final isSelected = lang == AppTheme.languageCode;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: isSelected
            ? null
            : Border.all(color: colorScheme.onSecondary),
        color: isSelected ? colorScheme.primary : colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        lang == "ar" ? "العربية" : "English",
        style: isSelected
            ? textTheme.displayMedium
            : textTheme.displaySmall,
      ),
    );
  }

  Widget _ThemeChip(
      ThemeMode mode, ThemeProvider themeProvider, BuildContext context) {
    final isSelected = mode == themeProvider.selectedTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => themeProvider.changeTheme(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          border: isSelected
              ? null
              : Border.all(color: colorScheme.onSecondary),
          color: isSelected ? colorScheme.primary : colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
          color: isSelected ? Colors.white : colorScheme.primary,
          size: 20,
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String? description;
  final String image;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}