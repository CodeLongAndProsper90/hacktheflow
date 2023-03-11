import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final String text;

  const LogoText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class LogoSmallText extends StatelessWidget {
  final String text;

  const LogoSmallText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

class HeaderText extends StatelessWidget {
  final TextSpan? rich;
  final String? text;

  const HeaderText({
    super.key,
    this.rich,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return (rich != null)
        ? Text.rich(
            rich!,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          )
        : Text(
            text!,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          );
  }
}

class SubheaderText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const SubheaderText(this.text, {super.key, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style != null
          ? style?.merge(Theme.of(context).textTheme.headlineSmall)
          : Theme.of(context).textTheme.headlineSmall,
      textAlign: textAlign,
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BodyText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style != null
          ? style?.merge(Theme.of(context).textTheme.bodyMedium)
          : Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;

  const SmallText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
