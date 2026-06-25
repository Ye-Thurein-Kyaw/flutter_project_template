import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

/// A reusable list widget that uses [HomeCubit].
///
/// This widget demonstrates how a **Cubit-driven** widget works.
/// It reads state from [HomeCubit] and dispatches callbacks to remove items.
class HomeCubitItemList extends StatelessWidget {
  const HomeCubitItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!state.hasData) {
          return Center(
            child: Text(
              'No items yet',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            return Card(
              color: colorScheme.surface,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: colorScheme.outline),
              ),
              child: ListTile(
                title: Text(
                  state.items[index],
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: colorScheme.error,
                    size: 20,
                  ),
                  onPressed: () => context.read<HomeCubit>().removeItem(index),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
