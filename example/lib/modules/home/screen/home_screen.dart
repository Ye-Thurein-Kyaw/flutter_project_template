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
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0f1225) : const Color(0xFFF5F6FA),
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
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF1a1f38),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('welcome'),
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1a1f38) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: GestureDetector(
                      onTap: () => context.read<ThemeCubit>().toggleTheme(),
                      child: Icon(
                        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        color: isDark ? Colors.white : const Color(0xFF1a1f38),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _QuickActionCard(isDark: isDark),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Cubit Example',
                subtitle: 'Simple state management',
                icon: Icons.casino_rounded,
                isDark: isDark,
                onAction: () => context.read<HomeCubit>().loadData(),
              ),
              const SizedBox(height: 10),
              const HomeCubitItemList(),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Bloc Example',
                subtitle: 'Event-driven state management',
                icon: Icons.account_tree_rounded,
                isDark: isDark,
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
  final bool isDark;
  const _QuickActionCard({required this.isDark});

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Start',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore your dashboard today',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 28),
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
  final bool isDark;
  final VoidCallback onAction;
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isDark,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA))
                .withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF1a1f38),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey : Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onAction,
          icon: Icon(
            Icons.refresh_rounded,
            color: isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA),
          ),
        ),
      ],
    );
  }
}
