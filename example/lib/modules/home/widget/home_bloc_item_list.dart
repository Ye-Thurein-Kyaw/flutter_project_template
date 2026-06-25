import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

/// A reusable list widget that uses [HomeBloc].
///
/// This widget demonstrates how a **Bloc-driven** widget works.
/// It reacts to [HomeState] subclasses and dispatches [HomeEvent]s.
class HomeBlocItemList extends StatelessWidget {
  const HomeBlocItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeLoadFailure) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
            ),
          );
        }

        if (state is HomeLoadSuccess) {
          if (state.items.isEmpty) {
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
                    onPressed: () => context.read<HomeBloc>().add(HomeItemRemoved(index)),
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
