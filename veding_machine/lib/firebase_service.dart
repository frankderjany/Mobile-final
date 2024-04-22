import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  void notification(Map<dynamic, dynamic> machineData, String path) {
    int flavor1Qtt = machineData['flavor1_qtt'] ?? 0;
    int flavor2Qtt = machineData['flavor2_qtt'] ?? 0;
    int flavor3Qtt = machineData['flavor3_qtt'] ?? 0;
    String title = machineData['title'] ?? '';
    bool notif251 = machineData['notif251'] ?? false;
    bool notif252 = machineData['notif252'] ?? false;
    bool notif253 = machineData['notif253'] ?? false;

    if (flavor1Qtt < 25 && notif251 == false) {
      _databaseReference.child('/Notifications').push().set({
        'sender': title,
        'message': 'flavor 1 under 25%',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      _databaseReference.child('Machines/$path').update({'notif251': true});
    }

    if (flavor2Qtt < 25 && notif252 == false) {
      _databaseReference.child('/Notifications').push().set({
        'sender': title,
        'message': 'flavor 2 under 25%',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      _databaseReference.child('Machines/$path').update({'notif252': true});
    }

    if (flavor3Qtt < 25 && notif253 == false) {
      _databaseReference.child('/Notifications').push().set({
        'sender': title,
        'message': 'flavor 3 under 25%',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      _databaseReference.child('Machines/$path').update({'notif253': true});
    }

    if (flavor1Qtt > 25 && notif251 == true) {
      _databaseReference.child('Machines/$path').update({'notif251': false});
    }

    if (flavor2Qtt > 25 && notif252 == true) {
      _databaseReference.child('Machines/$path').update({'notif252': false});
    }

    if (flavor3Qtt > 25 && notif253 == true) {
      _databaseReference.child('Machines/$path').update({'notif253': false});
    }
  }

  void reset(Map<dynamic, dynamic> machineData, String path) {

    int revenueMachine = machineData['revenue'];

    // Get current date and time
    DateTime currentTime = DateTime.now();
    DateTime nullifyTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      0, // 12 AM
      0, // Minutes
      0, // Seconds
      0, // Milliseconds
    );
    // Get current date and time without seconds
    DateTime currentTimeWithoutSeconds = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour,
      currentTime.minute,
    );

    // Get the start time as a timestamp
    int nullifyTimestamp = nullifyTime.millisecondsSinceEpoch;
    int currentTimestamp = currentTime.millisecondsSinceEpoch;
    String currentTimeString = currentTimeWithoutSeconds.toString();


    // Nullify the record if its timestamp is greater than or equal to the nullify time
    if (currentTimestamp >= nullifyTimestamp) {
      _databaseReference.child('Revenues/$path').push().update({'time': currentTimeString,'revenue':revenueMachine});
      _databaseReference.child('Machines/$path').update({'revenue': 0});
    }
  }
}
