import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/peliculas.dart';
import '../services/webservices.dart';
import '../widgets/home_tab_content_characters.dart';
import '../widgets/home_tab_content_comics.dart';
import '../widgets/home_tab_content_home.dart';
import '../widgets/home_tab_content_series.dart';
import '../widgets/home_tab_content_stories.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabTitles = [
    "HOME",
    "CHARACTERS",
    "COMICS",
    "SERIES",
    "STORIES"
  ];

  Peliculas? _peliculas;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    fetchMovies(); // Obtener los datos de las películas al inicializar la pantalla
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchMovies() async {
    final webservice = Provider.of<Webservice>(context, listen: false);
    try {
      final peliculas = await webservice.fetchMovies();
      setState(() {
        _peliculas = peliculas;
      });
    } catch (e) {
      // Manejo de errores
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MARVEL",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const NetworkImage(
                'https://media.revistagq.com/photos/5ca5f1b3f46488687cf49211/16:9/pass/peliculas_mas_taquilleras_5260.jpg',
              ),
              fit: BoxFit.cover,
              onError: (_, __) => const AssetImage(
                'assets/images/fondo.webp',
              ),
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true, // Permite desplazar los títulos si hay muchos
          tabs: _tabTitles.map((title) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:  <Widget>[
          // Contenido de la pestaña HOME
          HomeTabContentHome(),
          // Contenido de la pestaña CHARACTERS
          HomeTabContentCharacters(),
          // Contenido de la pestaña COMICS
          const ComicsWidget(history: 'comics'),
          // Contenido de la pestaña SERIES
          const SeriesWidget(history: 'series'),
          // Contenido de la pestaña STORIES
          const StoriesWidget(history: 'stories')
        ],
      ),
    );
  }
}
