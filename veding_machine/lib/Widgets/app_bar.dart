import 'package:flutter/material.dart';

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchBar(
      elevation: MaterialStatePropertyAll(0),
      leading: Icon(Icons.search,color:Color.fromARGB(255, 230, 250, 246) ),
      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(0, 0, 0, 0)),
      textStyle: MaterialStatePropertyAll(TextStyle(color:Color.fromARGB(255, 230, 250, 246) )),
      hintText: 'Search',
    );
  }
}
