
class Task {
  int? id;
  String? title;
  String? des;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;

  Task({this.id, this.title, this.des, this.isCompleted, this.date, this.startTime, this.endTime, this.remind});

  Task.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    des = json['des'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['des'] = this.des;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['remind'] = this.remind;
    return data;
  }
}