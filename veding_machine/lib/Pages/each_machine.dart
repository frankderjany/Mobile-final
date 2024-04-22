import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:veding_machine/Widgets/Cards/card_graph.dart';

class EachMachine extends StatelessWidget {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final String machineId;
  final String title;

  EachMachine({required this.machineId, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 180, 179, 179),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 36, 37),
        toolbarHeight: 100,
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
                      fontSize: 28,
                    ),
                  ),
                  Image.asset(
                    'assets/logo.png',
                    width: 60,
                  )
                ],
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: _databaseReference
            .child('Machines/$machineId')
            .orderByKey()
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final machineData = Map<String, dynamic>.from(
                snapshot.data!.snapshot.value as dynamic);
            int revenue = machineData['revenue'];
            int flavor1Qtt = machineData['flavor1_qtt'];
            int flavor2Qtt = machineData['flavor2_qtt'];
            int flavor3Qtt = machineData['flavor3_qtt'];

            return ListView(
              children: [
                const SizedBox(height: 16),
                buildFlavorCard('Flavor 1', flavor1Qtt),
                const SizedBox(height: 16),
                buildFlavorCard('Flavor 2', flavor2Qtt),
                const SizedBox(height: 16),
                buildFlavorCard('Flavor 3', flavor3Qtt),
                const SizedBox(height: 16),
                buildRevenueCard(revenue),
                const SizedBox(height: 16),
                const CardGraph(),
                const SizedBox(height: 16),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildFlavorCard(String flavorName, int quantity) {
    double progress = quantity / 100;
    return Card(
      color: const Color.fromARGB(255, 33, 36, 37),
      child: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              leading: const Icon(Icons.water_drop_outlined),
              iconColor: const Color.fromARGB(255, 230, 250, 246),
              title: Text(
                flavorName,
                style: const TextStyle(fontSize: 20),
              ),
              textColor: const Color.fromARGB(255, 230, 250, 246),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, bottom: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$quantity%',
                    style: TextStyle(
                      color: quantity < 25 ? Colors.red : Colors.green,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        quantity < 25 ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRevenueCard(int revenue) {
    return Card(
      color: const Color.fromARGB(255, 33, 36, 37),
      child: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ListTile(
              leading: Icon(Icons.attach_money),
              iconColor: Color.fromARGB(255, 230, 250, 246),
              title: Text(
                'Revenue',
                style: TextStyle(fontSize: 20),
              ),
              textColor: Color.fromARGB(255, 230, 250, 246),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text(
                '$revenue \$',
                style: const TextStyle(
                  color: Color.fromARGB(255, 230, 250, 246),
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
