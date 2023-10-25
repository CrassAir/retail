class ShortOrganization {
  late String id;
  late String name;
  late int type;

  ShortOrganization();

  ShortOrganization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
  };

}


class Organization {
  String? id;
  late String name;
  late int type;
  late int tin;
  int? rrc;
  String? legalAddress;
  String? actualAddress;
  String? phone;
  String? email;
  late List<int> taxSystems;

  Organization();

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    tin = json['tin'];
    rrc = json['rrc'];
    legalAddress = json['legalAddress'];
    actualAddress = json['actualAddress'];
    phone = json['phone'];
    email = json['email'];
    taxSystems = json['taxSystems'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'tin': tin,
    'rrc': rrc,
    'legalAddress': legalAddress,
    'actualAddress': actualAddress,
    'phone': phone,
    'email': email,
    'taxSystems': taxSystems,
  };
}