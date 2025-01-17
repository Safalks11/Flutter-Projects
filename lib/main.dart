import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safal_portfolio/screens/home.dart';
import 'package:safal_portfolio/screens/profile/bloc/profile_bloc.dart';
import 'package:safal_portfolio/screens/widgets/rotating_image/rotating_image_bloc.dart';
import 'package:safal_portfolio/screens/widgets/services/services_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAZu3GuIebwdkFnRqalzcXcyV0yy6GrzTg",
          projectId: "safal-personal-portfolio",
          appId: "1:825554806567:web:1b43c4bfd8340063856b02",
          messagingSenderId: '825554806567',
          databaseURL:
              'https://safal-personal-portfolio-default-rtdb.firebaseio.com/'));
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProfileBloc>(
        create: (BuildContext context) =>
            ProfileBloc()..add(FetchProfileData()),
      ),
      BlocProvider<ServicesBloc>(
        create: (BuildContext context) =>
            ServicesBloc()..add(FetchServicesData()),
      ),
      BlocProvider<RotatingImageBloc>(
        create: (BuildContext context) =>
            RotatingImageBloc()..add(FetchProfileImg()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        // '/gallery': (context) => ProjectsScreen(),
      },
    );
  }
}
