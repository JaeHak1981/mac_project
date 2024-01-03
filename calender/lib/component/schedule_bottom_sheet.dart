import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 16,
              ),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      startTime: (String? val) {
                        startTime = int.parse(val!);
                      },
                      endTime: (String? val) {
                        endTime = int.parse(val!);
                      },
                    ),
                    SizedBox(height: 16),
                    _Content(
                      content: (String? val) {
                        content = val;
                      },
                    ),
                    SizedBox(height: 16),
                    FutureBuilder<List<CategoryColor>>(
                        future: GetIt.I<LocalDatabase>().getCategoryColors(),
                        builder: (context, snapshot) {
                          if (selectedColorId == null &&
                              snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            selectedColorId = snapshot.data![0].id;
                          }
                          return _ColorPicker(
                            color: snapshot.hasData ? snapshot.data! : [],
                            selectedColorId: selectedColorId!,
                          );
                        }),
                    SizedBox(height: 8),
                    _SaveButton(
                      onPressed: onSavedPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavedPressed() {
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      print('에러가 없습니다');
      formKey.currentState!.save();
      print('-------------------');
      print('startTime : $startTime');
      print('endTime : $endTime');
      print('content : $content');
    } else {
      print('에러가 있습니다');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> startTime;
  final FormFieldSetter<String> endTime;

  const _Time({
    required this.startTime,
    required this.endTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작 시간',
          isTime: true,
          onSaved: startTime,
        )),
        SizedBox(width: 16),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
          isTime: true,
          onSaved: endTime,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> content;

  const _Content({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: content,
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> color;
  final int selectedColorId;

  const _ColorPicker({
    required this.color,
    required this.selectedColorId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 10,
        spacing: 10,
        children:
            color.map((e) => renderColor(e, selectedColorId == e.id)).toList());
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(int.parse('FF${color.hexCode}', radix: 16)),
          border:
              isSelected ? Border.all(color: Colors.black, width: 4.0) : null),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            onPressed: onPressed,
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
