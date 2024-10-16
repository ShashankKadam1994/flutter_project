import 'package:flutter_task1/Task_9/user_data_model.dart';
import 'package:flutter_task1/services/api_exception.dart';
import 'package:flutter_task1/services/api_services.dart';

class FetchMovieService {
  static Future<List<Movie>> fetchMovie(
  ) async {
    try{
        final responseJson =await ApiService.get('/movies',{});
        final List<dynamic> data = responseJson;
        final List<Movie> userArray = data.map((item) {
          return Movie.fromJson(item);
        }).toList();
      return userArray;
    }
     on ApiException catch (e) {
      throw (e.message);
    }
    catch(e){
      rethrow;
    }
  }

}
