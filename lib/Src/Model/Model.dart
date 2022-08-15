class Model{
  int?id;
  int?gen;
  String?name;
  String?birthday;
  String?gender;
  String?image;
  String?color;

  Model({
    this.gen,
    this.id,
    this.birthday,
    this.name,
    this.gender,
    this.color,
    this.image
});

  Model.fromJson(Map<String,dynamic> json){
    gen = json["gen"];
    id = json["id"];
    name = json["name"];
    birthday = json["birthday"];
    gender = json["gender"];
    image = json["image"];
    color = json["color"];
  }
}