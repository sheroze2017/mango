class importwallet {
  final String privateKey;
  final String address;
  final String balance;
  final String encryptpk;
  importwallet(
      {required this.privateKey,
      required this.address,
      required this.balance,
      required this.encryptpk});
  factory importwallet.fromJson(Map<String, dynamic> json) {
    return importwallet(
        privateKey: json['privateKey'],
        address: json['address']['address'],
        encryptpk: json['address']['privateKey'],
        balance: json['balance']);
  }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['privateKey'] = this.privateKey;
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     data['balance'] = this.balance;
//     return data;
//   }
}

class Address {
  String? address;
  String? privateKey;

  Address({this.address, this.privateKey});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    privateKey = json['privateKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['privateKey'] = this.privateKey;
    return data;
  }
}
