import 'package:flutter/material.dart';
import 'package:flutter_doc_prac/pages/novelView.dart';
import 'package:flutter_doc_prac/pages/novelViewProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NovelViewProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Novel',
        home: NovelView(),
      ),
    );
  }
}
