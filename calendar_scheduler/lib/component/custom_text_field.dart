import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  const CustomTextField({
    required this.label,
    required this.isTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        if(isTime)renderTextField(),
        if(!isTime)Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextField(
      expands: !isTime,
      maxLines: isTime ? 1 : null,

      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly
      ] : [],
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        border: InputBorder.none,
      ),
    );
  }

}

