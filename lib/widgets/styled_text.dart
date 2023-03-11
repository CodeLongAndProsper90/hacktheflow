import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final String text;
  final Color? color;

  const LogoText(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: color),
    );
  }
}

class LogoSmallText extends StatelessWidget {
  final String text;
  final Color? color;

  const LogoSmallText(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(color: color),
    );
  }
}

class HeaderText extends StatelessWidget {
  final TextSpan? rich;
  final String? text;
  final TextStyle? style;

  // ignore: non_constant_identifier_names
  const HeaderText(String list_of_people, {
    super.key,
    this.rich,
    this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return (rich != null)
        ? Text.rich(
            rich!,
            style: Theme.of(context).textTheme.headlineLarge?.merge(style),
            textAlign: TextAlign.center,
          )
        : Text(
            text!,
            style: Theme.of(context).textTheme.headlineLarge?.merge(style),
            textAlign: TextAlign.center,
          );
  }
}

class PageTitleText extends StatelessWidget {
  final String text;

  const PageTitleText(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: Theme.of(context).textTheme.headlineMedium,
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
      style: Theme.of(context).textTheme.headlineSmall?.merge(style),
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
      style: Theme.of(context).textTheme.bodyMedium?.merge(style),
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

class LabelText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LabelText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.merge(style),
    );
  }
}
