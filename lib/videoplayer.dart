// import 'package:flutter/material.dart';
//
// import 'package:media_kit/media_kit.dart';                      // Provides [Player], [Media], [Playlist] etc.
// import 'package:media_kit_video/media_kit_video.dart';
//
//
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Necessary initialization for package:media_kit.
//   MediaKit.ensureInitialized();
//   runApp(
//     const MaterialApp(
//       home: Videoplayer(),
//     ),
//   );
// }
//
//
// class Videoplayer extends StatefulWidget {
//   const Videoplayer({super.key});
//   @override
//   State<Videoplayer> createState() => MyScreenState();
// }
//
// class MyScreenState extends State<Videoplayer> {
//   // Create a [Player] to control playback.
//   late final player = Player();
//   // Create a [VideoController] to handle video output from [Player].
//   late final controller = VideoController(player);
//
//   @override
//   void initState() {
//     super.initState();
//     // Play a [Media] or [Playlist].
//     player.open(Media('http://194.163.40.124:8080/course_videos/1. क्या है ये शेयर मार्केट_.mp4'));
//   }
//
//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.width * 9.0 / 16.0,
//         // Use [Video] widget to display video output.
//         child: Video(controller: controller),
//       ),
//     );
//   }
// }