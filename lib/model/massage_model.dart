class MassageModel{

  String? massage;

  MassageModel({this.massage});

  factory MassageModel.fromMap(map){
    return MassageModel(
      massage: map['massage'],
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'massage':massage,
    };
  }
}