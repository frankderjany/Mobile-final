import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CardAlerts extends StatefulWidget {
  final String notifId;

  const CardAlerts({required this.notifId, super.key});

  @override
  _CardAlertsState createState() => _CardAlertsState();
}

class _CardAlertsState extends State<CardAlerts> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _databaseReference
          .child('Notifications/${widget.notifId}')
          .orderByKey()
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final machineData = Map<String, dynamic>.from(
              snapshot.data!.snapshot.value as dynamic);
          String message = machineData['message'];
          String sender = machineData['sender'];

          // Assuming your timestamp is stored in the 'timestamp' field
          int timestamp = machineData['timestamp'];

          // Convert the timestamp to a DateTime object
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

          // Format the DateTime object to a string in the desired format
          String formattedDateTime = '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
          
          return Container(
            margin: const EdgeInsets.all(10),
            height: 100,
            child: Card(
              color: const Color.fromARGB(255, 33, 36, 37),
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications_active_outlined),
                      iconColor: const Color.fromARGB(255, 230, 250, 246),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sender,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            formattedDateTime,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      textColor: const Color.fromARGB(255, 230, 250, 246),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 230, 250, 246),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

}
