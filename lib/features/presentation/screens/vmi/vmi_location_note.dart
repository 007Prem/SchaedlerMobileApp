// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/vmi_location_note/vmi_location_note_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/vmi_location_note/vmi_location_note_state.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';

class VmiLocationNoteScreen extends StatelessWidget {
  final void Function() onVMILocationNoteUpdated;
  const VmiLocationNoteScreen({
    super.key,
    required this.onVMILocationNoteUpdated,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<VMILocationNoteCubit>(),
        child: VmiLocationNotePage(
          onVMILocationNoteUpdated: onVMILocationNoteUpdated,
        ));
  }
}

class VmiLocationNotePage extends StatelessWidget {
  final void Function() onVMILocationNoteUpdated;
  VmiLocationNotePage({
    super.key,
    required this.onVMILocationNoteUpdated,
  });
  final TextEditingController noteDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Location Note'),
        ),
        body: BlocListener<VMILocationNoteCubit, VmiLocationNoteState>(
          listener: (context, state) {
            if (state is VmiLocationNoteSavedSuccessState) {
              CustomSnackBar.showVMILocationNoteSaved(context);
              onVMILocationNoteUpdated();
              Navigator.pop(context);
            }
            if (state is VmiLocationNoteSavedFailureState) {
              CustomSnackBar.showVMILocationNoteNotSaved(context);
            }
          },
          child: BlocBuilder<VMILocationNoteCubit, VmiLocationNoteState>(
              builder: (context, state) {
            if (state is VmiLocationNoteLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is VmiLocationNoteInitialState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Input(
                        label: LocalizationConstants.locationNote.localized(),
                        controller: noteDescriptionController,
                        onTapOutside: (p0) => context.closeKeyboard(),
                        onEditingComplete: () => context.closeKeyboard(),
                      ),
                    ),
                  ),
                  ListInformationBottomSubmitWidget(actions: [
                    SecondaryButton(
                      text: LocalizationConstants.cancel.localized(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    PrimaryButton(
                      text: LocalizationConstants.save.localized(),
                      onPressed: () {
                        context.read<VMILocationNoteCubit>().saveLocationNote(
                              noteDescriptionController.text,
                            );
                      },
                    ),
                  ])
                ],
              );
            } else
              // ignore: curly_braces_in_flow_control_structures
              return Container();
          }),
        ));
  }
}
