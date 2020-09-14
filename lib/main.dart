import 'package:flutter/material.dart';

void main() => runApp(Column(
      children: [
        Text(
          "Welcome to ByteBank!",
          textDirection: TextDirection.ltr,
        ),
        Text(
          "É isso.",
          textDirection: TextDirection.ltr,
        ),
        Expanded(
            child: FittedBox(
          fit: BoxFit.contain,
          child: const FlutterLogo(),
        ))
      ],
    ));
