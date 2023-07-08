import 'package:flutter/material.dart';
import 'package:newsapp/screens/tabs_screen.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:newsapp/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        home: const TabsScreen(),
        theme: myTheme,
      ),
    );
  }
}
