class Transaction {
  final String id;
  final String type;
  final String date;
  final String quantity;
  final String notes;
  final String price;

  Transaction({
    required this.id,
    required this.type,
    required this.date,
    required this.quantity,
    required this.notes,
    required this.price,
  });
}
