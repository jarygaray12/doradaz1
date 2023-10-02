import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Producto {
  final String nombre;
  final double precio;
  final String imagenUrl;
  final Color bordeColor;

  Producto({
    required this.nombre,
    required this.precio,
    required this.imagenUrl,
    required this.bordeColor,
  });
}

class ArepaPage extends StatefulWidget {
  @override
  _ArepaPageState createState() => _ArepaPageState();
}

class _ArepaPageState extends State<ArepaPage> {
  final List<Producto> productos = [
    Producto(
      nombre: 'Arepa de Carne',
      precio: 3.99,
      imagenUrl: 'assets/arepa_carne.png',
      bordeColor: Colors.blue,
    ),
    Producto(
      nombre: 'Arepa de Pollo',
      precio: 3.49,
      imagenUrl: 'assets/arepa_pollo.png',
      bordeColor: Color.fromARGB(255, 255, 0, 0),
    ),
    Producto(
      nombre: 'Arepa de Queso',
      precio: 2.99,
      imagenUrl: 'assets/arepa_queso.png',
      bordeColor: Colors.red,
    ),
    Producto(
      nombre: 'Arepa de Champiñones',
      precio: 3.79,
      imagenUrl: 'assets/arepa_champinones.png',
      bordeColor: Colors.orange,
    ),
  ];

  // Lista de estados para llevar el seguimiento de la cantidad de cada producto
  List<int> cantidades = List<int>.generate(4, (index) => 1);

  Future<void> _launchWhatsApp(BuildContext context) async {
    final whatsappUrl = Uri.parse("https://wa.me/+573142179208");
    if (await canLaunch(whatsappUrl.toString())) {
      await launch(whatsappUrl.toString());
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("No se pudo abrir WhatsApp."),
            actions: <Widget>[
              TextButton(
                child: Text("Cerrar"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arepas'),
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];

          double calcularPrecioTotal() {
            return cantidades[index] * producto.precio;
          }

          void incrementCantidad() {
            setState(() {
              cantidades[index]++;
            });
          }

          void decrementCantidad() {
            setState(() {
              if (cantidades[index] > 1) {
                cantidades[index]--;
              }
            });
          }

          void _launchURL(String url) async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'No se pudo abrir la URL: $url';
            }
          }

          return Card(
            color: producto.bordeColor,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    producto.imagenUrl,
                    height: 150,
                  ),
                  Text(
                    producto.nombre,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Precio unitario: \$${producto.precio.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 255, 145),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: decrementCantidad,
                      ),
                      Text(
                        cantidades[index].toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: incrementCantidad,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Precio total: \$${calcularPrecioTotal().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      String mensaje = Uri.encodeComponent(
                        'Hola, me gustaría comprar ${cantidades[index]}x ${producto.nombre} por un total de \$${calcularPrecioTotal().toStringAsFixed(2)}.',
                      );
                      _launchURL('https://wa.me/+573223964172?text=$mensaje');
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text('Comprar', style: TextStyle(fontSize: 15.0)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ArepaPage(),
  ));
}
