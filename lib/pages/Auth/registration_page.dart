import 'dart:developer';

import 'package:EfiritRetail/store/controllers/auth.dart';
import 'package:EfiritRetail/store/models/auth.dart';
import 'package:EfiritRetail/store/models/organization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'auth_header.dart';
import 'organization_form.dart';
import 'user_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              expandedHeight: 125.0,
              backgroundColor: Theme.of(context).primaryColor,
              // collapsedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(top: 30, bottom: 10),
                centerTitle: true,
                title: SvgPicture.asset(
                  'assets/Logo.svg',
                  semanticsLabel: 'Efirit',
                  height: 70,
                ),
              )),
          // mainAxisAlignment: MainAxisAlignment.start,
          const SliverToBoxAdapter(child: SizedBox(height: 650, child: RegistrationForm())),
        ],
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormBuilderState> step1 = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> step2 = GlobalKey<FormBuilderState>();
  final AuthCtrl authCtrl = Get.find();

  bool submitted = false;
  int _index = 0;

  void onStepContinue() {
    setState(() {
      submitted = true;
    });
    switch (_index) {
      case 0:
        if (step1.currentState!.saveAndValidate()) {
          log('${step1.currentState!.value}');
          setState(() {
            submitted = false;
            _index = 1;
          });
        }
      case 1:
        if (step2.currentState!.saveAndValidate()) {
          Map<String, dynamic> user = step1.currentState!.value;
          Map<String, dynamic> org = step2.currentState!.value;
          org['taxSystems'] = [org['taxSystems']];
          authCtrl.tryRegistration(user, org);
          setState(() {
            submitted = false;
          });
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      type: StepperType.horizontal,
      controlsBuilder: (context, details) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            details.currentStep > 0
                ? TextButton(onPressed: details.onStepCancel, child: const Text('НАЗАД'))
                : const SizedBox(),
            ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(details.currentStep > 0 ? 'СОЗДАТЬ АККАУНТ' : 'СЛЕДУЮЩИЙ ШАГ'))
          ],
        );
      },
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: onStepContinue,
      steps: <Step>[
        Step(
            title: _index == 0 ? const Text('Данные пользователя') : const SizedBox(),
            state: _index > 0 ? StepState.complete : StepState.indexed,
            isActive: _index >= 0,
            content: UserForm(formKey: step1, submitted: submitted)),
        Step(
            title: _index == 1 ? const Text('Сведения об организации') : const SizedBox(),
            state: _index > 1 ? StepState.complete : StepState.indexed,
            isActive: _index >= 1,
            content: OrganizationForm(
              formKey: step2,
              submitted: submitted,
            )),
      ],
    );
  }
}