import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widget_stories.dart';
import 'package:peliculas/widgets/widgets_comics.dart';
import 'package:peliculas/widgets/widgets_items.dart';
import 'package:provider/provider.dart';

import '../services/webservices.dart';

class HomeTabContentHome extends StatefulWidget {
  const HomeTabContentHome({Key? key}) : super(key: key);

  @override
  State<HomeTabContentHome> createState() => _HomeTabContentHomeState();
}

class _HomeTabContentHomeState extends State<HomeTabContentHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Webservice>(
      builder: (context, webservice, _) {
        if (webservice.peliculas == null) {
          return const Center(child: CircularProgressIndicator()); // Indicador de carga mientras se obtienen los datos de la API
        } else if (webservice.peliculas!.data.results.isEmpty) {
          return const Center(child: Text("No se encontraron personajes")); // Mensaje que se muestra si no hay personajes disponibles
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Scroll horizontal
            child: Row(
              children: webservice.peliculas!.data.results.map((pelicula) {
                return GestureDetector(
                  onTap: () async {
                    // Acción al hacer clic en un personaje (a implementar)
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  // Imagen del personaje
                                  Image.network(
                                    "${pelicula.thumbnail.path}.${pelicula.thumbnail.extension.toString().toLowerCase().replaceAll('extension.', '')}",
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const Center(child: CircularProgressIndicator()); // Indicador de carga mientras se carga la imagen
                                    },
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return const Icon(Icons.error); // Icono de error si no se puede cargar la imagen
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Acción al hacer clic en "Comics"
                                        try {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ImageWithTitleComics(
                                                comicsId: pelicula.id,
                                                general: 'COMICS',
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          // Manejo de errores
                                          print('Error en la sección del código: $e');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                      ),
                                      child: const Text('Comics'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Acción al hacer clic en "Series"
                                        try {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ImageWithTitleSeries(
                                                seriesId: pelicula.id,
                                                general: 'SERIES',
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          // Manejo de errores
                                          print(e.toString());
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        onPrimary: Colors.white,
                                      ),
                                      child: const Text('Series'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Acción al hacer clic en "Stories"
                                        try {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ImageWithTitleStories(
                                                storiesId: pelicula.id,
                                                general: 'STORIES',
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          // Manejo de errores
                                          print(e.toString());
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.orange,
                                        onPrimary: Colors.white,
                                      ),
                                      child: const Text('Stories'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
