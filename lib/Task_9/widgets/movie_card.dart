import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_9/user_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieCard extends StatefulWidget {
  final Movie movieData;

  const MovieCard({
    Key? key,
    required this.movieData,
  }) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    print('Attempting to launch: $url');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.network(
                  widget.movieData.image,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/imageNotFound.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Movie Name : " + widget.movieData.movie.toString()),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Movie Rating : " + widget.movieData.rating.toString()),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: "IMDB url : "),
                      TextSpan(
                        text: "Click here.",
                        style: const TextStyle(
                          color: Colors.blueGrey,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _launchUrl(widget.movieData.imdbUrl);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
