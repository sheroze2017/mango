class convertRate {
  final String estimatedOutputAmount;
  final String gasFee;
  final double totalCost;

  convertRate(
      {required this.estimatedOutputAmount,
      required this.gasFee,
      required this.totalCost});
  factory convertRate.fromJson(Map<String, dynamic> json) {
    return convertRate(
        estimatedOutputAmount: json['estimatedOutputAmount'],
        gasFee: json['gasFee'],
        totalCost: json['totalCost']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['estimatedOutputAmount'] = this.estimatedOutputAmount;
  //   data['gasFee'] = this.gasFee;
  //   data['totalCost'] = this.totalCost;
  //   return data;
  // }
}
