import 'package:flutter/material.dart';

import '../custom_toast/custom_toast.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color? color;
  final double? starSize;

  const StarRating({super.key, this.starCount = 5,this.starSize=16, this.rating = .0, required this.onRatingChanged,  this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border_rounded,
        color: Theme.of(context).bottomAppBarTheme.color,
        size: starSize,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half_rounded,
        color: color ?? Theme.of(context).primaryColor,
        size: starSize,
      );
    } else {
      icon = Icon(
        Icons.star_rounded,
        color: color ?? Theme.of(context).primaryColor,
        size: starSize,
      );
    }
    return InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    return Row(
        children: List.generate(starCount, (index) => buildStar(context, index))
    );
  }
}