import 'package:flutter/material.dart';
import 'package:flutter_validation/src/models/role.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(width: 200, child: FormWidget()),
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Email is required';
              }
              if (!emailRegex.hasMatch(value!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Role>(
            decoration: const InputDecoration(labelText: 'role'),
            items: const [
              DropdownMenuItem(
                value: Role.admin,
                child: Text('Admin'),
              ),
              DropdownMenuItem(
                value: Role.editor,
                child: Text('Editor'),
              ),
              DropdownMenuItem(
                value: Role.member,
                child: Text('Member'),
              ),
            ],
            onChanged: (value) => print(value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null) {
                return 'Role is required';
              }

              if (value == Role.member) {
                return 'Required Admin or Editor';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
