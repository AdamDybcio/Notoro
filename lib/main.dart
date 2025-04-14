import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_bloc.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_event.dart';
import 'package:notoro/core/utils/theme/app_theme.dart';
import 'package:notoro/models/dashboard/weekly_plan.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/models/workout/body_part.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

import 'controllers/navbar/navbar_cubit.dart';
import 'models/workout/exercise_model.dart';
import 'models/workout/workout_model.dart';
import 'views/navbar_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutModelAdapter());
  Hive.registerAdapter(ExerciseTrainingModelAdapter());
  Hive.registerAdapter(BodyPartAdapter());
  Hive.registerAdapter(ExerciseModelAdapter());
  Hive.registerAdapter(WeeklyPlanAdapter());
  Hive.registerAdapter(DayOfWeekAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  await Hive.openBox<WeeklyPlan>('user_plan');
  await Hive.openBox<WorkoutModel>('workouts');
  await Hive.openBox<HistoryModel>('workout_history');

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
          BlocProvider<WeeklyPlanBloc>(
            create: (context) => WeeklyPlanBloc(
              planBox: Hive.box<WeeklyPlan>('user_plan'),
              workoutBox: Hive.box<WorkoutModel>('workouts'),
            )..add(LoadWeeklyPlan()),
          ),
          BlocProvider<NavbarCubit>(
            create: (_) => NavbarCubit(),
          ),
        ],
        child: const NavbarView(),
      ),
    );
  }
}
