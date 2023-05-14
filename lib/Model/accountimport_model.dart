class accountPK {
  final String privateKey;
  final String address;

  accountPK({required this.privateKey,required this.address});

factory accountPK.fromJson(Map<String, dynamic> json) {
  return accountPK(
  // accountPK.fromJson(Map<String, dynamic> json) {
    privateKey : json['privateKey'],
    address : json['address'],
);  
}

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['privateKey'] = this.privateKey;
  //   data['address'] = this.address;
  //   return data;
  // }
}