import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Producto {
  final String nombre;
  final double precio;
  final String imagenUrl;
  final Color bordeColor;
  final String descripcion;

  Producto({
    required this.nombre,
    required this.precio,
    required this.imagenUrl,
    required this.bordeColor,
    required this.descripcion,
  });
}

class EmpanadaPage extends StatefulWidget {
  @override
  _EmpanadaPageState createState() => _EmpanadaPageState();
}

class _EmpanadaPageState extends State<EmpanadaPage> {
  final List<Producto> productos = [
    Producto(
      nombre: 'Empanada de Carne',
      precio: 2.99,
      imagenUrl: 'assets/img/p.png',
      bordeColor: Colors.blue,
      descripcion: 'Deliciosa empanada rellena de carne.',
    ),
    Producto(
      nombre: 'Empanada de Pollo',
      precio: 2.49,
      imagenUrl: 'assets/img/y.png',
      bordeColor: Colors.green,
      descripcion: 'Exquisita empanada rellena de pollo.',
    ),
    Producto(
      nombre: 'Empanada de Queso',
      precio: 1.99,
      imagenUrl: 'assets/img/p.png',
      bordeColor: Colors.red,
      descripcion: 'Sabrosa empanada rellena de queso.',
    ),
    Producto(
      nombre: 'Empanada de Champiñones',
      precio: 2.79,
      imagenUrl: 'assets/img/logo.png',
      bordeColor: Colors.orange,
      descripcion: 'Deliciosa empanada rellena de champiñones.',
    ),
  ];

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

  void _showDescriptionModal(BuildContext context, Producto producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(producto.nombre),
          content: Text(producto.descripcion),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empanada'),
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
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: producto.bordeColor,
                      width: 2.0,
                    ),
                  ),
                  child: Image.asset(
                    producto.imagenUrl,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            producto.nombre,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.info_outline),
                            onPressed: () {
                              _showDescriptionModal(context, producto);
                            },
                          ),
                        ],
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
                          _launchURL(
                              'https://wa.me/+573223964172?text=$mensaje');
                        },
                        icon: Icon(Icons.shopping_cart),
                        label:
                            Text('Comprar', style: TextStyle(fontSize: 15.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EmpanadaPage(),
  ));
}
