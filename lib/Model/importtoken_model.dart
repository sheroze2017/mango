class importToken {
  final String balance;
  final String tokenAddress;
  final String walletAddress;
  final String symbol;
 final  String rpc;

  importToken(
      {required this.balance,
 required     this.tokenAddress,
   required   this.walletAddress,
   required   this.symbol,
   required   this.rpc});

factory importToken.fromJson(Map<String, dynamic> json) {
    return importToken(
    balance : json['balance'],
    tokenAddress : json['token_address'],
    walletAddress : json['wallet_address'],
    symbol : json['symbol'],
    rpc : json['rpc'],
  );}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['token_address'] = this.tokenAddress;
    data['wallet_address'] = this.walletAddress;
    data['symbol'] = this.symbol;
    data['rpc'] = this.rpc;
    return data;
  }
}