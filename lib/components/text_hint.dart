import 'package:flutter/material.dart';

class TextHint extends StatelessWidget {
  const TextHint({
    super.key,
    required this.screenData,
    required this.screenNavigator,
    required this.widgetName,
    required this.navigate,
    required this.context1
  });
  final Function navigate;
  final String screenData;
  final String screenNavigator;
  final Widget widgetName;
  final BuildContext context1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          screenData,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () => navigate,
          // () {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context1) {
          //         return widgetName;
          //       },
          //     ),
          //   );
          // },
          child: Text(
            screenNavigator,
            style: TextStyle(color: Colors.deepPurple[700]),
          ),
        )
      ],
    );
  }
}
