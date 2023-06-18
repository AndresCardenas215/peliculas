import 'package:flutter/material.dart';
import 'package:peliculas/models/series.dart';
import 'package:provider/provider.dart';

import '../services/webservices.dart';
import '../view_models/web_models_provider.dart';


class ImageWithTitleSeries extends StatelessWidget {
  final int seriesId;
  final String general;

  const ImageWithTitleSeries({Key? key, required this.general, required this.seriesId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WebserviceProvider>(
      create: (context) => WebserviceProvider(),
      child: Consumer<WebserviceProvider>(
        builder: (context, webserviceProvider, _) {
          return FutureBuilder<Seriest>(
            future: webserviceProvider.fetchSeries(seriesId,general.toLowerCase()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final comics = snapshot.data!;
                return Scaffold(
                  appBar: AppBar(
                    title: Text(general),
                  ),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var comic in comics.data.results)
                            Container(
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
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: comic.thumbnail != null
                                        ? Image.network(
                                      '${comic.thumbnail.path}.${comic.thumbnail.extension.toString().toLowerCase().replaceAll('extension.', '')}',
                                      fit: BoxFit.cover,
                                    )
                                        : const Placeholder(),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      comic.title ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'Descripción: ${comic.description??''}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(general),
                  ),
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text(general),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}