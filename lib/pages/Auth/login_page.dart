import 'package:EfiritRetail/pages/Auth/default_queries_form.dart';
import 'package:EfiritRetail/routes.dart';
import 'package:EfiritRetail/store/controllers/auth.dart';
import 'package:EfiritRetail/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import 'auth_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool orientation = context.isPortrait;
    var keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          direction: orientation ? Axis.vertical : Axis.horizontal,
          children: [
            Flexible(flex: orientation ? 2 : 3, child: AuthHeader(keyboardVisible: keyboardVisible)),
            const Flexible(
              flex: 5,
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AuthCtrl authCtrl = Get.find();

  void _onSubmit() {
    if (!authCtrl.settings.hasData) {
      messageSnack(title: 'Не указаны настройки приложения', isSuccess: false);
      return;
    }
    if (_formKey.currentState!.saveAndValidate()) {
      var val = _formKey.currentState!.value;
      bool isOwner = val['login'].contains('@');
      authCtrl.tryLoginIn(_formKey.currentState!.value, isOwner);
    }
  }

  void handleSettings() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const DefaultQueriesSettings(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    bool orientation = context.isPortrait;
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: orientation ? 30 : 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Войти в систему', style: Theme.of(context).textTheme.headlineMedium),
                  IconButton(onPressed: handleSettings, icon: const Icon(Icons.settings)),
                ],
              ),
              const SizedBox(height: 10),
              Flex(mainAxisAlignment: MainAxisAlignment.spaceEvenly, direction: Axis.horizontal, children: [
                Flexible(child: Text('Еще нет аккаунта?', style: Theme.of(context).textTheme.bodyLarge)),
                OutlinedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.toNamed(RouterHelper.register);
                    },
                    child: const Text('ЗАРЕГИСТРИРОВАТЬСЯ'))
              ]),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              FormBuilderTextField(
                name: 'login',
                // autofocus: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Логин', prefixIcon: Icon(Icons.account_circle)),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'pwd',
                decoration: const InputDecoration(labelText: 'Пароль', prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Забыли пароль?',
                      style: Theme.of(context).textTheme.labelMedium,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              authCtrl.obx(
                  (state) => ElevatedButton(
                        onPressed: _onSubmit,
                        child: const Text(
                          'ВОЙТИ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                  onLoading: ElevatedButton.icon(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.grey,
                    ),
                    icon: const LoadingIcon(),
                    label: const Text(
                      'ВОЙТИ',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
