import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// create database "Interview"
// 	create table [InvoiceDetails] (
// 				lineNo int
// 				, productName string(100)
// 				, UnitNo int
// 				, price decimal
// 				, quantity decimal
// 				, total decimal
// 				, expiryDate datetime
// 				)

class InvoiceDetailsModel {
  int? lineNo;
  String? productName;
  int? unitNo;
  double? price;
  double? quantity;
  double? total;
  DateTime? expiryDate;
  InvoiceDetailsModel({
    this.lineNo,
    this.productName,
    this.unitNo,
    this.price,
    this.quantity,
    this.total,
    this.expiryDate,
  });

  InvoiceDetailsModel copyWith({
    int? lineNo,
    String? productName,
    int? unitNo,
    double? price,
    double? quantity,
    double? total,
    DateTime? expiryDate,
  }) {
    return InvoiceDetailsModel(
      lineNo: lineNo ?? this.lineNo,
      productName: productName ?? this.productName,
      unitNo: unitNo ?? this.unitNo,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lineNo': lineNo,
      'productName': productName,
      'unitNo': unitNo,
      'price': price,
      'quantity': quantity,
      'total': total,
      'expiryDate': expiryDate?.millisecondsSinceEpoch,
    };
  }

  factory InvoiceDetailsModel.fromMap(Map<String, dynamic> map) {
    return InvoiceDetailsModel(
      lineNo: map['lineNo'] != null ? map['lineNo'] as int : null,
      productName: map['productName'] != null ? map['productName'] as String : null,
      unitNo: map['unitNo'] != null ? map['unitNo'] as int : null,
      price: map['price'] != null ? map['price'] as double : null,
      quantity: map['quantity'] != null ? map['quantity'] as double : null,
      total: map['total'] != null ? map['total'] as double : null,
      expiryDate: map['expiryDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['expiryDate'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceDetailsModel.fromJson(String source) => InvoiceDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceDetails(lineNo: $lineNo, productName: $productName, unitNo: $unitNo, price: $price, quantity: $quantity, total: $total, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(covariant InvoiceDetailsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.lineNo == lineNo &&
      other.productName == productName &&
      other.unitNo == unitNo &&
      other.price == price &&
      other.quantity == quantity &&
      other.total == total &&
      other.expiryDate == expiryDate;
  }

  @override
  int get hashCode {
    return lineNo.hashCode ^
      productName.hashCode ^
      unitNo.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      total.hashCode ^
      expiryDate.hashCode;
  }
}
