class swapf3 {
  final String from;
  final num gasLimit;

  swapf3({required this.from, required this.gasLimit});

  factory swapf3.fromJson(Map<String, dynamic> json) {
    return swapf3(
      // swapf3.fromJson(Map<String, dynamic> json) {
      from: json['from'],
      gasLimit: json['gasLimit'],
    );
  }
}
