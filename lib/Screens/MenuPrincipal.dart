// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:fotoseventos/Screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/Navbar.dart';

class Inicio extends StatelessWidget {
  final String userName; // Nombre de usuario
  final String userEmail; // Correo electrónico del usuario

  Inicio({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onExit(BuildContext context) async {
      final prefs = await SharedPreferences.getInstance();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cerrar Sesión'),
            content: Text('¿Estás seguro de que deseas cerrar sesión?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                },
                child: Text('Cancelar'),
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
                child: Text('Cerrar Sesión'),
              ),
            ],
          );
        },
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: Text('FOTOGRAFIAS')),
        drawer: NavBar(
          userEmail: userEmail,
          onExit: () {
            onExit(context);
          },
          userName: userName,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGridItem(context, 'Ver las fotos en las que aparezco',
                    Icons.photo_library, () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => CameraView(
                  //       cameras: const [],
                  //     ),
                  //   ),
                  // );
                }),
                // _buildGridItem(
                //     context, 'Notificaciones', Icons.notification_add, () {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (BuildContext context) => Inicio(),
                //     ),
                //   );
                // }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, IconData iconData,
      Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 170,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 48.0, // Ajusta el tamaño del icono según tus necesidades
              color: Colors.blue, // Color del icono
            ),
            SizedBox(height: 10.0), // Espacio entre el icono y el título
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
