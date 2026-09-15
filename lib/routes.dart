import 'package:flutter/material.dart';

import 'screens/cart_screen.dart';
import 'screens/confirmation_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/google_signin_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/my_bookings_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/restaurant_details_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/table_booking_screen.dart';

/// Central route table. Using onGenerateRoute (rather than the simple
/// `routes:` map) because several screens need typed arguments passed
/// through `settings.arguments` (Restaurant, Booking, etc.).
class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const createAccount = '/create-account';
  static const googleSignIn = '/google-signin';
  static const home = '/home';
  static const restaurantDetails = '/restaurant-details';
  static const menu = '/menu';
  static const cart = '/cart';
  static const tableBooking = '/table-booking';
  static const confirmation = '/confirmation';
  static const myBookings = '/my-bookings';
  static const profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case login:
        page = const LoginScreen();
        break;
      case createAccount:
        page = const CreateAccountScreen();
        break;
      case googleSignIn:
        page = const GoogleSignInScreen();
        break;
      case home:
        page = const HomeScreen();
        break;
      case restaurantDetails:
        page = const RestaurantDetailsScreen();
        break;
      case menu:
        page = const MenuScreen();
        break;
      case cart:
        page = const CartScreen();
        break;
      case tableBooking:
        page = const TableBookingScreen();
        break;
      case confirmation:
        page = const ConfirmationScreen();
        break;
      case myBookings:
        page = const MyBookingsScreen();
        break;
      case profile:
        page = const ProfileScreen();
        break;
      case splash:
      default:
        page = const SplashScreen();
    }
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
