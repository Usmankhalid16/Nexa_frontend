
import 'package:flutter/material.dart';
import 'package:fyp_app/UI/widgets/button.dart';
import 'package:fyp_app/UI/widgets/create_button.dart';
import 'package:fyp_app/UI/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controller/controllers.dart';
import '../models/tasks.dart';
import '../services/theme_ser.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  int _selectreminder = 5;
  List<int> remindList=[
    5,
    10,
    15,
    20,
  ];
  DateTime _selectedDate=  DateTime.now();
  String _endtime= "12:00 PM";
  String _starttime= DateFormat('hh:mm:a').format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: Container(
          padding: const EdgeInsets.only(left:20, right:20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add a new Task",
                  style: greetStyle,
                ),
               MyInputField(title:"Title", hint:"Enter your title",controller: _titleController,),
               MyInputField(title:"Description", hint:"Enter task description",controller: _desController,),
                MyInputField(title:"Date", hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today,
                  color: Colors.grey),
                  onPressed: (){
                    _getDateFromUser();

                  },
                )),
                Row(
                  children: [
                    Expanded(
                        child: MyInputField(title: "Start Time",hint:_starttime,
                widget: IconButton(
                onPressed: (){
                  _getTimefromUser(isStartTime:true);
                  },
                icon: const Icon(
                  Icons.access_time,
                  color: Colors.grey,
                ),)

                    )
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                        child: MyInputField(title: "End Time",hint:_endtime,
                            widget: IconButton(
                              onPressed: (){
                              _getTimefromUser(isStartTime:false);
                              },
                              icon: const Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),)

                        )
                    ),

                  ],
                ),
                MyInputField(title: "Set Reminder", hint:"$_selectreminder minutes early",
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitleStyle,
                    underline: Container(height: 0,),
                    onChanged: (String? newValue){
                      setState(() {
                        _selectreminder = int.parse(newValue!);
                      });
                    },
                    items: remindList.map<DropdownMenuItem<String>>((int value){
                      return DropdownMenuItem<String>(
                        value:value.toString(),
                        child: Text(value.toString()

                        )
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 18,),
                Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        CreateButton(label: "Create", onTap: ()=>_validateData())
                      ],
                    ),
                  ),
                )

              ],
            )
          )
        )
    );
  }
  _validateData(){
    if (_titleController.text.isNotEmpty&&_desController.text.isNotEmpty){
      _addTasktoDB();
      Get.back();

    }else if(_titleController.text.isEmpty|| _desController.text.isEmpty){
     Get.snackbar("Required", "All fields should be filled",
     snackPosition: SnackPosition.BOTTOM,
     backgroundColor:Colors.grey,
     icon: const Icon(Icons.warning_amber_rounded));
    }
  }
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
            Get.back();

        },
        child: const Icon(Icons.arrow_back_rounded,
          size: 20,),
      ),
      actions: const [
        Icon(Icons.person,
          size: 20,),
        SizedBox(width: 20,),
      ],
    );
  }
  _getDateFromUser()async{
    DateTime? _pickerDate = await showDatePicker(context: context,
        initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2024));
    if (_pickerDate!=null){
      setState(() {
        _selectedDate= _pickerDate;
      });
    }
  }
  _getTimefromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimepicker();
    String _formattime = pickedTime.format(context);
    if (pickedTime==null){

    }
    else if(isStartTime==true){
      setState(() {
        _starttime= _formattime;
      });

    }
    else if(isStartTime==false){
      setState(() {
        _endtime = _formattime;
      });

    }
  }
  _showTimepicker(){
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_starttime.split(":")[0]),
            minute: int.parse(_starttime.split(":")[1].split(" ")[0]))
    );
  }
  _addTasktoDB()async {
    int value = await _taskController.addTask(
        task: Task(
          title: _titleController.text,
          des: _desController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _starttime,
          endTime: _endtime,
          remind: _selectreminder,
          isCompleted: 0,
        )

    );
   print("id " + "$value");
  }

}


