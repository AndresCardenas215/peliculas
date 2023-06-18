import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir interfaces de usuario
import 'package:peliculas/models/peliculas.dart'; // Importa el modelo de datos de películas
import 'package:peliculas/services/webservices.dart'; // Importa los servicios web para obtener datos de películas
import 'package:provider/provider.dart'; // Importa el paquete para implementar el manejo de estado

import '../pages/character_description.dart'; // Importa la página de descripción del personaje

class HomeTabContentCharacters extends StatefulWidget {
  const HomeTabContentCharacters({Key? key}) : super(key: key);

  @override
  State<HomeTabContentCharacters> createState() => _HomeTabContentCharactersState();
}

class _HomeTabContentCharactersState extends State<HomeTabContentCharacters> {
  String textoBusqueda = ''; // Variable para almacenar el texto de búsqueda
  List<Result> peliculasFiltradas = []; // Lista para almacenar las películas filtradas

  @override
  void initState() {
    super.initState();
    final webservice = context.read<Webservice>(); // Obtener una instancia del servicio web a través del contexto
    peliculasFiltradas = webservice.peliculas?.data.results ?? []; // Asignar las películas filtradas obtenidas del servicio web
  }

  void filtrarPeliculas() {
    final webservice = context.read<Webservice>(); // Obtener una instancia del servicio web a través del contexto
    peliculasFiltradas = webservice.peliculas!.data.results.where((pelicula) { // Filtrar las películas según el nombre del personaje y el texto de búsqueda
      final nombrePersonaje = pelicula.name.toLowerCase(); // Obtener el nombre del personaje en minúsculas
      final busqueda = textoBusqueda.toLowerCase(); // Obtener el texto de búsqueda en minúsculas
      return nombrePersonaje.contains(busqueda); // Devolver true si el nombre del personaje contiene el texto de búsqueda
    }).toList() ?? []; // Convertir el resultado del filtrado en una lista y asignarlo a peliculasFiltradas
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Webservice>( // Escuchar los cambios en el estado de Webservice utilizando el widget Consumer
      builder: (context, webservice, _) {
        if (webservice.peliculas == null) { // Si las películas no están cargadas
          return const Center(child: CircularProgressIndicator()); // Mostrar un indicador de progreso
        } else if (webservice.peliculas!.data.results.isEmpty) { // Si no se encontraron personajes
          return const Center(child: Text("No se encontraron personajes")); // Mostrar un mensaje indicando que no se encontraron personajes
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      textoBusqueda = value; // Actualizar el texto de búsqueda
                      filtrarPeliculas(); // Filtrar las películas según el nuevo texto de búsqueda
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar personaje',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Lógica de búsqueda adicional si es necesario
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: peliculasFiltradas.map((pelicula) { // Mapear cada película filtrada a un widget
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CharacterDetailScreen(pelicula: pelicula), // Navegar a la página de descripción del personaje al hacer clic en el widget
                            ),
                          );
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
                                    child: Image.network(
                                      "${pelicula.thumbnail.path}.${pelicula.thumbnail.extension.toString().toLowerCase().replaceAll('extension.', '')}", // URL de la imagen construida utilizando el path y la extensión del objeto thumbnail de la película
                                      fit: BoxFit.cover, // Ajuste de la imagen para que cubra completamente el contenedor
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child; // Devuelve la imagen una vez que se haya cargado completamente
                                        }
                                        return const Center(child: CircularProgressIndicator()); // Muestra un indicador de progreso mientras la imagen se está cargando
                                      },
                                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                        return const Icon(Icons.error); // Muestra un ícono de error si ocurre un problema al cargar la imagen
                                      },
                                    ),

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pelicula.name,
                                        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'ABOUT CHARACTERS',
                                        style: TextStyle(fontSize: 14, color: Colors.red),
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
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
