class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category; // e.g. 'Pasta', 'Pizza', 'Drinks'
  final bool popular;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.popular = false,
  });
}
