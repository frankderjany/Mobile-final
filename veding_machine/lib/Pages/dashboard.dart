import 'package:flutter/material.dart';
import 'package:veding_machine/Widgets/Cards/card_dashboard.dart';
import 'package:veding_machine/Widgets/Cards/card_graph.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:veding_machine/firebase_service.dart';

class Dashboard extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _databaseReference.child('Machines').orderByKey().onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final machineData = Map<dynamic, dynamic>.from(
              snapshot.data!.snapshot.value as dynamic);
          machineData.forEach((key, value) {
            firebaseService.notification(value, key);
          });

          return const SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  CardDashboard(),
                  SizedBox(height: 16),
                  CardGraph(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
