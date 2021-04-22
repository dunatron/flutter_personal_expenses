// import 'package:flutter/material.dart';

// class ChartBar extends StatelessWidget {
//   final String label;
//   final double spendingAmount;
//   final double spendingPctOfTotal;

//   ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Text('\$${spendingAmount.toStringAsFixed(0)}'),
//         SizedBox(height: 4),
//         Container(
//           height: 60,
//           width: 10,
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey, width: 1.0),
//                   color: Color.fromRGBO(220, 220, 220, 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               FractionallySizedBox(
//                   heightFactor: spendingPctOfTotal,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ))
//             ],
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(label),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ), //essentially shrinks the text to fit in the box
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor:
                        spendingPctOfTotal.isNaN ? 0 : spendingPctOfTotal,
                    // heightFactor: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
