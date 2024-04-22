import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:veding_machine/Pages/each_machine.dart';

class CardMachine extends StatefulWidget {
  final String machineId;

  const CardMachine({required this.machineId, super.key});

  @override
  _CardMachinesState createState() => _CardMachinesState();
}

class _CardMachinesState extends State<CardMachine> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _databaseReference
          .child('Machines/${widget.machineId}')
          .orderByKey()
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final machineData = Map<String, dynamic>.from(snapshot.data!.snapshot.value as dynamic);
          String title = machineData['title'];
          int revenue = machineData['revenue'];
          int flavor1Qtt = machineData['flavor1_qtt'];
          int flavor2Qtt = machineData['flavor2_qtt'];
          int flavor3Qtt = machineData['flavor3_qtt'];
          bool isOnline = machineData['isOnline'];



          String textRefill =
              flavor1Qtt < 25 || flavor2Qtt < 25 || flavor3Qtt < 25
                  ? 'Refill !'
                  : 'No Need';

          Color colorRefill =
              flavor1Qtt < 25 || flavor2Qtt < 25 || flavor3Qtt < 25
                  ? Colors.red
                  : Colors.green;

          Color colorIcon = isOnline ? Colors.green : Colors.red;

          return Container(
            margin: const EdgeInsets.all(10),
            height: 200,
            child: Card(
              color: const Color.fromARGB(255, 33, 36, 37),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor:
                    const Color.fromARGB(255, 3, 131, 118).withAlpha(30),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EachMachine(
                              machineId: widget.machineId,
                              title: title,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.build_rounded,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextCard(title, 24)
                              ],
                            ),
                            Icon(
                              Icons.offline_bolt_outlined,
                              color: colorIcon,
                            )
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const TextCard('Refill Status', 22),
                              const SizedBox(
                                height: 15,
                              ),
                              TextCard(
                                textRefill,
                                20,
                                color: colorRefill,
                              )
                            ],
                          ),
                          Container(
                            height: 60,
                            width: 1,
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          Column(
                            children: [
                              const Row(
                                children: [
                                  TextCard('Income', 22),
                                  TextCard(' (daily)', 15)
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextCard(
                                '$revenue \$',
                                20,
                                color: const Color.fromARGB(255, 3, 179, 227),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
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

class TextCard extends StatelessWidget {
  const TextCard(this.text, this.size, {super.key, this.color});
  final String text;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? const Color.fromARGB(255, 230, 250, 246),
        fontSize: size,
      ),
    );
  }
}
