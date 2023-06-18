import 'package:flutter/material.dart';
import 'package:peliculas/models/stories.dart';
import 'package:provider/provider.dart';

import '../services/webservices.dart';
import '../view_models/web_models_provider.dart';

class ImageWithTitleStories extends StatefulWidget {
  final int storiesId;
  final String general;

  const ImageWithTitleStories({Key? key, required this.general, required this.storiesId}) : super(key: key);

  @override
  State<ImageWithTitleStories> createState() => _ImageWithTitleStoriesState();
}

class _ImageWithTitleStoriesState extends State<ImageWithTitleStories> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WebserviceProvider>(
      create: (context) => WebserviceProvider(),
      child: Consumer<WebserviceProvider>(
        builder: (context, webserviceProvider, _) {
          return FutureBuilder<Storiest>(
            future: webserviceProvider.fetchStories(widget.storiesId, widget.general.toLowerCase()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final comics = snapshot.data!;
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.general),
                  ),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < comics.data.results.length; i++)
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: _getCardColor(i),
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
                                      comics.data.results[i].title ?? '',
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
                                      comics.data.results[i].type ?? '',
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
                    title: Text(widget.general),
                  ),
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.general),
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

  Color? _getCardColor(int index) {
    final colors = [
      Colors.blue[100],
      Colors.green[100],
      Colors.pink[100],
      Colors.orange[100],
    ];

    return colors[index % colors.length];
  }
}
