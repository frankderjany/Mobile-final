import 'package:flutter/material.dart';
import 'package:veding_machine/Pages/alerts.dart';
import 'package:veding_machine/Pages/dashboard.dart';
import 'package:veding_machine/Pages/machines.dart';
import 'package:veding_machine/Widgets/app_bar.dart';
import 'Widgets/bottom_app_bar.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  var activeScreen = 'Machines';
  var title = 'Machines';

  void changeScreenToDashboard() {
    setState(() {
      activeScreen = 'Dashboard';
      title = 'Dashboard';
    });
  }

  void changeScreenToAlerts() {
    setState(() {
      activeScreen = 'Alerts';
      title = 'Alerts';
    });
  }

  void changeScreenToMachines() {
    setState(() {
      activeScreen = 'Machines';
      title = 'Machines';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 180, 179, 179),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 36, 37),
          toolbarHeight: 130,
          title: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 230, 250, 246),
                          fontSize: 28),
                    ),
                    Image.asset(
                      'assets/logo.png',
                      width: 60,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SearchBarCustom()
              ],
            ),
          ),
        ),
        body: Column(children: [
          Expanded(
            child: activeScreen == 'Machines'
                ? Machines()
                : activeScreen == 'Alerts'
                    ? Alerts()
                    : Dashboard(),
          ),
        ]),
        bottomNavigationBar: BottomAppBarCustom(changeScreenToMachines,
            changeScreenToDashboard, changeScreenToAlerts),
      ),
    );
  }
}
