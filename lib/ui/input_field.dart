import 'package:flutter/material.dart';
import 'package:twentyminute/ui/theme.dart';
//import 'package:twentyminute/ui/theme_services.dart';

class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      required this.label,
      this.controller,
      this.icondata,
      required this.hint,
      this.widget,
      required this.iconOrdrop,
      required this.isEnabled})
      : super(key: key);
  final String label;
  final TextEditingController? controller;
  final IconData? icondata;
  final String hint;
  final String iconOrdrop;
  final Widget? widget;
  final bool isEnabled;

  @override
  InputFieldState createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
              // color: Get.isDarkMode ? Colors.white : darkGreyClr,
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          readOnly: !widget.isEnabled,
          controller: widget.controller,
          validator: (value) {
            if (value.toString().isEmpty) {
              return 'Please Enter ${widget.label}';
            }
          },
          keyboardType: TextInputType.name,
          // cursorColor: Get.isDarkMode ? Colors.white : darkGreyClr,
          // style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
          decoration: InputDecoration(
            suffixIcon: widget.iconOrdrop == 'icon'
                ? Icon(
                    widget.icondata,
                    // color: Get.isDarkMode ? Colors.white : Colors.grey,
                  )
                : Container(margin: const EdgeInsets.only(right: 10), child: widget.widget),
            hintText: widget.hint,
            hintStyle:
              const TextStyle(color: Colors.white70), // TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1,
                    color: Colors.white70), // color: Get.isDarkMode ? Colors.white70 : primaryClr),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1,
                  color: Colors.white70), // color: Get.isDarkMode ? Colors.white70 : primaryClr),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
