
import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fyp_app/UI/theme.dart';
import 'package:fyp_app/UI/widgets/button.dart';
import 'package:fyp_app/UI/widgets/task_tile.dart';
import 'package:fyp_app/services/theme_ser.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import '../Controller/controllers.dart';
import '../Database/database.dart';
import '../models/tasks.dart';
import '../services/not_serv.dart';
import 'add_taskp.dart';
import 'package:http/http.dart' as http;

class hp extends StatefulWidget {

  const hp({Key? key}) : super(key: key);

  @override
  State<hp> createState() => _hpState();
}

class _hpState extends State<hp> {

  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }


  final  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();




  Future<String> fetchData() async {
    var url = Uri.parse('http://10.0.2.2:5000/data?');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Check if response body is null

        return response.body;

    } else {
      throw Exception('Failed to fetch data');
    }
  }
  _fetchAndAddReminders() async {
    try {
      String jsonData = await fetchData();
      List<dynamic> tasks = jsonDecode(jsonData);

      for (var taskData in tasks) {
        if (taskData is Map<String, dynamic>) {
          Task task = Task(
            title: taskData['title'],
            des: taskData['des'],
            date: taskData['date'],
            startTime: taskData['start_time'],
            endTime: taskData['end_time'],
            remind: 5, // Set a default reminder value
            isCompleted: 0,
          );

          int taskId = await _taskController.addTask(task: task);
          print('Added task with ID: $taskId');
          _taskController.getTasks();

        }
      }
    } catch (e) {
      print('Failed to fetch and add reminders: $e');
    }
  }


  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  final hour = TimeOfDay.now().hour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: _appBar(),

      body: Column(

        children: [

          _appTaskBar(),
          _addDateBar(),

          SizedBox(height: 20,),
          _showTasks(),
          _addButton(),
          //_addButton2(),
          //_addButton3(),
        ],
      ),
      drawer: Sidebar(),
    );
    // return Container();
  }
  Widget Sidebar() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 8), // Optional spacing between image and text
                Text(
                  'NEXA',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato', // Replace with the desired dense font
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),

          _addButton3(),
          ListTile(
            title: Text('Developed By:\n'
                        'M. Usman Khalid (FA19-BCE-094)\n'
                         'Hajra Fatima(FA19-BCE-072)',
                        style: TextStyle(fontWeight: FontWeight.bold)
              ),
            onTap: () {
              // Handle menu item 2 click
            },
          ),
          // Add more menu items if needed
        ],
      ),
    );
  }
  _showTasks(){
    return Expanded(
        child:Obx((){
          return ListView.builder(

              itemCount: _taskController.taskList.length,
              itemBuilder: (_,index) {
                print(_taskController.taskList.length);
                Task task = _taskController.taskList[index];
                print(task.toJson());

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child: Row(
                              children: [
                                GestureDetector(

                                    onTap: () {
                                      _showBottomSheet(context, task);
                                    },
                                    child: TaskTile(task
                                    )
                                )
                              ],
                            )
                        )
                    ),
                  );


                // if (task.date == DateFormat.yMd().format(_selectedDate)){


              } );


          }),
        );

  }
  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20, left:20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.deepPurpleAccent,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            )
        ),
        dayTextStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            )

        ),
        monthTextStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            )
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate = date;
          });
        } ,
      ),
    );
  }

  _appTaskBar(){
    final hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 18) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
   return Container(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal:20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text( greeting,
                  style: greetStyle,),
                Text( DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeadingStyle),

              ],
            ),

          ),
          _addButton2(),
          // MyButton(label: "+",onTap:() async {
          //   await Get.to(()=>AddTaskPage());
          //   _taskController.getTasks();
          // }
          // )

        ],
      ),
    );
  }
  _showBottomSheet(BuildContext context,Task task){
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted==1?
          MediaQuery.of(context).size.height*0.24:
          MediaQuery.of(context).size.height*0.32,
          color: Get.isDarkMode?Colors.black54:Colors.white,
       child: Column(
         children: [
           Container(
             height: 6,
             width: 120,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(12),
               color: Get.isDarkMode?Colors.grey:Colors.blueGrey
             ),
           ),
           SizedBox(height: 40,),
           task.isCompleted==1
           ?Container()
               :  _bottomsheetbutton(
             label: "Mark as Completed",
             onTap: (){
               _taskController.markcomp(task.id!);
                Get.back();
             },
             clr: indigo,
               context:context
           ),
           SizedBox(height: 20,),
           _bottomsheetbutton(
               label: "Delete",
               onTap: (){
                 _taskController.delete(task);
                 _taskController.getTasks();
                 Get.back();
               },
               clr: Colors.redAccent,
               context:context
           ),
           SizedBox(height: 20,),

         ],
       ),

    )
  );
  }
  _bottomsheetbutton({required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose=false,
    required BuildContext context,
  }){
    return GestureDetector(

      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
        height: 50,
        width: MediaQuery.of(context).size.width*0.9,
        // color:isClose==true?Colors.red:clr,
        decoration: BoxDecoration(
           border: Border.all(
             width:2,
             color:isClose==true?Colors.grey:clr,
           ),
            borderRadius: BorderRadius.circular(20),
            color:isClose==true?Colors.red:clr,

          ),
         child:Center(
           child: Text(
             label,
             style: isClose?titleStyle:titleStyle.copyWith(color:Colors.white),

           ),
         )

        ),

    );
  }
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          if (_scaffoldkey.currentState != null) {
            _scaffoldkey.currentState!.openDrawer();
          } // Add this line to open the sidebar
        },
        child: const Icon(
          Icons.menu,
          size: 20,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            ThemeSer().switchTheme();
            notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode ? "Dark theme" : "Light theme",
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: const Icon(
                Icons.nightlight_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _addButton(){
    return
        Container(
          margin: const EdgeInsets.only(right: 20, bottom: 20),
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
          onPressed: () async {
              await Get.to(()=>AddTaskPage());
              _taskController.getTasks();
          },
          backgroundColor: Colors.deepPurpleAccent,
          child: const Icon(Icons.add),
            elevation: 0.0, // Set the elevation to 0.0

          ),

    );
}
  void _fetchDataAndTasks() {
    _fetchAndAddReminders();
    _taskController.getTasks();
  }

  _addButton2(){
    return
      Container(
        margin: const EdgeInsets.only(left:5),
        alignment: Alignment.topRight,
        child: FloatingActionButton(
          onPressed:(_fetchDataAndTasks),
          backgroundColor: Colors.deepPurpleAccent,
          child: const Icon(Icons.refresh_rounded),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          elevation: 0.0,
        ),

      );
  }
  void _clearDatabase() async {
    await DB.clearDatabase();
    print('Database cleared.');
  }
  _addButton3(){
    return ListTile(
      leading: Icon(Icons.dangerous),
      title: Text('Clear Database'),
      onTap: () {
        _clearDatabase();
      },
    );
  }
  }