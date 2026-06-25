import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme_config/theme_cubit.dart';
import '../bloc/home_bloc.dart';
import '../cubit/home_cubit.dart';
import '../widget/home_bloc_item_list.dart';
import '../widget/home_cubit_item_list.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';
  const HomeScreen({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('home'),
                        style: textTheme.headlineLarge?.copyWith(color: colorScheme.onSurface),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('welcome'),
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: GestureDetector(
                      onTap: () => context.read<ThemeCubit>().toggleTheme(),
                      child: Icon(
                        theme.brightness == Brightness.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        color: colorScheme.onSurface,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _QuickActionCard(colorScheme: colorScheme, textTheme: textTheme),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Cubit Example',
                subtitle: 'Simple state management',
                icon: Icons.casino_rounded,
                colorScheme: colorScheme,
                textTheme: textTheme,
                onAction: () => context.read<HomeCubit>().loadData(),
              ),
              const SizedBox(height: 10),
              const HomeCubitItemList(),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Bloc Example',
                subtitle: 'Event-driven state management',
                icon: Icons.account_tree_rounded,
                colorScheme: colorScheme,
                textTheme: textTheme,
                onAction: () => context.read<HomeBloc>().add(HomeLoadRequested()),
              ),
              const SizedBox(height: 10),
              const HomeBlocItemList(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  const _QuickActionCard({required this.colorScheme, required this.textTheme});

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Start',
                  style: textTheme.titleMedium?.copyWith(color: colorScheme.surface),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore your dashboard today',
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.surface.withValues(alpha: 0.78)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.rocket_launch_rounded, color: colorScheme.surface, size: 28),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onAction;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colorScheme,
    required this.textTheme,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
              ),
              Text(
                subtitle,
                style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onAction,
          icon: Icon(
            Icons.refresh_rounded,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
