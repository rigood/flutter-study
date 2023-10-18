import 'package:flutter/material.dart';

class MovieReservationRate extends StatelessWidget {
  final double reservationRate;

  const MovieReservationRate({
    super.key,
    required this.reservationRate,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "예매율 $reservationRate%",
      style: const TextStyle(
        fontFamily: "PretendardMedium",
        fontSize: 12,
        letterSpacing: -0.5,
      ),
    );
  }
}
