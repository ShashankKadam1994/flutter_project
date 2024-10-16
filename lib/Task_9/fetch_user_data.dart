import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_9/fetch_movie_service.dart';
import 'package:flutter_task1/Task_9/user_data_model.dart';
import 'package:flutter_task1/Task_9/widgets/movie_card.dart';
import 'package:flutter_task1/utilility/error_modal.dart';

class FetchUserData extends StatefulWidget {
  const FetchUserData({super.key});

  @override
  State<FetchUserData> createState() => _FetchUserData();
}

class _FetchUserData extends State<FetchUserData> {
  @override
  void initState() {
    super.initState();
    changeStationFunction();
  }

  List<Movie> MovieData = [];

  Future<void> changeStationFunction() async {
    try {
      final movieData = await FetchMovieService.fetchMovie();
      setState(() {
        MovieData = movieData;
      });
    } catch (e) {
      showErrorModal(context, '$e', "Error", (){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Movie Data Screen")),
        elevation: 50,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1; 
          double screenWidth = MediaQuery.of(context).size.width;

          if (screenWidth >= 600) {
            crossAxisCount = 2;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0, 
                children: MovieData.map((movie) {
                  return Container(
                    width: (constraints.maxWidth / crossAxisCount) -
                        16, 
                    child:
                     MovieCard(
                      movieData: movie,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
