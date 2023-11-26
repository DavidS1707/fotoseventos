// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fotoseventos/Screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/Navbar.dart';

class NotificationScreen extends StatelessWidget {
  final String userName; // Nombre de usuario
  final String userEmail; // Correo electrónico del usuario

  const NotificationScreen({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);
  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    void onExit(BuildContext context) async {
      final prefs = await SharedPreferences.getInstance();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cerrar Sesión'),
            content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  await prefs.remove('authToken'); // Elimina el token
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        userName: '',
                        userEmail: '',
                      ), // Navega a la página de inicio
                    ),
                  );
                },
                child: const Text('Cerrar Sesión'),
              ),
            ],
          );
        },
      );
    }

    final message =
        ModalRoute.of(context)?.settings.arguments as RemoteMessage?;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notificacion'),
        ),
        drawer: NavBar(
          // Puedes ajustar estos valores según tu lógica
          userEmail: userEmail,
          onExit: () {
            onExit(context);
          },
          userName: userName,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message?.notification?.title ??
                    'No tienes ninguna notificación',
              ),
              Text(message?.notification?.body ?? ''),
              Text('${message?.data ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}
