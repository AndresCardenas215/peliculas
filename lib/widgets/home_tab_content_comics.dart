import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/models/comics.dart';
import 'package:peliculas/services/webservices.dart';


class ComicsWidget extends StatelessWidget {
  final String history;

  const ComicsWidget({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Comicst>(
      future: Provider.of<Webservice>(context).fetchComicsTo(history), // Se obtiene un Future que representa la llamada a la API para obtener los cómics relacionados con la historia
      builder: (context, snapshot) {
        if (snapshot.hasData) { // Si los datos están disponibles
          final series = snapshot.data!; // Se obtiene el objeto de datos de la respuesta
          return ListView.builder(
            itemCount: series.data.results.length, // Cantidad de cómics en los resultados obtenidos
            itemBuilder: (context, index) {
              final comic = series.data.results[index]; // Se obtiene el cómic en el índice actual

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        comic.title ?? '', // Título del cómic (si está disponible)
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 4),
                    CachedNetworkImage(
                      imageUrl: '${comic.thumbnail.path}.${comic.thumbnail.extension}', // URL de la imagen del cómic
                      fit: BoxFit.cover,
                      height: 200,
                      placeholder: (context, url) => const CircularProgressIndicator(), // Widget de carga mientras se carga la imagen
                      errorWidget: (context, url, error) => const Icon(Icons.error), // Widget de error si no se puede cargar la imagen
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) { // Si se produce un error durante la obtención de los datos
          return Text('Error: ${snapshot.error}'); // Mostrar mensaje de error
        }

        return const Center(
          child: CircularProgressIndicator(), // Indicador de carga mientras se obtienen los datos
        );
      },
    );
  }
}
