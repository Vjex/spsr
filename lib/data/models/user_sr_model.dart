import 'dart:convert';

class SRModel {
  final int srid;
  final String name;
  final String mobile;
  final String email;
  final int spid;
  final String address;
  final double lat;
  final double lng;
  final int flag;
  final int custId;
  final String createdDate;
  final String updatedDate;
  final String assignedDate;
  SRModel({
    required this.srid,
    required this.name,
    required this.mobile,
    required this.email,
    required this.spid,
    required this.address,
    required this.lat,
    required this.lng,
    required this.flag,
    required this.custId,
    required this.createdDate,
    required this.updatedDate,
    required this.assignedDate,
  });

  SRModel copyWith({
    int? srid,
    String? name,
    String? mobile,
    String? email,
    int? spid,
    String? address,
    double? lat,
    double? lng,
    int? flag,
    int? custId,
    String? createdDate,
    String? updatedDate,
    String? assignedDate,
  }) {
    return SRModel(
      srid: srid ?? this.srid,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      spid: spid ?? this.spid,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      flag: flag ?? this.flag,
      custId: custId ?? this.custId,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      assignedDate: assignedDate ?? this.assignedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'srid': srid,
      'name': name,
      'mobile': mobile,
      'email': email,
      'spid': spid,
      'address': address,
      'lat': lat,
      'lng': lng,
      'flag': flag,
      'custid': custId,
      'createdDate': createdDate,
      'updateDate': updatedDate,
      'assignedDate': assignedDate,
    };
  }

  factory SRModel.fromMap(Map<String, dynamic> map) {
    return SRModel(
      srid: map['srid'],
      name: map['name'],
      mobile: map['mobile'],
      email: map['email'],
      spid: map['spid'],
      address: map['address'] != null ? map['address'] : '',
      lat: map['lat'] != null ? map['lat'] : 0.0,
      lng: map['lng'] != null ? map['lng'] : 0.0,
      flag: map['flag'] != null ? map['flag'] : 0,
      custId: map['custid'] != null ? map['custid'] : 0,
      createdDate: map['createdDate'],
      updatedDate: map['updateDate'] != null ? map['updateDate'] : '',
      assignedDate: map['assignedDate'] != null ? map['assignedDate'] : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SRModel.fromJson(String source) =>
      SRModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SRModel(srid: $srid, name: $name, mobile: $mobile, email: $email, spid: $spid, address: $address, lat: $lat, lng: $lng, flag: $flag, custId: $custId, createdDate: $createdDate, updatedDate: $updatedDate, assignedDate: $assignedDate)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is SRModel &&
  //     other.srid == srid &&
  //     other.name == name &&
  //     other.mobile == mobile &&
  //     other.email == email &&
  //     other.spid == spid &&
  //     other.address == address &&
  //     other.lat == lat &&
  //     other.lng == lng &&
  //     other.flag == flag &&
  //     other.custId == custId &&
  //     other.createdDate == createdDate &&
  //     other.updatedDate == updatedDate &&
  //     other.assignedDate == assignedDate;
  // }

  // @override
  // int get hashCode {
  //   return srid.hashCode ^
  //     name.hashCode ^
  //     mobile.hashCode ^
  //     email.hashCode ^
  //     spid.hashCode ^
  //     address.hashCode ^
  //     lat.hashCode ^
  //     lng.hashCode ^
  //     flag.hashCode ^
  //     custId.hashCode ^
  //     createdDate.hashCode ^
  //     updatedDate.hashCode ^
  //     assignedDate.hashCode;
  // }
}
