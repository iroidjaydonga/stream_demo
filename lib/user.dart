class User {
  String sId;
  String picture;
  String birthday;
  String name;
  String gender;
  String company;
  String email;
  String phone;
  String address;

  User({this.sId, this.picture, this.birthday, this.name, this.gender, this.company, this.email, this.phone, this.address});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    picture = json['picture'];
    birthday = json['birthday'];
    name = json['name'];
    gender = json['gender'];
    company = json['company'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['picture'] = this.picture;
    data['birthday'] = this.birthday;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['company'] = this.company;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class Name {
  List<String> name;

  Name({this.name});

  Name.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    return data;
  }
}
