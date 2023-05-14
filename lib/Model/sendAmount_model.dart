class sendamount {
  final dynamic response;
  sendamount({required this.response});

  factory sendamount.fromJson(Map<String, dynamic> json) {
    return sendamount(response: json['response']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    return data;
  }
}
