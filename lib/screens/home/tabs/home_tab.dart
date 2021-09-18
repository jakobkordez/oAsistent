import 'package:easistent_client/easistent_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o_asistent/components/hour_event_card.dart';
import 'package:o_asistent/cubit/time_table_cubit.dart';
import 'package:o_asistent/repositories/eas_repository.dart';
import 'package:o_asistent/utils/datetime_utils.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => TimeTableCubit(context.read<EAsRepository>())
          ..setDate(DateTime.now().date),
        child: const _Home(),
      );
}

class _Home extends StatelessWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return RefreshIndicator(
      onRefresh: () => context.read<TimeTableCubit>().setDate(now.date, true),
      child: BlocConsumer<TimeTableCubit, TimeTableState>(
        listener: (context, state) {
          if (state is TimeTableError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        builder: (context, state) {
          if (state is TimeTableLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TimeTableLoaded) {
            return ListView(
              padding: const EdgeInsets.all(10),
              children: [
                _TimeTableCard(state: state),
              ],
            );
          }

          return ListView(
            children: const [
              Center(child: Icon(Icons.error)),
            ],
          );
        },
      ),
    );
  }
}

class _TimeTableCard extends StatelessWidget {
  final TimeTableLoaded state;

  const _TimeTableCard({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final thisHour =
        state.timeTable.schoolHourEvents.cast<SchoolHourEvent?>().firstWhere(
              (e) => e!.timeFrom.isBefore(now) && e.timeTo.isAfter(now),
              orElse: () => null,
            );
    final nextHour =
        state.timeTable.schoolHourEvents.cast<SchoolHourEvent?>().firstWhere(
              (e) => e!.timeFrom.isAfter(now),
              orElse: () => null,
            );

    return Card(
      elevation: 3,
      child: ClipRRect(
        borderRadius:
            (Theme.of(context).cardTheme.shape as RoundedRectangleBorder)
                .borderRadius as BorderRadius,
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.grey.shade800),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (thisHour != null) HourEventContainer(event: thisHour),
              if (nextHour != null) HourEventContainer(event: nextHour),
              if (thisHour == null && nextHour == null)
                Text(
                  'Danes nimaš več ur',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
            ],
          ),
        ),
      ),
    );
  }
}