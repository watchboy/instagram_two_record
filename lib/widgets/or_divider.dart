
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          right: 0,
          height: 1,
          child: Container(
            color: Colors.grey.shade300,
          ),
        ),
        Container(
          color: Colors.grey.shade50,
          height: 3,
          width: 60,
        ),
        Text(
          'OR',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey.shade600),
        )
      ],
    );
  }
}