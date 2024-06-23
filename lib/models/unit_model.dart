import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// create table [Unit] (
// 				, unitNo int
// 				, unitName string(100)
// 				)

class UnitModel {
  int? unitNo;
  String? unitName;
  UnitModel({
    this.unitNo,
    this.unitName,
  });
  

  UnitModel copyWith({
    int? unitNo,
    String? unitName,
  }) {
    return UnitModel(
      unitNo: unitNo ?? this.unitNo,
      unitName: unitName ?? this.unitName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unitNo': unitNo,
      'unitName': unitName,
    };
  }

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      unitNo: map['unitNo'] != null ? map['unitNo'] as int : null,
      unitName: map['unitName'] != null ? map['unitName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnitModel.fromJson(String source) => UnitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Unit(unitNo: $unitNo, unitName: $unitName)';

  @override
  bool operator ==(covariant UnitModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.unitNo == unitNo &&
      other.unitName == unitName;
  }

  @override
  int get hashCode => unitNo.hashCode ^ unitName.hashCode;
}
