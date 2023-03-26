class MassageModel {
  dynamic timeStamp;
  dynamic senderId;
  dynamic receiverId;
  dynamic message;

  MassageModel({this.timeStamp, this.senderId, this.receiverId, this.message});

  MassageModel.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
  }


  factory MassageModel.fromMap(map){
    return MassageModel(
      timeStamp: map['timeStamp'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      message: map['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeStamp'] = this.timeStamp;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['message'] = this.message;
    return data;
  }
}