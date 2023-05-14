class memonic {
  String? phrase;
  String? privateKey;
  String? address;

  memonic({this.phrase, this.privateKey, this.address});

  memonic.fromJson(Map<String, dynamic> json) {
    phrase = json['phrase'];
    privateKey = json['privateKey'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phrase'] = this.phrase;
    data['privateKey'] = this.privateKey;
    data['address'] = this.address;
    return data;
  }
}