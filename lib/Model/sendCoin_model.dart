class sendCoin {
  final dynamic hash;
  sendCoin({required this.hash});

  factory sendCoin.fromJson(Map<String, dynamic> json) {
    return sendCoin(hash: json['hash']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hash'] = this.hash;
    return data;
  }
}
