import 'package:chat_gpt/widgets/models_drop_down.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/text_widget.dart';

class Services {
  static Future<void> showModelSheet({required BuildContext context}) async {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextWidget(
                  label: 'Chosen Model:',
                  fontSize: 18,
                ),
              ),
              Flexible(
                // flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: ModelsDropDown(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
