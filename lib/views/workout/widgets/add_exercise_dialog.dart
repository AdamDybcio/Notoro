import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/core/helpers/custom_snackbar.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/exercise_model.dart';

import '../../../models/workout/body_part.dart';

class AddExerciseDialog extends StatefulWidget {
  final BuildContext parentContext;
  const AddExerciseDialog({super.key, required this.parentContext});

  @override
  State<AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final TextEditingController nameController = TextEditingController();
  final Set<BodyPart> selectedParts = {};

  void togglePart(BodyPart part) {
    setState(() {
      if (selectedParts.contains(part)) {
        selectedParts.remove(part);
      } else {
        selectedParts.add(part);
      }
    });
  }

  void submit() {
    final name = nameController.text.trim();
    final parts = selectedParts.toList();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar.show(
            context: context, message: AppStrings.exerciseNameEmpty),
      );
      return;
    }
    if (parts.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar.show(context: context, message: AppStrings.addOnePart),
      );
      return;
    }

    final existing = BlocProvider.of<WorkoutBuilderBloc>(widget.parentContext)
        .state
        .availableExercises;

    final nameAlreadyExists = existing.any(
      (exercise) => exercise.name.toLowerCase() == name.toLowerCase(),
    );

    if (nameAlreadyExists) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar.show(
          context: context,
          message: AppStrings.exerciseAlreadyExists,
        ),
      );
      return;
    }

    final newExercise = ExerciseModel(
      name: name,
      bodyParts: parts,
      assetImagePath: '',
      isCustom: true,
    );

    BlocProvider.of<WorkoutBuilderBloc>(widget.parentContext)
        .add(AddAvailableExercise(newExercise));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.addExercise),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              controller: nameController,
              decoration: const InputDecoration(
                labelText: AppStrings.exerciseName,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 4,
              runSpacing: -2,
              children: BodyPart.values
                  .map((part) => FilterChip(
                        label: Text(Helpers.mapBodyPartToName(part)),
                        avatar: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            Helpers.mapBodyPartToString(part),
                            width: 20,
                            height: 20,
                          ),
                        ),
                        selected: selectedParts.contains(part),
                        onSelected: (_) => togglePart(part),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: submit,
          child: const Text(AppStrings.add),
        ),
      ],
    );
  }
}
