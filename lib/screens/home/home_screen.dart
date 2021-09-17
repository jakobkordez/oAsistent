import 'package:easistent_client/easistent_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o_asistent/components/hour_event_card.dart';
import 'package:o_asistent/cubit/time_table_cubit.dart';
import 'package:o_asistent/repositories/eas_repository.dart';
import 'package:o_asistent/utils/datetime_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('oAsistent'),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/profile'),
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => TimeTableCubit(context.read<EAsRepository>())
            ..setDate(DateTime.now().date),
          child: const _Home(),
        ),
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
                ..._getEvent(
                    'Trenutna ura',
                    state.timeTable.schoolHourEvents
                        .cast<SchoolHourEvent?>()
                        .firstWhere(
                          (e) =>
                              e!.timeFrom.isBefore(now) &&
                              e.timeTo.isAfter(now),
                          orElse: () => null,
                        )),
                ..._getEvent(
                    'Naslednja ura',
                    state.timeTable.schoolHourEvents
                        .cast<SchoolHourEvent?>()
                        .firstWhere(
                          (e) => e!.timeFrom.isAfter(now),
                          orElse: () => null,
                        )),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/timetable'),
                  child: const Text('Prikaži cel urnik'),
                ),
              ],
            );
          }

          return const Center(child: Icon(Icons.error));
        },
      ),
    );
  }

  static List<Widget> _getEvent(String label, SchoolHourEvent? event) =>
      event == null
          ? []
          : [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child:
                    Text(label, style: TextStyle(color: Colors.grey.shade800)),
              ),
              HourEventCard(event: event),
              const SizedBox(height: 10),
            ];
}
