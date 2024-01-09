import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app_reubro_task/model/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();

  DateTime _selectedValue = DateTime.now();

  List<TaskModel> firstList = [];

  @override
  Widget build(BuildContext context) {
    List<TaskModel> filteredList = firstList
        .where((element) => element.date
            .contains(DateFormat('yyyy-MM-dd').format(_selectedValue)))
        .toList();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: const Icon(
          Icons.sort,
          color: Colors.black,
          size: 62,
        ),
        actions: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 50,
                height: double.infinity,
                color: Colors.white,
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'My Tasks',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              taskNameController.clear();
                              discriptionController.clear();
                              dateController.text = DateFormat('yyyy-MM-dd')
                                  .format(_selectedValue);
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Task name',
                                              style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextField(
                                              controller: taskNameController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            const Text(
                                              'Description',
                                              style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextField(
                                              controller: discriptionController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            const Text(
                                              'Date',
                                              style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextField(
                                              controller: dateController,
                                              decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(),
                                                  suffix: IconButton(
                                                      onPressed: () {
                                                        _showDatePicker();
                                                      },
                                                      icon: const Icon(Icons
                                                          .calendar_month))),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  firstList.add(TaskModel(
                                                      taskName:
                                                          taskNameController
                                                              .text
                                                              .trim(),
                                                      description:
                                                          discriptionController
                                                              .text
                                                              .trim(),
                                                      date: dateController.text
                                                          .trim()));
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('add task'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 110,
                        padding: const EdgeInsets.all(8),
                        child: DatePicker(
                          DateTime.now(),
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Colors.blue,
                          selectedTextColor: Colors.white,
                          deactivatedColor: Colors.white,
                          onDateChange: (date) {
                            setState(() {
                              _selectedValue = date;
                              print(_selectedValue);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    filteredList[index].taskName,
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    filteredList[index].description,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    ).then((value) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(value!);
      });
    });
  }
}
