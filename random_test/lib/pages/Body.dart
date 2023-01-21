import 'package:flutter/cupertino.dart';

class Body extends StatelessWidget {
  final List<int> randomNumbers;

  const Body({required this.randomNumbers,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers.asMap().entries
            .map((e) => Padding(
          padding:  EdgeInsets.only(bottom:e.key ==2 ? 0: 16),
          child: Row(
            children: e.value
                .toString()
                .split('')
                .map((e) => Image.asset(
              'asset/img/$e.png',
              width: 70,
              height: 40,
            ))
                .toList(),
          ),
        ))
            .toList(),
      ),
    );
  }
}
