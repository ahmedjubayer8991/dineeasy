# DineEasy — Flutter App (Assessment 4)

All 9 screens from the Figma prototype, fully wired together with real
navigation and interactive state (search/filter, menu → cart, table
booking with live selection state, and a booking confirmation flow).

## What's implemented (functional)

- **Splash → Login → Home**: full navigation chain
- **Home**: search field, cuisine filter chips (interactive), featured +
  popular restaurant cards, tapping any restaurant opens its details
- **Restaurant Details**: favourite toggle, "View Menu" and "Book Table"
  both navigate correctly
- **Menu**: category filter chips, "add to cart" with live cart badge,
  snackbar feedback
- **Cart**: quantity steppers, live subtotal/total calculation, special
  request field
- **Table Booking**: interactive date/time/seating chips (using the
  corrected #C2410C contrast colour), guest counter, and an original
  "popular at this time" suggestion feature
- **Confirmation**: displays back the actual selections made in Table
  Booking, with a generated booking ID
- **My Bookings**: shows the just-confirmed booking pulled from app
  state, plus mock past bookings and a profile card

## What's new: Create Account, Google Sign-In consequence, Profile

Beyond the original 9 Figma screens, three screens were added based on
usability feedback during development (silent/no-op buttons read as
broken in a live demo):

- **Create Account** (`/create-account`): real client-side form
  validation (name, valid email format, 6+ char password, matching
  confirmation), then proceeds to Home. Still mocked — no real backend
  — but no longer silently accepts anything.
- **Continue with Google** (`/google-signin`): rather than pretending to
  integrate real Google OAuth (out of scope — needs Firebase/platform
  config), this shows a short loading state then a clearly-labelled
  **mock** account picker ("Prototype simulation — not a real Google
  sign-in"). This gives the button a visible consequence without
  misrepresenting it as genuine third-party auth.
- **Profile** (`/profile`): standalone screen with avatar, name/email,
  Dietary preferences / Notifications / Privacy rows (each shows a
  "not implemented" snackbar on tap — honest, not silent), and a
  working **Log out** button that clears the cart and returns to Login.
  The bottom nav's Profile tab and My Bookings' "Profile" link both
  point here now.

**Login itself** now also has the same real validation (non-empty,
well-formed email, 6+ char password) before proceeding — still no real
backend, but no longer accepts empty/garbage input silently.

## What's still intentionally non-functional (name this in your report)

- "Forgot password?" (shows a "not implemented" snackbar)
- Dietary preferences / Notifications / Privacy rows on Profile (each
  shows a "not implemented" snackbar — consistent, honest feedback
  rather than doing nothing)
- Search field on Home doesn't currently filter the list (visual only)
- "Manage booking" on My Bookings (shows a "not implemented" snackbar)

## A note on scope for your report

These three additions were not required by the assessment brief (which
only asks for a minimum of two implemented features) and go beyond your
original Assessment 3 Figma prototype's 9 screens. If you add matching
screens to your Figma file before submission, keep the same design
system (colors/typography/spacing) so the prototype and build stay
consistent — this is worth naming explicitly in your report's
"functional and non-functional features" section, framed as: added
post-development to remove dead-end/no-op interactions identified
during your own testing.

These are reasonable, explainable scope cuts for a prototype-stage app —
name them explicitly in your Assessment 4 report's "remaining
functionalities" section rather than leaving them unexplained.

## How to run

1. Copy everything inside this `lib/` folder into your existing
   `dineeasy` Flutter project's `lib/` folder, **replacing** the default
   `main.dart` Flutter generates.
2. No new packages are required — this uses only Flutter's built-in
   `material` library. You do not need to edit `pubspec.yaml`.
3. Make sure your Android emulator (or `chrome`) is running.
4. From the project root:
   ```
   flutter run
   ```

## Using local images instead of network images

Images currently load from `picsum.photos` (a free, no-auth service) so
the app runs immediately with just an internet connection. For your
final presentation, it's worth switching to local assets that exactly
match your Figma file's photography, so the demo doesn't depend on wifi:

1. Download the same images Cowork placed in your Figma file (or your
   own picks) into a new folder: `assets/images/`
2. In `pubspec.yaml`, under `flutter:`, add:
   ```yaml
   flutter:
     assets:
       - assets/images/
   ```
3. In `lib/data/mock_data.dart`, replace each `imageUrl:
   'https://picsum.photos/...'` with a local path, e.g.
   `'assets/images/casa_verona.jpg'`
4. In the widget files (`restaurant_card.dart`, `menu_item_tile.dart`,
   `cart_screen.dart`, `restaurant_details_screen.dart`), change
   `Image.network(...)` to `Image.asset(...)` for those fields.

## Architecture notes (useful for your report)

- **State management**: a single `AppState` singleton
  (`lib/state/app_state.dart`) holds the cart and last booking, updated
  via `setState()` in the screens that need it. This is a deliberate,
  explainable choice for a prototype of this scope — it avoids pulling
  in Provider/Riverpod/Bloc for what is fundamentally a small amount of
  shared state.
- **Navigation**: named routes via `onGenerateRoute`
  (`lib/routes.dart`), which supports passing typed arguments
  (`Restaurant`, `Booking`) between screens cleanly.
- **Design system**: all colors, text styles, spacing, and radii are
  centralised in `lib/theme/app_theme.dart`, matching the corrected
  Figma file (including the WCAG-compliant `#C2410C` selected-state
  orange).
- **Original feature**: the "popular at this time" hint on the Table
  Booking screen (`popularAtTime` map in `mock_data.dart`) is the small
  original addition beyond a generic booking-app clone, aimed at the
  "usefulness & originality" rubric criterion.
