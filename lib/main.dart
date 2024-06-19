import 'package:flutter/material.dart';
import 'package:flutter_validation/src/models/role.dart';
import 'package:flutter_validation/src/validation.dart';
import 'package:flutter_validation/src/validator.dart';

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
          child: SizedBox(width: 200, child: FormPage()),
        ),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'email'),
            validator: Validator.apply(
              context,
              const [
                RequiredValidation(),
                EmailValidation(),
              ],
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'password'),
            validator: Validator.apply(
              context,
              const [
                RequiredValidation(),
                PasswordValidation(
                  minLength: 8,
                  number: true,
                  upperCase: false,
                  specialChar: true,
                ),
              ],
            ),
          ),
          DropdownButtonFormField<Role>(
            decoration: const InputDecoration(labelText: 'Role'),
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
            validator: Validator.apply(
              context,
              const [
                RequiredValidation(),
                RoleValidation(),
              ],
            ),
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
