import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  Function(int indice)? onItemTap;

  DrawerCustom({Key? key, required this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú Inicio'),
          ),
          ListTile(
            title: const Text('Home'),
            leading:
                Icon(Icons.home, color: Colors.indigo),
            onTap: () {
              onItemTap!(1);
            },
          ),

          ListTile(
            title: const Text('Ajustes'),
            leading:
            Icon(Icons.settings, color: Colors.indigo),
            onTap: () {
              onItemTap!(2);
            },
          ),

          ListTile(
            title: const Text('Logout'),
            leading:
            Icon(Icons.logout, color: Colors.indigo),
            onTap: () {
              onItemTap!(0);
            },
          ),
        ],
      ),
    );
  }
}
