import 'dart:convert';
import 'package:EfiritRetail/store/controllers/auth.dart';
import 'package:EfiritRetail/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class DefaultQueriesSettings extends StatefulWidget {
  const DefaultQueriesSettings({Key? key}) : super(key: key);

  @override
  State<DefaultQueriesSettings> createState() => _DefaultQueriesSettingsState();
}

class _DefaultQueriesSettingsState extends State<DefaultQueriesSettings> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AuthCtrl authCtrl = Get.find();

  void _onSubmit() {
    if (_formKey.currentState!.saveAndValidate()) {
      authCtrl.setDefaultQueries(_formKey.currentState!.value);
      Get.back();
    }
  }

  void handleQrCode() async {
    String result = await showDialog(context: context, builder: (context) => const GetQrCode());
    _formKey.currentState?.patchValue(jsonDecode(result));
  }

  void patchData() {
    if (authCtrl.settings.hasData) {
      _formKey.currentState?.patchValue(authCtrl.settings);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => patchData());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              'Настройки приложения',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'ownerId',
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Owner ID'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              name: 'organizationId',
              decoration: const InputDecoration(labelText: 'Organization ID'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text(
                    'ЗАДАТЬ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 2),
                IconButton.filled(
                  style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                  onPressed: handleQrCode,
                  icon: const Icon(Icons.qr_code),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GetQrCode extends StatelessWidget {
  const GetQrCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
        // fit: BoxFit.contain,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            debugPrint(barcode.rawValue!);
            return Navigator.pop(context, barcode.rawValue!);
          }
        },
      ),
    );
  }
}
