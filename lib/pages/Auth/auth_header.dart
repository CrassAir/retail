import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.keyboardVisible,
  });

  final bool keyboardVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30,
          ),
          Flexible(
            child: SvgPicture.asset(
              'assets/Logo.svg',
              semanticsLabel: 'Efirit',
            ),
          ),
          keyboardVisible
              ? const SizedBox()
              : Text('Цифровой агент для вашего бизнеса',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}