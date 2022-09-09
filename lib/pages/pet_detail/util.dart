import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

Widget buildInputItem(TextEditingController c) {
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
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
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

Widget buildBreedItem() {
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
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  iconSize: 0,
                  items: const [
                    DropdownMenuItem(value: '1', child: Text('item1')),
                    DropdownMenuItem(value: '2', child: Text('item2')),
                    DropdownMenuItem(value: '3', child: Text('item3')),
                  ],
                  onChanged: (t) {})),
        ),
      ],
    ),
  );
}

Widget buildPostureItem() {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/pet-thin.png',
                width: 62,
                height: 52,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '瘦弱',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/pet-std.png',
                width: 62,
                height: 52,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '标准',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/pet-fat.png',
                width: 62,
                height: 52,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '超重',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );
}

Widget buildHealthItem() {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    child: Column(
      children: [
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '对食物很挑剔',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '食物过敏或胃敏感',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '无光泽或片状被毛',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '关节炎或关节痛',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '以上都没有',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
