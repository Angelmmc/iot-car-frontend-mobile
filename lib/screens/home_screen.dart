import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end_iot/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String ip = '54.198.159.79:5000/iot';

List<String> stateList = [
  'Giro izquierda 90°',
  'Avanzar',
  'Giro derecha 90°',
  'Giro Izquierda',
  'Detenerse',
  'Giro derecha',
  'Giro izquierda 360°',
  'Retroceder',
  'Giro derecha 360°'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  List<ApiResponse> apiResponses = []; // Almacenará la respuesta de la API
  String selectedUrl = 'http://$ip/last'; // URL inicial
  final List<String> urls = [
    'http://$ip/10',
    'http://$ip/last' // URL alternativa
  ];
  String selectedConsult = 'Ultimo registro';
  final List<String> consult = [
    'Ultimos 10 registros',
    'Ultimo registro' // URL alternativa
  ];

  @override
  void initState() {
    super.initState();
    fetchApiResponses(); // Llama a la API al cargar la pantalla
  }

  void toggleUrl() {
    setState(() {
      if (selectedUrl == urls[0]) {
        selectedUrl = urls[1];
        selectedConsult = consult[1];
      } else {
        selectedUrl = urls[0];
        selectedConsult = consult[0];
      }
    });
  }

  // Función para obtener los datos de la API
  Future<void> fetchApiResponses() async {
    setState(() {
      apiResponses =
          []; // Vacía las tarjetas actuales antes de la nueva solicitud
    });

    try {
      final response = await http.get(Uri.parse(selectedUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Verificamos si la respuesta es una lista o un solo objeto
          if (data is List) {
            // Si es una lista, mapeamos cada elemento
            apiResponses =
                data.map((json) => ApiResponse.fromJson(json)).toList();
          } else if (data is Map<String, dynamic>) {
            // Si es un solo objeto, lo convertimos en una lista de uno
            apiResponses = [ApiResponse.fromJson(data)];
          }
        });
      } else {
        //print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      //print('Error al realizar la solicitud: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Control de carro IoT',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 255, 75, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Primer Container
            // Segundo Container que contiene el diseño original
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Adriel, Alejandro, Beto...',
                      labelText: 'Ingresa tu nombre aquí',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          postData(1);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 48, 131, 149),
                        ),
                        child: const Icon(
                          Icons.rotate_90_degrees_ccw_sharp,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          postData(2);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 56, 116, 244),
                        ),
                        child: const Icon(
                          Icons.keyboard_double_arrow_up_sharp,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          postData(3);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 48, 131, 149),
                        ),
                        child: const Icon(
                          Icons.rotate_90_degrees_cw_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          postData(4);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 56, 116, 244),
                        ),
                        child: const Icon(
                          Icons.keyboard_double_arrow_left_outlined,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          postData(5);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 209, 61, 70),
                        ),
                        child: const Icon(
                          Icons.stop,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          postData(6);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 56, 116, 244),
                        ),
                        child: const Icon(
                          Icons.keyboard_double_arrow_right_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          postData(7);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 48, 131, 149),
                        ),
                        child: const Icon(
                          Icons.rotate_left,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          postData(8);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 56, 116, 244),
                        ),
                        child: const Icon(
                          Icons.keyboard_double_arrow_down_outlined,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          postData(9);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 48, 131, 149),
                        ),
                        child: const Icon(
                          Icons.rotate_right_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Contenedor para mostrar las tarjetas con los datos de la API
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                children: [
                  const Text(
                    'Consulta seleccionada:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    selectedConsult,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          toggleUrl();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 75, 0)),
                        child: const Text(
                          'Cambiar Consulta',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Contenedor para mostrar las tarjetas con los datos de la API
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              child: apiResponses.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Estado')),
                          DataColumn(label: Text('Fecha')),
                          DataColumn(label: Text('Nombre')),
                          DataColumn(label: Text('IP Cliente')),
                          DataColumn(label: Text('ID del Dispositivo')),
                        ],
                        rows: apiResponses.map((apiResponse) {
                          return DataRow(cells: [
                            DataCell(Text(apiResponse.id.toString())),
                            DataCell(Text(stateList[apiResponse.status - 1])),
                            DataCell(Text(apiResponse.date)),
                            DataCell(Text(apiResponse.name)),
                            DataCell(Text(apiResponse.ipCliente)),
                            DataCell(Text(apiResponse.idDevice)),
                          ]);
                        }).toList(),
                      ))
                  : const Center(
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 255, 75, 0))),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: fetchApiResponses,
        backgroundColor: const Color.fromARGB(255, 255, 75, 0),
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast
          .LENGTH_SHORT, // Usa LENGTH_SHORT para reducir el tiempo predeterminado
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.5), // Fondo con transparencia
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Temporizador personalizado para que se muestre por 1 segundo exacto
    Future.delayed(const Duration(seconds: 1), () {
      Fluttertoast.cancel(); // Cancela el toast después de 1 segundo
    });
  }

  Future<void> postData(int stts) async {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Por favor escribe tu nombre',
        toastLength: Toast.LENGTH_SHORT, // Longitud del toast
        gravity: ToastGravity.BOTTOM, // Posición del toast
        backgroundColor: Colors.black.withOpacity(0.5), // Color de fondo
        textColor: Colors.white, // Color del texto
        fontSize: 16.0, // Tamaño de la fuente
      );
    } else {
      // Definimos la URL de la API de Ipify
      const String ipifyUrl = 'https://api.ipify.org?format=json';

      try {
        // Realizamos la solicitud GET para obtener la IP
        final ipResponse = await http.get(Uri.parse(ipifyUrl));

        // Comprobamos el estado de la respuesta
        if (ipResponse.statusCode == 200) {
          // Decodificamos la respuesta JSON
          final ipData = json.decode(ipResponse.body);
          final String ipCliente = ipData['ip']; // Extraemos la IP

          // Definimos la URL de la API para la solicitud POST
          const String postUrl = 'http://$ip';

          // Creamos el cuerpo de la solicitud
          final Map<String, dynamic> data = {
            'status': stts,
            'ip_cliente': ipCliente, // Usamos la IP obtenida
            'name': nameController.text,
          };

          // Convertimos el mapa a JSON
          final String jsonBody = json.encode(data);

          // Realizamos la solicitud POST
          final response = await http.post(
            Uri.parse(postUrl),
            headers: {
              'Content-Type':
                  'application/json', // Establecemos el tipo de contenido
            },
            body: jsonBody,
          );

          // Comprobamos el estado de la respuesta
          if (response.statusCode == 201) {
            //print('Solicitud exitosa: ${response.body}');
            showToastMessage(stateList[stts - 1]);
          } else {
            //print('Error en la solicitud: ${response.statusCode}');
          }
        } else {
          //print('Error al obtener la IP: ${ipResponse.statusCode}');
        }
      } catch (error) {
        //print('Error al realizar la solicitud: $error');
      }
    }
  }
}
