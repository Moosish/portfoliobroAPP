class Stock {
  String name;
  int shares;
  double currentPrice;

  Stock({required this.name, required this.shares, required this.currentPrice});

  double get totalValue => shares * currentPrice;
}
