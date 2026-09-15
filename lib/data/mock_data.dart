import '../models/menu_item.dart';
import '../models/restaurant.dart';

/// NOTE ON IMAGES
/// These use Lorem Picsum (picsum.photos) — a free, no-auth, commercially
/// safe placeholder image service — seeded so each restaurant/dish always
/// gets the *same* image on every run. This keeps the app fully runnable
/// out of the box with just an internet connection on the emulator.
///
/// For your final submission/presentation, it's worth swapping these for
/// local assets instead (see README.md -> "Using local images"), matching
/// the exact photos Cowork placed in your Figma file. That removes any
/// wifi dependency during your live demo and keeps the app pixel-consistent
/// with your prototype.

const List<Restaurant> mockRestaurants = [
  Restaurant(
    id: 'casa-verona',
    name: 'Casa Verona',
    cuisine: 'Italian',
    imageUrl: 'https://picsum.photos/seed/casaverona/800/500',
    rating: 4.8,
    distanceKm: '0.8 km',
    priceRange: r'$$',
    hours: 'Closes 11:00 PM',
    avgWait: '25 min',
    reviewCount: '1.2k reviews',
    about:
        'Warm neighbourhood Italian dining with handmade pasta, wood-fired '
        'favourites and relaxed evening service.',
  ),
  Restaurant(
    id: 'saffron-table',
    name: 'Saffron Table',
    cuisine: 'Modern Indian',
    imageUrl: 'https://picsum.photos/seed/saffrontable/800/500',
    rating: 4.7,
    distanceKm: '1.1 km',
    priceRange: r'$$',
    hours: 'Closes 10:30 PM',
    avgWait: '20 min',
    reviewCount: '860 reviews',
    about:
        'Contemporary Indian small plates built around slow-cooked spice '
        'blends and a relaxed, modern dining room.',
  ),
  Restaurant(
    id: 'harbour-grill',
    name: 'Harbour Grill',
    cuisine: 'Seafood & Grill',
    imageUrl: 'https://picsum.photos/seed/harbourgrill/800/500',
    rating: 4.6,
    distanceKm: '1.6 km',
    priceRange: r'$$$',
    hours: 'Closes 11:30 PM',
    avgWait: '30 min',
    reviewCount: '540 reviews',
    about:
        'Waterfront grill specialising in charcoal-fired seafood and steaks, '
        'with a seasonal, market-driven menu.',
  ),
];

/// Menu items for Casa Verona (the restaurant used throughout the primary
/// booking flow, matching the Figma prototype screens).
const List<MenuItem> casaVeronaMenu = [
  MenuItem(
    id: 'truffle-tagliatelle',
    name: 'Truffle Tagliatelle',
    description: 'Creamy mushroom, parmesan',
    price: 24.90,
    imageUrl: 'https://picsum.photos/seed/tagliatelle/200/200',
    category: 'Pasta',
    popular: true,
  ),
  MenuItem(
    id: 'burrata-tomato',
    name: 'Burrata & Tomato',
    description: 'Basil, olive oil, sea salt',
    price: 18.50,
    imageUrl: 'https://picsum.photos/seed/burrata/200/200',
    category: 'Popular',
    popular: true,
  ),
  MenuItem(
    id: 'margherita-pizza',
    name: 'Margherita Pizza',
    description: 'Tomato, mozzarella, basil',
    price: 21.00,
    imageUrl: 'https://picsum.photos/seed/margherita/200/200',
    category: 'Pizza',
    popular: true,
  ),
  MenuItem(
    id: 'tiramisu',
    name: 'Tiramisu',
    description: 'Espresso, mascarpone, cocoa',
    price: 12.00,
    imageUrl: 'https://picsum.photos/seed/tiramisu/200/200',
    category: 'Popular',
    popular: true,
  ),
];

const List<String> menuCategories = ['Popular', 'Pasta', 'Pizza', 'Drinks'];

const List<String> cuisineFilters = ['Italian', 'Asian', 'Burger', 'Dessert'];

const List<String> bookingDates = ['FRI\n23', 'SAT\n24', 'SUN\n25', 'MON\n26'];

const List<String> bookingTimes = [
  '6:30 PM',
  '7:00 PM',
  '7:30 PM',
  '8:00 PM',
  '8:30 PM',
  '9:00 PM',
];

const List<String> seatingOptions = ['Indoor', 'Outdoor', 'No preference'];

/// Original-feature data: a lightweight "popular at this time" hint shown
/// during Table Booking, keyed by selected time slot. This is the small
/// original touch beyond a generic booking-app clone (see build plan,
/// Section 6) — it nudges the user toward a pre-order suggestion based on
/// what's typically ordered at that time, without needing a real backend.
const Map<String, String> popularAtTime = {
  '6:30 PM': 'Burrata & Tomato',
  '7:00 PM': 'Margherita Pizza',
  '7:30 PM': 'Truffle Tagliatelle',
  '8:00 PM': 'Truffle Tagliatelle',
  '8:30 PM': 'Tiramisu',
  '9:00 PM': 'Tiramisu',
};
