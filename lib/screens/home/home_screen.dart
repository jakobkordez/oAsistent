import 'package:flutter/material.dart';
import 'package:o_asistent/screens/home/tabs/home_tab.dart';
import 'package:o_asistent/screens/home/tabs/settings_tab.dart';
import 'package:o_asistent/screens/home/tabs/timetable_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('oAsistent'),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeTab(),
            TimeTableTab(),
            SettingsTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabController.index,
          onTap: (value) => setState(() {
            _tabController.animateTo(value);
          }),
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.shade600,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Pregled',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day),
              label: 'Urnik',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Nastavitve',
            ),
          ],
        ),
      );
}
