import 'dart:developer';

import 'package:EfiritRetail/store/choices.dart';
import 'package:EfiritRetail/store/controllers/organization.dart';
import 'package:EfiritRetail/utils.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class OrganizationForm extends StatefulWidget {
  final GlobalKey? formKey;
  final bool submitted;

  const OrganizationForm({Key? key, this.formKey, this.submitted = false}) : super(key: key);

  @override
  State<OrganizationForm> createState() => _OrganizationFormState();
}

class _OrganizationFormState extends State<OrganizationForm> {
  final GlobalKey<FormBuilderState> formData = GlobalKey<FormBuilderState>();
  final _multiKey = GlobalKey<FormBuilderFieldState>();

  void _onSubmit() {
    if (formData.currentState!.saveAndValidate()) {
      Map<String, dynamic> org = {...formData.currentState!.value};
      OrganizationCtrl orgCtrl = Get.find();
      orgCtrl.createOrganization(org);
    }
  }

  final List<S2Choice<int>> taxSystemChoices =
  taxSystem.map((tax) => S2Choice<int>(value: tax['id'], title: tax['name'])).toList();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: widget.formKey.hasData ? widget.formKey : formData,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 5),
              FormBuilderTextField(
                name: 'name',
                autofocus: true,
                autovalidateMode: widget.submitted || !widget.formKey.hasData
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                decoration: const InputDecoration(labelText: 'Наименование*'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderDropdown(
                name: 'type',
                initialValue: typeOrg.first['id'],
                items: typeOrg
                    .map((item) => DropdownMenuItem(
                  value: item['id'],
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'tin',
                keyboardType: TextInputType.number,
                autovalidateMode: widget.submitted || !widget.formKey.hasData
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                decoration: const InputDecoration(labelText: 'ИНН*'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.equalLength(10, errorText: 'Неверный ИНН'),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'rrc',
                keyboardType: TextInputType.number,
                autovalidateMode: widget.submitted || !widget.formKey.hasData
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                decoration: const InputDecoration(labelText: 'КПП'),
                validator: FormBuilderValidators.compose([]),
              ),
              const SizedBox(height: 10),
              FormBuilderField(
                name: 'taxSystems',
                initialValue: const <int>[0],
                onChanged: (val) {},
                // validator: FormBuilderValidators.notEqual([]),
                builder: (FormFieldState field) {
                  return SmartSelect<int>.multiple(
                    title: 'Система налогообложения',
                    modalType: S2ModalType.fullPage,
                    modalStyle: const S2ModalStyle(elevation: 18),
                    onModalOpen: (state) => FocusManager.instance.primaryFocus?.unfocus(),
                    // choiceType: S2ChoiceType.chips,
                    selectedValue: field.value!,
                    choiceItems: taxSystemChoices,
                    // validation: (value) => value.isEmpty ? 'Нужно выбрать хотя бы одно значение' : '',
                    onChange: (state) => field.didChange(state.value),
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(state,
                          hideValue: true,
                          isLoading: false,
                          body: S2TileChips(
                            chipLength: state.selected.value.length,
                            chipLabelBuilder: (context, i) => Text(taxSystem[i]['name']),
                            chipOnDelete: (i) {
                              field.value?.removeAt(i);
                              field.didChange(field.value);
                            },
                          ));
                    },
                  );
                },
              ),
              widget.formKey.hasData
                  ? const SizedBox()
                  : ElevatedButton(
                onPressed: _onSubmit,
                child: const Text(
                  'СОЗДАТЬ',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ]));
  }
}