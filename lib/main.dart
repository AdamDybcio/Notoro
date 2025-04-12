import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notoro/core/utils/theme/app_theme.dart';
import 'package:notoro/models/workout/body_part.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

import 'controllers/navbar/navbar_cubit.dart';
import 'models/workout/workout_model.dart';
import 'views/navbar_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutModelAdapter());
  Hive.registerAdapter(ExerciseTrainingModelAdapter());
  Hive.registerAdapter(BodyPartAdapter());
  await Hive.openBox<WorkoutModel>('workouts');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notoro',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NavbarCubit>(
            create: (_) => NavbarCubit(),
          ),
        ],
        child: const NavbarView(),
      ),
    );
  }
}
