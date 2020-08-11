import 'package:flutter/material.dart';

import '../constants.dart';

class ScreenTitle extends StatelessWidget {
  final String title;

  const ScreenTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
