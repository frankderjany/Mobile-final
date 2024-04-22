import 'package:flutter/material.dart';

class BottomAppBarCustom extends StatefulWidget {
  const BottomAppBarCustom(this.machines, this.dashboard, this.alerts,{super.key});
  final void Function() machines;
  final void Function() dashboard;
  final void Function() alerts;

  @override
  BottomNavigationBarExampleState createState() =>
      BottomNavigationBarExampleState();
}

class BottomNavigationBarExampleState extends State<BottomAppBarCustom> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 33, 36, 37),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
              widget.machines();
            },
            icon: Icons.auto_awesome_motion_rounded,
            text: 'Machines',
            isSelected: _selectedIndex == 0,
          ),
          BottomButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
              widget.dashboard();
            },
            icon: Icons.align_vertical_bottom_sharp,
            text: 'Dashboard',
            isSelected: _selectedIndex == 1,
          ),
          BottomButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
              widget.alerts();
            },
            icon: Icons.notifications,
            text: 'Alerts',
            isSelected: _selectedIndex == 2,
          ),
        ],
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final bool isSelected;

  const BottomButton({
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(style: BorderStyle.none),
        minimumSize: const Size(120, 40)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected
                ? const Color.fromARGB(255, 0, 163, 143)
                : const Color.fromARGB(255, 230, 250, 246),
          ),
          const SizedBox(height: 6), // Add some space between icon and text
          Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? const Color.fromARGB(255, 0, 163, 143)
                  : const Color.fromARGB(255, 230, 250, 246),
            ),
          ),
        ],
      ),
    );
  }
}
