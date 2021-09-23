import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:o_asistent/components/hour_event_card.dart';
import 'package:o_asistent/cubit/time_table_cubit.dart';
import 'package:o_asistent/repositories/eas_repository.dart';
import 'package:o_asistent/screens/home/cubit/date_selector_cubit.dart';
import 'package:o_asistent/utils/group_util.dart';

class TimeTableTab extends StatelessWidget {
  const TimeTableTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DateSelectorCubit()),
          BlocProvider(
            create: (context) => TimeTableCubit(context.read<EAsRepository>())
              ..setDate(context.read<DateSelectorCubit>().state),
          ),
        ],
        child: BlocListener<DateSelectorCubit, DateTime>(
          listener: (context, state) {
            context.read<TimeTableCubit>().setDate(state);
          },
          child: const _TimeTable(),
        ),
      );
}

class _TimeTable extends StatelessWidget {
  const _TimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => context.read<TimeTableCubit>().refresh(),
        child: BlocConsumer<TimeTableCubit, TimeTableState>(
          listener: (context, state) {
            if (state is TimeTableError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) => ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const _DateNavigator(),
              const SizedBox(height: 5),
              if (state is TimeTableLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (state is TimeTableLoaded)
                // TODO Events
                ...state.timeTable.schoolHourEvents
                    .group((e) => e.timeFrom)
                    .map((e) => HourEventsCard(events: e))
              else
                const Center(child: Icon(Icons.error)),
            ],
          ),
        ),
      );
}

class _DateNavigator extends StatelessWidget {
  const _DateNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            IconButton(
              splashRadius: 30,
              onPressed: () => context.read<DateSelectorCubit>().prevDay(),
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<DateSelectorCubit, DateTime>(
                  builder: (context, state) =>
                      Text(DateFormat.MEd().format(state)),
                ),
              ),
            ),
            IconButton(
              splashRadius: 30,
              onPressed: () => context.read<DateSelectorCubit>().nextDay(),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      );
}
