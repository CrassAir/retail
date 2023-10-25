import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserForm extends StatefulWidget {
  final GlobalKey formKey;
  final bool submitted;

  UserForm({Key? key, required this.formKey, required this.submitted}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _pwdFieldKey = GlobalKey<FormBuilderFieldState>();
  final phoneFormatter = MaskTextInputFormatter(
      mask: '+7 (9##) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 5),
            FormBuilderTextField(
              name: 'name',
              autofocus: true,
              autovalidateMode: widget.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              decoration: const InputDecoration(labelText: 'Имя пользователя*'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'email',
              autovalidateMode: widget.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              decoration: const InputDecoration(labelText: 'Email*'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.email(),
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              inputFormatters: [phoneFormatter],
              name: 'phone',
              keyboardType: TextInputType.number,
              autovalidateMode: widget.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              decoration: const InputDecoration(labelText: 'Номер телефона'),
              valueTransformer: (val) =>
                  val?.replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(" ", ""),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.equalLength(18, allowEmpty: true, errorText: 'Некорректный номер телефона'),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'pwd',
              key: _pwdFieldKey,
              obscureText: true,
              autovalidateMode: widget.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              decoration: const InputDecoration(labelText: 'Пароль*'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            TextFormField(
              autovalidateMode: widget.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Подтвердите пароль*'),
              validator: (String? value) {
                if (value != _pwdFieldKey.currentState!.value) {
                  return 'Пароли не совпадают';
                }
                return null;
              },
            ),
          ]),
    );
  }
}