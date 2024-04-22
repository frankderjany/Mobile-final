import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:veding_machine/Widgets/Cards/card_alerts.dart';
import 'package:veding_machine/firebase_service.dart';

class Alerts extends StatelessWidget {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseService firebaseService = FirebaseService();

  Alerts({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _databaseReference.child('Notifications').orderByKey().onValue,
      builder: (context, snapshot1) {
        return StreamBuilder(
          stream: _databaseReference.child('Machines').orderByKey().onValue,
          builder: (context, snapshot2) {
            if (snapshot1.hasData && snapshot2.hasData) {
              final notifcationData = Map<String, dynamic>.from(snapshot1.data!.snapshot.value as dynamic);
              final machineData = Map<dynamic, dynamic>.from(snapshot2.data!.snapshot.value as dynamic);

              List<Widget> alertsCards = [];

              // Convert the snapshot children to a list and then reverse it
              List<DataSnapshot> reversedList = snapshot1.data!.snapshot.children.toList().reversed.toList();
              
              // Iterate over the reversed list of notificationData
              reversedList.forEach((notifSnapshot) {
                DataSnapshot data = notifSnapshot as DataSnapshot;
                String key = data.key!;
                if (notifcationData.containsKey(key)) {
                  alertsCards.add(CardAlerts(
                    notifId: key,
                  ));
                }
              });


              // Perform additional operations for machineData
              machineData.forEach((key, value) {
                firebaseService.notification(value,key);
              });
              

              return ListView(
                children: alertsCards,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}
