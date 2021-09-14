import 'dart:convert';

class SPModel {
  final int spid;
  final String name;
  final String mobile;
  final String email;
  final String address;
  final double lat;
  final double lng;
  final String createdDate;
  final String updatedDate;
  SPModel({
    required this.spid,
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.lat,
    required this.lng,
    required this.createdDate,
    required this.updatedDate,
  });

  SPModel copyWith({
    int? spid,
    String? name,
    String? mobile,
    String? email,
    String? address,
    double? lat,
    double? lng,
    String? createdDate,
    String? updatedDate,
  }) {
    return SPModel(
      spid: spid ?? this.spid,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'spid': spid,
      'name': name,
      'mobile': mobile,
      'email': email,
      'address': address,
      'lat_1': lat,
      'lng_1': lng,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
    };
  }

  factory SPModel.fromMap(Map<String, dynamic> map) {
    return SPModel(
      spid: map['spid'],
      name: map['name'],
      mobile: map['mobile'],
      email: map['email'],
      address: map['address'] != null ? map['address'] : '',
      lat: map['lat_1'] != null ? map['lat_1'] : 0.0,
      lng: map['lng_1'] != null ? map['lng_1'] : 0.0,
      createdDate: map['createdDate'] != null ? map['createdDate'] : '',
      updatedDate: map['updatedDate'] != null ? map['updatedDate'] : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SPModel.fromJson(String source) =>
      SPModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SPModel(spid: $spid, name: $name, mobile: $mobile, email: $email, address: $address, lat: $lat, lng: $lng, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is SPModel &&
  //     other.spid == spid &&
  //     other.name == name &&
  //     other.mobile == mobile &&
  //     other.email == email &&
  //     other.address == address &&
  //     other.lat == lat &&
  //     other.lng == lng &&
  //     other.createdDate == createdDate &&
  //     other.updatedDate == updatedDate;
  // }

  // @override
  // int get hashCode {
  //   return spid.hashCode ^
  //     name.hashCode ^
  //     mobile.hashCode ^
  //     email.hashCode ^
  //     address.hashCode ^
  //     lat.hashCode ^
  //     lng.hashCode ^
  //     createdDate.hashCode ^
  //     updatedDate.hashCode;
  // }
}
