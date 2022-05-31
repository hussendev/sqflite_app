class Contact {
  late int id;
  late String name;
  late String mobile;
  late int blocked;

  Contact();
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = this.name;
    map['mobile'] = this.mobile;
    map['blocked'] = this.blocked;
    return map;
  }

  Contact.fromMap(Map<String, dynamic> data) {
    this.id = data['id'];
    this.name = data['name'];
    this.mobile = data['mobile'];
    this.blocked = data['blocked'];
  }
}
