import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderWithButton extends StatelessWidget {
  final String heading;
  final String buttonText;
  final VoidCallback onTap;

  const HeaderWithButton(
      {super.key,
      required this.heading,
      required this.buttonText,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              heading,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width > 600 ? 20 : 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width > 600 ? 120 : 100,
            child: RoundButton(
              title: buttonText,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
