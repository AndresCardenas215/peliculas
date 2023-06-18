import 'package:cached_network_image/cached_network_image.dart'; // Importa la biblioteca CachedNetworkImage para cargar y mostrar imágenes en caché desde una URL remota.
import 'package:flutter/material.dart'; // Importa el paquete flutter/material.dart que contiene los widgets y utilidades fundamentales de Flutter.
import 'package:peliculas/models/series.dart'; // Importa el modelo de datos de las series.
import 'package:peliculas/services/webservices.dart'; // Importa el servicio web para obtener los datos de las series.
import 'package:provider/provider.dart'; // Importa el paquete provider para utilizar la funcionalidad de administración de estados.

class SeriesWidget extends StatelessWidget { // Define un widget de tipo StatelessWidget para mostrar las series.
  final String history; // Define una variable de tipo String llamada "history".

  const SeriesWidget({Key? key, required this.history}) : super(key: key); // Constructor del widget SeriesWidget.

  @override
  Widget build(BuildContext context) { // Método build que construye la interfaz del widget.
    return FutureBuilder<Seriest>( // Utiliza un FutureBuilder para manejar la carga asíncrona de los datos de las series.
      future: Provider.of<Webservice>(context).fetchSeriesTo(history), // Obtiene los datos de las series a través del servicio web.
      builder: (context, snapshot) { // Builder que define cómo se construye el widget en función del estado del Future.
        if (snapshot.hasData) { // Si el Future ha completado con éxito y tiene datos.
          final series = snapshot.data!; // Almacena los datos de las series en la variable "series".

          return ListView.builder( // Crea un ListView.builder para mostrar las series.
            itemCount: series.data.results.length, // Establece la cantidad de elementos en función de la longitud de la lista de resultados de las series.
            itemBuilder: (context, index) { // Builder que define cómo se construye cada elemento del ListView.
              final comic = series.data.results[index]; // Almacena los datos de una serie específica en la variable "comic".

              return Card( // Crea un Card para mostrar la información de la serie.
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Establece los márgenes del Card.
                shape: RoundedRectangleBorder( // Define la forma del Card con bordes redondeados.
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4, // Establece la elevación del Card para dar una apariencia tridimensional.
                child: Column( // Crea una columna para organizar los elementos dentro del Card.
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Alinea los elementos en la dirección horizontal.
                  children: [
                    const SizedBox(height: 8), // Agrega un SizedBox con una altura fija de 8 píxeles para crear un espacio.
                    Padding( // Agrega un Padding para dar un espacio alrededor del Texto.
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        comic.title ?? '', // Muestra el título de la serie.
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center, // Alinea el texto al centro.
                      ),
                    ),
                    const SizedBox(height: 4), // Agrega un SizedBox con una altura fija de 4 píxeles para crear un espacio.
                    if (comic.thumbnail != null) // Si la serie tiene una imagen de portada:
                      CachedNetworkImage( // Crea un CachedNetworkImage para cargar y mostrar la imagen de portada de la serie.
                        imageUrl: '${comic.thumbnail.path}.${comic.thumbnail.extension}', // URL de la imagen de portada.
                        fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor.
                        height: 200, // Establece la altura fija de la imagen.
                        placeholder: (context, url) => const CircularProgressIndicator(), // Widget de carga mientras se carga la imagen.
                        errorWidget: (context, url, error) => const Icon(Icons.error), // Widget que se muestra en caso de error al cargar la imagen.
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
}
