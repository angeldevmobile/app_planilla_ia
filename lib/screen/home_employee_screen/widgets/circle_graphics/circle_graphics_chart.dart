import 'package:flutter/material.dart';
import 'components/circle_chart.dart';

class CircleGraphics extends StatefulWidget {
  final int justifiedAbsences;
  final int unjustifiedAbsences;

  const CircleGraphics({
    super.key,
    required this.justifiedAbsences,
    required this.unjustifiedAbsences,
  });

  @override
  State<CircleGraphics> createState() => _CircleGraphicsState();
}

class _CircleGraphicsState extends State<CircleGraphics> {
  late int justifiedAbsences;
  late int unjustifiedAbsences;

  @override
  void initState() {
    super.initState();
    justifiedAbsences = widget.justifiedAbsences;
    unjustifiedAbsences = widget.unjustifiedAbsences;
  }

  // Aquí actualizar los datos y llamar a setState()

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbsenceDonutChart(
          justified: justifiedAbsences,
          unjustified: unjustifiedAbsences,
        ),
      ],
    );
  }
}
