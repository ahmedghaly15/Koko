import 'dart:io';

import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.loading, required this.image});

  final bool loading;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 30,
      ),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(30),
          ),
          child: loading
              ? null
              : SizedBox(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ClipRRect(
                    child: Image.file(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
