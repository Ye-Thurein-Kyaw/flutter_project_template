import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/locale_config/locale_cubit.dart';
import '../../../config/theme_config/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  static const route = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0f1225) : const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('profile'),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1a1f38),
                ),
              ),
              const SizedBox(height: 24),
              _ProfileCard(isDark: isDark),
              const SizedBox(height: 20),
              _SettingsSection(isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final bool isDark;

  const _ProfileCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1a1f38), const Color(0xFF30385D)]
              : [const Color(0xFF005BAA), const Color(0xFF3d83ff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_rounded, color: Colors.white, size: 36),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('my_profile'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.edit_rounded, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final bool isDark;

  const _SettingsSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            tr('settings'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1a1f38),
            ),
          ),
        ),
        _SettingsTile(
          icon: Icons.language_rounded,
          title: tr('change_language'),
          isDark: isDark,
          onTap: () => _showLanguageSheet(context),
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          title: isDark ? tr('light_mode') : tr('dark_mode'),
          isDark: isDark,
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: Icons.notifications_rounded,
          title: tr('notifications'),
          isDark: isDark,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: Icons.privacy_tip_rounded,
          title: tr('privacy'),
          isDark: isDark,
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _SettingsTile(
          icon: Icons.logout_rounded,
          title: tr('logout'),
          isDark: isDark,
          isDestructive: true,
          onTap: () {},
        ),
      ],
    );
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1a1f38) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _LanguageSheet(isDark: isDark);
      },
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDark;
  final bool isDestructive;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.isDark,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isDestructive
        ? Colors.red
        : (isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA));

    return Material(
      color: isDark ? const Color(0xFF1a1f38) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDestructive
                        ? Colors.red
                        : (isDark ? Colors.white : const Color(0xFF1a1f38)),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: isDark ? Colors.grey : Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  final bool isDark;

  const _LanguageSheet({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            tr('select_language'),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1a1f38),
            ),
          ),
          const SizedBox(height: 20),
          _LanguageOption(
            flag: '\u{1F1FA}\u{1F1F8}',
            label: tr('language_en'),
            locale: const Locale('en', 'US'),
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _LanguageOption(
            flag: '\u{1F1F2}\u{1F1F2}',
            label: tr('language_my'),
            locale: const Locale('my', 'MM'),
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                tr('cancel'),
                style: TextStyle(
                  color: isDark ? Colors.grey : Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String label;
  final Locale locale;
  final bool isDark;

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.locale,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final isSelected = currentLocale == locale;

    return Material(
      color: isSelected
          ? (isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA))
              .withValues(alpha: 0.12)
          : (isDark ? const Color(0xFF30385D) : const Color(0xFFF5F6FA)),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          context.read<LocaleCubit>().changeLocale(locale, context);
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: isSelected
                ? Border.all(
                    color: isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA),
                    width: 1.5,
                  )
                : null,
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? (isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA))
                        : (isDark ? Colors.white : const Color(0xFF1a1f38)),
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA),
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
