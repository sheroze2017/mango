// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WalletModel {
  final int id;
  final String Imag;
  final String Title;
  final int Price;
  WalletModel({
    required this.id,
    required this.Imag,
    required this.Title,
    required this.Price,
  });

  WalletModel copyWith({
    int? id,
    String? Imag,
    String? Title,
    int? Price,
  }) {
    return WalletModel(
      id: id ?? this.id,
      Imag: Imag ?? this.Imag,
      Title: Title ?? this.Title,
      Price: Price ?? this.Price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Imag': Imag,
      'Title': Title,
      'Price': Price,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'] as int,
      Imag: map['Imag'] as String,
      Title: map['Title'] as String,
      Price: map['Price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WalletModel(id: $id, Imag: $Imag, Title: $Title, Price: $Price)';
  }

  @override
  bool operator ==(covariant WalletModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.Imag == Imag &&
        other.Title == Title &&
        other.Price == Price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ Imag.hashCode ^ Title.hashCode ^ Price.hashCode;
  }
}
