import 'package:flutter/material.dart';

class CardGraph extends StatelessWidget {
  const CardGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Card(
            // clipBehavior is necessary because, without it, the InkWell's animation
            // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
            // This comes with a small performance cost, and you should not set [clipBehavior]
            // unless you need it.
            color: const Color.fromARGB(255, 33, 36, 37),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: const Color.fromARGB(255, 230, 250, 246),
              onTap: () {
                debugPrint('Card tapped.');
              },
              child: const SizedBox(
                height: 200,
                child: Text('Graph', style: TextStyle(color:Color.fromARGB(255, 230, 250, 246)),),
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }
}
