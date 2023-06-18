import 'package:flutter/material.dart';
import 'package:peliculas/pages/movie_list_page.dart';
import 'package:peliculas/services/webservices.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Webservice(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies",
      debugShowCheckedModeBanner: false,
      home: MovieListPage(),
    );
  }
}



