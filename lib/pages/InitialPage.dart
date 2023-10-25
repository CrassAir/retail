import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/Logo.svg',
          semanticsLabel: 'Efirit',
          height: 350,
          colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
          // theme: SvgTheme(currentColor: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
