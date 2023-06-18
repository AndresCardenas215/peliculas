import 'package:flutter/material.dart';
import 'package:peliculas/models/peliculas.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Result pelicula; // Objeto Result que representa la película

  const CharacterDetailScreen({Key? key, required this.pelicula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pelicula.name), // Título de la barra de aplicación que muestra el nombre de la película
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "${pelicula.thumbnail.path}.${pelicula.thumbnail.extension.toString().toLowerCase().replaceAll('extension.', '')}",
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la imagen
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return const Icon(Icons.error); // Muestra un ícono de error si la imagen no se carga correctamente
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Comics:', // Título de la sección de "Comics"
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: pelicula.comics.items.map((e) {
                  return Chip(
                    label: Text(
                      e.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    backgroundColor: Colors.blue, // Color de fondo de los chips de "Comics"
                    labelStyle: const TextStyle(color: Colors.white), // Color del texto de los chips de "Comics"
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Series:', // Título de la sección de "Series"
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: pelicula.series.items.map((e) {
                  return Chip(
                    label: Text(
                      e.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    backgroundColor: Colors.green, // Color de fondo de los chips de "Series"
                    labelStyle: const TextStyle(color: Colors.white), // Color del texto de los chips de "Series"
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Stories:', // Título de la sección de "Stories"
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: pelicula.stories.items.map((e) {
                  return Chip(
                    label: Text(
                      e.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    backgroundColor: Colors.orange, // Color de fondo de los chips de "Stories"
                    labelStyle: const TextStyle(color: Colors.white), // Color del texto de los chips de "Stories"
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Descripción:', // Título de la sección de "Descripción"
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                pelicula.description ?? '', // Texto de la descripción de la película
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
