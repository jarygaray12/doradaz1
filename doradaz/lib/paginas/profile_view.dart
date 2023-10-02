import 'package:flutter/material.dart';
import 'package:doradaz/screens/signin_screen.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.yellow,
              Colors.white
            ], // Degradado amarillo a blanco
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img/logo.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Nombre de Usuario',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '@alias',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            _buildSocialMediaLinks(),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.yellow,
                    Colors.red
                  ], // Degradado amarillo a rojo
                ),
              ),
              child: Text(
                'Menú de Opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Cierra el menú lateral y navega a la pantalla de registro
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Información de la Aplicación'),
              onTap: () {
                // Cierra el menú lateral y muestra un modal con la información de la aplicación
                Navigator.pop(context);
                _showAppInfoModal(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialMediaLink(
          icon: Icons.tiktok,
          url: 'https://www.tiktok.com/es/',
        ),
        _buildSocialMediaLink(
          icon: Icons.facebook_outlined,
          url: 'https://www.instagram.com/usuario',
        ),
        _buildSocialMediaLink(
          icon: Icons.youtube_searched_for_outlined,
          url: 'https://twitter.com/usuario',
        ),
      ],
    );
  }

  Widget _buildSocialMediaLink({required IconData icon, required String url}) {
    return GestureDetector(
      onTap: () {
        // Abre el enlace en el navegador o aplicación de redes sociales
        // Puedes usar el paquete url_launcher para esto.
        // Consulta la documentación aquí: https://pub.dev/packages/url_launcher
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 32,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _showAppInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información de la Aplicación'),
          content:
              Text('Come sin parar, y asi nuestros bolsillos poder llenar.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
