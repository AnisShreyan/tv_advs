import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_tv_app/PlayedVideo.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var setPreferredOrientations = SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<String> getvidUrl() async {
  var res =
      await Dio().get("https://dev.dokume.in/video/server/uploads/advs.json");
  return res.data["name"];
}

StreamController<String> vidApiStream = StreamController<String>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: FutureBuilder(
            future: getvidUrl(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return PlayVideoWidget(
                    url:
                        'https://dev.dokume.in/video/server/uploads/${snapshot.data}');
              }
              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
}
