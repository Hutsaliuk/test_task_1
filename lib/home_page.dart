import 'package:flutter/material.dart';
import 'package:test_task_1/radio_form_field.dart';
import 'package:test_task_1/user.dart';

///Home Page of the application
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _snackBar =
      const SnackBar(content: Text("Validation successfully. Submitting..."));

  final users = const [
    User('Ivan', 24),
    User('Petro', 32),
    User('Viktor', 43),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Here is the new Radio widget that allows validation
              RadioFormField(
                items: users,
                validatior: (value) =>
                    value == null ? "You haven't selected any option!" : null,
              ),
              //The button that alows a user to start validating operation
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    }
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
