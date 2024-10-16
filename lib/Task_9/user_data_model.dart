import 'dart:convert';

class Movie {
  final int id;
  final String movie;
  final double rating;
  final String image;
  final String imdbUrl;

  Movie({
    required this.id,
    required this.movie,
    required this.rating,
    required this.image,
    required this.imdbUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      movie: json['movie'],
      rating: json['rating'].toDouble(),
      image: json['image'],
      imdbUrl: json['imdb_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'movie': movie,
      'rating': rating,
      'image': image,
      'imdb_url': imdbUrl,
    };
  }
}
