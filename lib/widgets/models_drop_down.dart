import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/services/api_service.dart';
import 'package:chat_gpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../models/models_model.dart';

class ModelsDropDown extends StatefulWidget {
  const ModelsDropDown({super.key});

  @override
  State<ModelsDropDown> createState() => _ModelsDropDownState();
}

class _ModelsDropDownState extends State<ModelsDropDown> {
  String currentModel = 'text-devinci-003';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelsModel>>(
      future: ApiService.getModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextWidget(
              label: snapshot.error.toString(),
            ),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : DropdownButton(
                dropdownColor: scaffoldBackgroundColor,
                iconEnabledColor: Colors.white,
                items: List<DropdownMenuItem<Object?>>.generate(
                  snapshot.data!.length,
                  (index) => DropdownMenuItem(
                    value: snapshot.data![index].id,
                    child: TextWidget(
                      label: snapshot.data![index].id,
                      fontSize: 15,
                    ),
                  ),
                ),
                value: currentModel,
                onChanged: (value) {
                  setState(() {
                    currentModel = value.toString();
                  });
                },
              );
      },
    );
  }
}
