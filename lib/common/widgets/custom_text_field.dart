import 'package:fixit_provider/common/color_extension.dart';
import 'package:flutter/material.dart';

class RoundTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final String? Function(String)? validator;
  final String? imageicon;
  final Widget lefticon;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final String? errortext;
  final void Function(String)? onChanged;
  final String? defaultvalue;

  const RoundTextField(
      {super.key,
      required this.hintText,
      this.imageicon,
      this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.rigtIcon,
      this.validator,
      this.onChanged,
      this.errortext,
      this.defaultvalue,
      required this.lefticon});

  @override
  State<RoundTextField> createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  bool _showError = false;
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if (widget.defaultvalue != null) {
      widget.controller!.text = widget.defaultvalue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: widget.margin,
            decoration: BoxDecoration(
              color: Tcolor.lightGray,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              onChanged: (val) {
                widget.onChanged?.call(val);
                setState(() {
                  _showError = widget.validator?.call(val) != null;
                });
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: widget.hintText,
                suffixIcon: widget.rigtIcon,
                prefixIcon: widget.imageicon != null
                    ? Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          widget.imageicon!,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: Tcolor.gray,
                        ),
                      )
                    : widget.lefticon,
                errorText: widget.errortext,
                hintStyle: TextStyle(color: Tcolor.gray, fontSize: 12),
              ),
            ),
          ),
          if (_showError && widget.errortext != null)
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: Text(
                widget.errortext!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
