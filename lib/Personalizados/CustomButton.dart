import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String labelText;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.labelText,
    this.onPressed,
    this.gradientColors,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors ?? [
                        Colors.purple,
                        Colors.purpleAccent,
                        Colors.deepPurpleAccent,
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: onPressed,
                child: Text(labelText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}