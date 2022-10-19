import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';

Widget buildPetItem(String title, Widget item, String? desc) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 5,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColors.tint,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              desc ?? '',
              style: const TextStyle(
                color: Color.fromARGB(255, 153, 153, 153),
                fontSize: 12,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: item,
        ),
      ],
    ),
  );
}

Widget buildInputItem(TextEditingController c,
    {TextInputType inputType = TextInputType.text, Function? handleChange}) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: c,
            keyboardType: inputType,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (value) {
              if (handleChange != null) {
                handleChange(value);
              }
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildInputNumberItem(TextEditingController c,
    {TextInputType inputType = TextInputType.text, Function? handleChange}) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: c,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
            ],
            keyboardType: inputType,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (value) {
              if (handleChange != null) {
                handleChange(value);
              }
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildPostureItem(
    Widget thin, Widget standard, Widget fat, Function handleChangePosture) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
            child: GestureDetector(
          child: thin,
          onTap: () {
            handleChangePosture("EMACIATED");
          },
        )),
        Expanded(
            child: GestureDetector(
          child: standard,
          onTap: () {
            handleChangePosture("STANDARD");
          },
        )),
        Expanded(
            child: GestureDetector(
          child: fat,
          onTap: () {
            handleChangePosture("OBESITY");
          },
        )),
      ],
    ),
  );
}

Widget buildHealthItem(Widget health1, Widget health2, Widget health3,
    Widget health4, Widget health5, Function handleAddHealth) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    child: Column(
      children: [
        GestureDetector(
          child: health1,
          onTap: () {
            handleAddHealth("PICKY_EATER");
          },
        ),
        GestureDetector(
          child: health2,
          onTap: () {
            handleAddHealth("FOOD_ALLERGIES_OR_STOMACH_SENSITIVITIES");
          },
        ),
        GestureDetector(
          child: health3,
          onTap: () {
            handleAddHealth("DULL_OR_FLAKY_FUR");
          },
        ),
        GestureDetector(
          child: health4,
          onTap: () {
            handleAddHealth("ARTHRITIS_OR_JOINT_PAIN");
          },
        ),
        GestureDetector(
          child: health5,
          onTap: () {
            handleAddHealth("NONE");
          },
        ),
      ],
    ),
  );
}
