import 'package:flutter/material.dart';

import '../../../../data/data_utility/urls.dart';
import '../../../../data/models/network_response.dart';
import '../../../../data/services/network_caller.dart';
import '../../presentation_utility/input_validations.dart';
import '../../presentation_utility/style.dart';
import '../../widgets/background.dart';
import '../../widgets/profile_summary_card.dart';
import '../../widgets/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectInputTEController =
  TextEditingController();
  final TextEditingController _descriptionInputTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool taskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: Background(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 40,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add New Task",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _subjectInputTEController,
                            decoration: const InputDecoration(
                              hintText: "Subject",
                            ),
                            validator: FormValidation.inputValidation,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _descriptionInputTEController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                                hintText: "Description"),
                            validator: FormValidation.inputValidation,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: taskInProgress == false,
                              replacement: Center(
                                child: CircularProgressIndicator(
                                    color: PrimaryColor.color),
                              ),
                              child: ElevatedButton(
                                onPressed: _createNewTask,
                                child: const Icon(
                                    Icons.arrow_circle_right_outlined,color: Colors.white,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createNewTask() async {
    if (_formKey.currentState!.validate()) {
      taskInProgress = true;
      if (mounted) {
        setState(() {});
      }

      final NetworkResponse response =
      await NetworkCaller.postRequest(Urls.createNewTask, body: {
        "title": _subjectInputTEController.text.trim(),
        "description": _descriptionInputTEController.text.trim(),
        "status": "New",
      });

      taskInProgress = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {
        _subjectInputTEController.clear();
        _descriptionInputTEController.clear();
        if (mounted) {
          showSnackMessage(context, "New Task Added Successfully!");
        }
      } else {
        if (mounted) {
          showSnackMessage(context, "Failed! Please Try Again.", true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectInputTEController.dispose();
    _descriptionInputTEController.dispose();
    super.dispose();
  }
}
