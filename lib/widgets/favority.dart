import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  final double size;
  final bool like;

  const FavouriteButton({
    super.key,
    this.size = 35,
    required this.like,
  });

  @override
  Widget build(BuildContext context) {
    if (like) {
      return Icon(
        Icons.favorite,
        color: Colors.red,
        size: size,
      );
    }
    return Icon(
      Icons.favorite_border,
      color: Colors.grey,
      size: size,
    );
  }
}
