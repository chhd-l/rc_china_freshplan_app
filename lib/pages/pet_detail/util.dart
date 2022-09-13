import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
                color: const Color.fromARGB(255, 150, 204, 57),
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

Widget buildDateTimeItem(
    BuildContext context, Widget child, Function handleChangeDate) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            child: child,
            onTap: () {
              Get.bottomSheet(Container(
                height: 200,
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    OverflowBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('取消',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 153, 153, 153))),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('确定',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 150, 204, 57))),
                        ),
                      ],
                    ),
                    Expanded(
                        child: CupertinoDatePicker(
                      onDateTimeChanged: (dateTime) {
                        handleChangeDate(dateTime);
                      },
                      initialDateTime: DateTime.now(),
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.ymd,
                    )),
                  ],
                ),
              ));
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildGenderItem(
    Widget male, Widget femail, Function handleChangeGender) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        GestureDetector(
          child: male,
          onTap: () {
            handleChangeGender('MALE');
          },
        ),
        GestureDetector(
          child: femail,
          onTap: () {
            handleChangeGender('FEMALE');
          },
        ),
      ],
    ),
  );
}

Widget buildBreedItem(Widget child, List options, Function handleSelectBreed) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            child: child,
            onTap: () {
              Get.bottomSheet(Container(
                height: 200,
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    OverflowBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('取消',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 153, 153, 153))),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('确定',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 150, 204, 57))),
                        ),
                      ],
                    ),
                    Expanded(
                        child: CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 32.0,
                      onSelectedItemChanged: (int selectedItem) {
                        var selected = options[selectedItem];
                        handleSelectBreed(selected['name'].toString(),
                            selected['code'].toString());
                      },
                      children:
                          List<Widget>.generate(options.length, (int index) {
                        return Center(
                          child: Text(options[index]['name'].toString()),
                        );
                      }),
                    )),
                  ],
                ),
              ));
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
