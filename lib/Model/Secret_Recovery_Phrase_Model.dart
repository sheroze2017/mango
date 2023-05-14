// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SecretRecoveryPhraseModel {
   final int id;
   final String SRPhrase;
  SecretRecoveryPhraseModel({
    required this.id,
    required this.SRPhrase,
  });

  SecretRecoveryPhraseModel copyWith({
    int? id,
    String? SRPhrase,
  }) {
    return SecretRecoveryPhraseModel(
      id: id ?? this.id,
      SRPhrase: SRPhrase ?? this.SRPhrase,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'SRPhrase': SRPhrase,
    };
  }

  factory SecretRecoveryPhraseModel.fromMap(Map<String, dynamic> map) {
    return SecretRecoveryPhraseModel(
      id: map['id'] as int,
      SRPhrase: map['SRPhrase'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SecretRecoveryPhraseModel.fromJson(String source) => SecretRecoveryPhraseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SecretRecoveryPhraseModel(id: $id, SRPhrase: $SRPhrase)';

  @override
  bool operator ==(covariant SecretRecoveryPhraseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.SRPhrase == SRPhrase;
  }

  @override
  int get hashCode => id.hashCode ^ SRPhrase.hashCode;
}
