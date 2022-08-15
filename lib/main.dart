import 'package:flutter/material.dart';
import 'package:jsondata_flutter/Src/Chara/List.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: CharaList(),
        ),
      ),
    );
  }
}