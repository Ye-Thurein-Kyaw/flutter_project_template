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
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('profile'),
                style: textTheme.headlineLarge?.copyWith(color: colorScheme.onSurface),
              ),
              const SizedBox(height: 24),
              _ProfileCard(colorScheme: colorScheme, textTheme: textTheme),
              const SizedBox(height: 20),
              _SettingsSection(colorScheme: colorScheme, textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _ProfileCard({required this.colorScheme, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.secondary],
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
              color: colorScheme.surface.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_rounded, color: colorScheme.surface, size: 36),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('my_profile'),
                  style: textTheme.titleLarge?.copyWith(color: colorScheme.surface),
                ),
                const SizedBox(height: 4),
                Text(
                  'user@example.com',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.surface.withValues(alpha: 0.8)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.edit_rounded, color: colorScheme.surface, size: 20),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SettingsSection({required this.colorScheme, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            tr('settings'),
            style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
          ),
        ),
        _SettingsTile(
          icon: Icons.language_rounded,
          title: tr('change_language'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          onTap: () => _showLanguageSheet(context),
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: Theme.of(context).brightness == Brightness.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          title: Theme.of(context).brightness == Brightness.dark ? tr('light_mode') : tr('dark_mode'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: Icons.notifications_rounded,
          title: tr('notifications'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: Icons.privacy_tip_rounded,
          title: tr('privacy'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _SettingsTile(
          icon: Icons.logout_rounded,
          title: tr('logout'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          isDestructive: true,
          onTap: () {},
        ),
      ],
    );
  }

  void _showLanguageSheet(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: localeCubit,
          child: const _LanguageSheet(),
        );
      },
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final bool isDestructive;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.colorScheme,
    required this.textTheme,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isDestructive
        ? colorScheme.error
        : colorScheme.primary;

    return Material(
      color: colorScheme.surface,
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
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDestructive ? colorScheme.error : colorScheme.onSurface,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.55),
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
  const _LanguageSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

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
                color: colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            tr('select_language'),
            style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 20),
          _LanguageOption(
            flag: '\u{1F1FA}\u{1F1F8}',
            label: tr('language_en'),
            locale: const Locale('en', 'US'),
          ),
          const SizedBox(height: 12),
          _LanguageOption(
            flag: '\u{1F1F2}\u{1F1F2}',
            label: tr('language_my'),
            locale: const Locale('my', 'MM'),
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
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
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

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final isSelected = currentLocale == locale;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Material(
      color: isSelected ? colorScheme.primary.withValues(alpha: 0.12) : colorScheme.surface,
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
                ? Border.all(color: colorScheme.primary, width: 1.5)
                : null,
          ),
          child: Row(
            children: [
              Text(flag, style: textTheme.titleLarge),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: colorScheme.primary,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
