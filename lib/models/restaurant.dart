class Restaurant {
  final String id;
  final String name;
  final String cuisine;
  final String imageUrl;
  final double rating;
  final String distanceKm;
  final String priceRange;
  final String hours;
  final String avgWait;
  final String reviewCount;
  final String about;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.imageUrl,
    required this.rating,
    required this.distanceKm,
    required this.priceRange,
    required this.hours,
    required this.avgWait,
    required this.reviewCount,
    required this.about,
  });
}
