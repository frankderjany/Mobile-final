import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CardDashboard extends StatefulWidget {
  final String? machineId;

  const CardDashboard({this.machineId, super.key});

  @override
  _CardDashboardState createState() => _CardDashboardState();
}

class _CardDashboardState extends State<CardDashboard> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _databaseReference.child('Machines').orderByKey().onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final machineData = Map<String, dynamic>.from(
              snapshot.data!.snapshot.value as dynamic);

          int totalMachines = machineData.length;

          int onlineMachines = 0;
          machineData.forEach((key, value) {
            if (value['isOnline'] == true) {
              onlineMachines++;
            }
          });

          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      color: const Color.fromARGB(255, 33, 36, 37),
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ListTile(
                              leading: Icon(Icons.ad_units_rounded),
                              iconColor: Color.fromARGB(255, 230, 250, 246),
                              title: Text('All Machines'),
                              textColor: Color.fromARGB(255, 230, 250, 246),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 10.0),
                              child: Text("$totalMachines",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 230, 250, 246),
                                    fontSize: 25,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      color: const Color.fromARGB(255, 33, 36, 37),
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ListTile(
                              leading: Icon(Icons.album_rounded),
                              iconColor: Color.fromARGB(255, 6, 242, 195),
                              title: Text('Connected'),
                              textColor: Color.fromARGB(255, 230, 250, 246),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 10.0),
                              child: Text("$onlineMachines",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 230, 250, 246),
                                    fontSize: 25,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      color: Color.fromARGB(255, 33, 36, 37),
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListTile(
                              leading: Icon(Icons.attach_money_rounded),
                              iconColor: Color.fromARGB(255, 244, 96, 96),
                              title: Text('Revenue', style: TextStyle(fontSize: 18,)),
                              subtitle: Text('per month', style: TextStyle(fontSize: 13,),),
                              textColor: Color.fromARGB(255, 230, 250, 246),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                              child: Text("14", style: TextStyle(color: Color.fromARGB(255, 230, 250, 246),fontSize: 25,)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
