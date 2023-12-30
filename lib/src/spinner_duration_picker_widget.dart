// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'spinner_number_picker_widget.dart';

// Define a StatefulWidget for a custom duration picker widget
class SpinnerDurationPicker extends StatefulWidget {
  // Initialize parameters for the duration picker
  final Duration initDuration; // Initial duration value
  final double spinnerHeight; // Height of the widget
  final double spinnerWidth; // Width of the widget
  final double elementsSpace; // Space between hour and minute pickers
  final double digitHeight; // Height of individual duration elements
  final Color spinnerBgColor; // Background color of the widget
  final TextStyle
      selectedTextStyle; // Text style for selected duration elements
  final TextStyle
      nonSelectedTextStyle; // Text style for non-selected duration elements
  final void Function(Duration selected) onChangedSelectedDuration;
  final bool hideSeconds;
  final bool hideMinutes;
  final bool hideHours;

  const SpinnerDurationPicker({
    Key? key,
    required this.initDuration,
    required this.spinnerHeight,
    required this.spinnerWidth,
    required this.elementsSpace,
    required this.digitHeight,
    required this.spinnerBgColor,
    required this.selectedTextStyle,
    required this.nonSelectedTextStyle,
    required this.onChangedSelectedDuration,
    this.hideSeconds = false,
    this.hideMinutes = false,
    this.hideHours = false,
  }) : super(key: key);

  @override
  State<SpinnerDurationPicker> createState() => _SpinnerDurationPickerState();
}

// Define the state for the SpinnerDurationPicker widget
class _SpinnerDurationPickerState extends State<SpinnerDurationPicker> {
  int selectedHour = 0; // Selected hour value
  int selectedMinute = 0; // Selected minute value
  int selectedSecond = 0; // Selected second value

  @override
  void initState() {
    // Initialize state variables based on the initial duration
    final selectedDuration = widget.initDuration;
    setState(() {
      selectedHour = selectedDuration.inHours;
      selectedMinute = selectedDuration.inMinutes.remainder(60);
      selectedSecond = selectedDuration.inSeconds.remainder(60);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build the duration picker layout
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: [
        widget.hideHours ? const SizedBox() : _hourPicker(),
        widget.hideHours
            ? const SizedBox()
            : _durationSeparator(context, 'h'),
        widget.hideMinutes ? const SizedBox() : _minutePicker(),
        widget.hideMinutes
            ? const SizedBox()
            : _durationSeparator(context, 'm'),
        widget.hideSeconds ? const SizedBox() : _secondPicker(),
        widget.hideSeconds
            ? const SizedBox()
            : _durationSeparator(context, 's'),
      ],
    );
  }

  // Build the second picker
  _secondPicker() {
    return SpinnerNumericPicker(
      initValue: selectedSecond,
      maxValue: 60,
      height: widget.spinnerHeight,
      width: widget.spinnerWidth,
      digitHeight: widget.digitHeight,
      nonSelectedTextStyle: widget.nonSelectedTextStyle,
      selectedTextStyle: widget.selectedTextStyle,
      spinnerBgColor: widget.spinnerBgColor,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedSecond = value;
        });
        setSelectedDuration();
      },
    );
  }

  // Build the minute picker
  SpinnerNumericPicker _minutePicker() {
    return SpinnerNumericPicker(
      initValue: selectedMinute,
      maxValue: 60,
      height: widget.spinnerHeight,
      width: widget.spinnerWidth,
      digitHeight: widget.digitHeight,
      nonSelectedTextStyle: widget.nonSelectedTextStyle,
      selectedTextStyle: widget.selectedTextStyle,
      spinnerBgColor: widget.spinnerBgColor,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedMinute = value;
        });
        setSelectedDuration();
      },
    );
  }

  // Build the hour picker
  SpinnerNumericPicker _hourPicker() {
    return SpinnerNumericPicker(
      maxValue: 100,
      initValue: selectedHour,
      height: widget.spinnerHeight,
      width: widget.spinnerWidth,
      digitHeight: widget.digitHeight,
      nonSelectedTextStyle: widget.nonSelectedTextStyle,
      selectedTextStyle: widget.selectedTextStyle,
      spinnerBgColor: widget.spinnerBgColor,
      onSelectedItemChanged: (value) async {
        setState(() {
          selectedHour = value;
        });
        setSelectedDuration();
      },
    );
  }

  // Build the time separator between hour and minute pickers
  SizedBox _durationSeparator(BuildContext context, String separator) {
    return SizedBox(
      width: widget.elementsSpace,
      child: Center(
        child: Text(
          separator,
          style: TextStyle(
              fontSize: 23, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  // Update the selected duration based on user choices
  void setSelectedDuration() {
    widget.onChangedSelectedDuration(Duration(
        hours: selectedHour, minutes: selectedMinute, seconds: selectedSecond));
  }
}
