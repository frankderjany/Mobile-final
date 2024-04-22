import 'package:flutter/material.dart';
import 'package:veding_machine/Widgets/Cards/card_machine.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:veding_machine/firebase_service.dart';

class Machines extends StatelessWidget {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseService firebaseService = FirebaseService();

  Machines({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _databaseReference.child('Machines').orderByKey().onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final machineData = Map<dynamic, dynamic>.from(snapshot.data!.snapshot.value as dynamic);

          List<Widget> machineCards = [];

          snapshot.data!.snapshot.children.forEach((machineSnapshot) {
            DataSnapshot data = machineSnapshot as DataSnapshot;
            String key = data.key!;
            if (machineData.containsKey(key)) {
              machineCards.add(CardMachine(machineId: key));
              firebaseService.notification(machineData[key], key);
            }
          });

          return ListView(
            children: machineCards,
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
