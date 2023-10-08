import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: MediaQuery.of(context).size.height / 2 + bottomInset,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Time(),
              const SizedBox(height: 16),
              _Content(),
              const SizedBox(height: 16),
              _ColorPicker(),
              const SizedBox(height: 8),
              _SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomTextField(label: 'Start Time')),
        const SizedBox(width: 16),
        Expanded(child: CustomTextField(label: 'End Time')),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(label: 'Content');
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.green),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR
            ),
            onPressed: () {},
            child: Text('SAVE'),
          ),
        ),
      ],
    );
  }
}
