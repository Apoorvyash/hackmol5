import 'package:flutter/material.dart';

class CardChild extends StatelessWidget {
  CardChild({required this.cardChild, required this.onPress});
  final Widget cardChild;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(

        child: cardChild,
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
