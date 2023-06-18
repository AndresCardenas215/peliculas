import 'package:flutter/material.dart'; // Importa el paquete flutter/material.dart que contiene los widgets y utilidades fundamentales de Flutter.
import 'package:peliculas/models/stories.dart'; // Importa el modelo de datos de las historias.
import 'package:peliculas/services/webservices.dart'; // Importa el servicio web para obtener los datos de las historias.
import 'package:provider/provider.dart'; // Importa el paquete provider para utilizar la funcionalidad de administración de estados.

class StoriesWidget extends StatelessWidget { // Define un widget de tipo StatelessWidget para mostrar las historias.
  final String history; // Define una variable de tipo String llamada "history".

  const StoriesWidget({Key? key, required this.history}) : super(key: key); // Constructor del widget StoriesWidget.

  @override
  Widget build(BuildContext context) { // Método build que construye la interfaz del widget.
    return FutureBuilder<Storiest>( // Utiliza un FutureBuilder para manejar la carga asíncrona de los datos de las historias.
      future: Provider.of<Webservice>(context).fetchStoriesTo(history), // Obtiene los datos de las historias a través del servicio web.
      builder: (context, snapshot) { // Builder que define cómo se construye el widget en función del estado del Future.
        if (snapshot.hasData) { // Si el Future ha completado con éxito y tiene datos.
          final series = snapshot.data!; // Almacena los datos de las historias en la variable "series".

          return ListView.builder( // Crea un ListView.builder para mostrar las historias.
            itemCount: series.data.results.length, // Establece la cantidad de elementos en función de la longitud de la lista de resultados de las historias.
            itemBuilder: (context, index) { // Builder que define cómo se construye cada elemento del ListView.
              final comic = series.data.results[index]; // Almacena los datos de una historia específica en la variable "comic".
              final color = _getCardColor(index); // Obtiene el color de fondo para el Card en función del índice.

              return Card( // Crea un Card para mostrar la información de la historia.
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Establece los márgenes del Card.
                shape: RoundedRectangleBorder( // Define la forma del Card con bordes redondeados.
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4, // Establece la elevación del Card para dar una apariencia tridimensional.
                color: color, // Establece el color de fondo del Card.
                child: Column( // Crea una columna para organizar los elementos dentro del Card.
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Alinea los elementos en la dirección horizontal.
                  children: [
                    const SizedBox(height: 8), // Agrega un SizedBox con una altura fija de 8 píxeles para crear un espacio.
                    Padding( // Agrega un Padding para dar un espacio alrededor del Texto.
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        comic.title ?? '', // Muestra el título de la historia.
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center, // Alinea el texto al centro.
                      ),
                    ),
                    const SizedBox(height: 16), // Agrega un SizedBox con una altura fija de 16 píxeles para crear un espacio.
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) { // Si el Future ha completado con un error.
          return Text('Error: ${snapshot.error}'); // Muestra un mensaje de error.
        }

        return const Center( // Si el Future aún no ha completado, muestra un CircularProgressIndicator en el centro.
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Color? _getCardColor(int index) { // Método privado que devuelve el color de fondo para el Card en función del índice.
    final colors = [
      Colors.pink[100],
      Colors.blue[100],
      Colors.green[100],
      Colors.orange[100],
      Colors.purple[100],
    ];

    return colors[index % colors.length]; // Devuelve el color correspondiente al índice utilizando el operador módulo para ciclar a través de los colores disponibles.
  }
}
