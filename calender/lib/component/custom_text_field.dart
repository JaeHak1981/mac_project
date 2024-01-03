import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: PRIMARY_COLOR, fontWeight: FontWeight.w700),
        ),
        isTime ? renderTextStyle() : Expanded(child: renderTextStyle()),
      ],
    );
  }

  Widget renderTextStyle() {
    return TextFormField(
      onSaved: onSaved,
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '값을 입력하세요';
        }
        if(isTime){
          int? time = int.parse(val);
          if(time < 0 || time > 24){
            return '0에서 24 사이의 숫자를 입력하세요';
          }
          else{
            if(val.length > 500){
              return '500자 이하의 글자를 입력하세요';
            }
          }
        }
        return null;
      },
      maxLength:isTime ? null : 500,
      expands: !isTime,
      maxLines: isTime ? 1 : null,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
