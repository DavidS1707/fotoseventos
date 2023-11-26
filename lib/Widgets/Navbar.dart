// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final String userName; // Nombre del usuario
  final String userEmail; // Correo del usuario
  final VoidCallback onExit;

  const NavBar({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.onExit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              userName,
              style: TextStyle(color: Colors.white),
            ), // Nombre del usuario
            accountEmail: Text(userEmail), // Correo del usuario
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.brown,
              radius: 50.0,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[300],
            ),
          ),
          // Resto de los elementos del Drawer
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Perfil"),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => PerfilUsuario(
              //       userName: userName,
              //       userEmail: userEmail,
              //     ),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_outlined),
            title: Text("Suscripción"),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => Suscripcion(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Configuracion"),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Cerrar Sesión"),
            onTap: onExit,
          ),
        ],
      ),
    );
  }
}
