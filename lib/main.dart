import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_en/constant/thme.dart';
import 'package:learn_en/database/class_add.dart';
import 'package:learn_en/database/class_id.dart';
import 'package:learn_en/database/hive_setup.dart';
import 'package:learn_en/database/word_add_serv.dart';
import 'package:learn_en/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.initializeHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClasAddCubit()),
        BlocProvider(create: (context) => ClasIDCubit()),
        BlocProvider(create: (context) => WordCubbit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme, // Dark temayı uygula
        title: 'Material App',
        routerConfig: appRouter,
      ),
    );
  }
}
