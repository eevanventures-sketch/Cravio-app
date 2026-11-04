import 'package:flutter/material.dart';

void main() {
  runApp(const CravioApp());
}

// ---------------- GLOBAL STATE & MODELS ----------------
class OrderItem {
  final String title;
  final int price;
  int qty;
  OrderItem({required this.title, required this.price, this.qty = 1});
}

class ActiveOrder {
  final String id;
  final String customerName;
  final String customerPhone;
  final String address;
  final String restaurantName;
  final List<OrderItem> items;
  final int totalAmount;
  String status; // 'Placed', 'Accepted', 'Preparing', 'Ready', 'Delivered'

  ActiveOrder({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.restaurantName,
    required this.items,
    required this.totalAmount,
    this.status = 'Placed',
  });
}

// App Wide State Controller
class AppState extends ChangeNotifier {
  static final AppState instance = AppState();

  bool isHindi = true;
  String currentRole = 'Customer'; // 'Customer', 'Restaurant', 'Admin'
  String userName = "Rahul Sharma";
  String userPhone = "98260XXXXX";
  String userAddress = "Near Nehru Chowk, Ganj Basoda";

  List<ActiveOrder> liveOrders = [];
  Map<String, int> cart = {};
  String activeRestaurant = "";

  void toggleLanguage() {
    isHindi = !isHindi;
    notifyListeners();
  }

  void setRole(String role) {
    currentRole = role;
    notifyListeners();
  }

  void addToCart(String itemName, String restaurant) {
    if (activeRestaurant.isNotEmpty && activeRestaurant != restaurant) {
      cart.clear(); // Clear cart if restaurant changes
    }
    activeRestaurant = restaurant;
    cart[itemName] = (cart[itemName] ?? 0) + 1;
    notifyListeners();
  }

  void removeFromCart(String itemName) {
    if (cart.containsKey(itemName)) {
      if (cart[itemName]! > 1) {
        cart[itemName] = cart[itemName]! - 1;
      } else {
        cart.remove(itemName);
        if (cart.isEmpty) activeRestaurant = "";
      }
      notifyListeners();
    }
  }

  void placeOrder(List<OrderItem> items, int total) {
    final newOrder = ActiveOrder(
      id: "CRV-${DateTime.now().millisecondsSinceEpoch % 10000}",
      customerName: userName,
      customerPhone: userPhone,
      address: userAddress,
      restaurantName: activeRestaurant,
      items: List.from(items),
      totalAmount: total,
    );
    liveOrders.insert(0, newOrder);
    cart.clear();
    activeRestaurant = "";
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final idx = liveOrders.indexWhere((o) => o.id == orderId);
    if (idx != -1) {
      liveOrders[idx].status = newStatus;
      notifyListeners();
    }
  }
}

// ---------------- MAIN APPLICATION ----------------
class CravioApp extends StatelessWidget {
  const CravioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'Cravio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xFFFF5722),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5722)),
            scaffoldBackgroundColor: const Color(0xFFF9FAFB),
            fontFamily: 'Roboto',
          ),
          home: const MainGateScreen(),
        );
      },
    );
  }
}

class MainGateScreen extends StatefulWidget {
  const MainGateScreen({super.key});

  @override
  State<MainGateScreen> createState() => _MainGateScreenState();
}

class _MainGateScreenState extends State<MainGateScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    // Role-based views
    if (state.currentRole == 'Restaurant') {
      return const RestaurantPartnerDashboard();
    }
    if (state.currentRole == 'Admin') {
      return const EevaanAdminDashboard();
    }

    // Default: Customer View with Bottom Navigation
    final pages = [
      const CustomerHomeScreen(),
      const CustomerOrdersScreen(),
      const ProfileAndSettingsScreen(),
    ];

    return Scaffold(
      body: pages[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: const Color(0xFFFF5722),
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant),
            label: state.isHindi ? "होम" : "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt_long),
            label: state.isHindi ? "मेरे ऑर्डर" : "Orders",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: state.isHindi ? "प्रोफ़ाइल" : "Profile",
          ),
        ],
      ),
    );
  }
}

// ---------------- CUSTOMER HOME SCREEN ----------------
class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  static final List<Map<String, dynamic>> basodaRestaurants = [
    {
      "name": "Hotel Marwari",
      "hindiName": "होटल मारवाड़ी",
      "tag": "North Indian, Thali & Sweets",
      "rating": "4.5",
      "time": "20-25 min",
      "discount": "FLAT ₹30 OFF",
      "menu": [
        {"name": "मारवाड़ी स्पेशल थाली", "en": "Marwari Special Thali", "price": 180, "veg": true},
        {"name": "दाल बाटी चूरमा थाली", "en": "Dal Baati Churma", "price": 150, "veg": true},
        {"name": "पनीर बटर मसाला", "en": "Paneer Butter Masala", "price": 160, "veg": true},
        {"name": "तंदूरी बटर रोटी", "en": "Tandoori Butter Roti", "price": 15, "veg": true},
        {"name": "गुलाब जामुन (2 पीस)", "en": "Gulab Jamun (2 Pcs)", "price": 40, "veg": true},
      ]
    },
    {
      "name": "Da Pixza Lover",
      "hindiName": "दा पिज़्ज़ा लवर",
      "tag": "Pizza, Burgers, Shakes",
      "rating": "4.4",
      "time": "15-20 min",
      "discount": "20% OFF",
      "menu": [
        {"name": "फार्महाउस चीज़ी पिज़्ज़ा (7 Inch)", "en": "Farmhouse Cheesy Pizza", "price": 199, "veg": true},
        {"name": "क्रंची वेज चीज़ बर्गर", "en": "Crunchy Veg Cheese Burger", "price": 79, "veg": true},
        {"name": "पेरी पेरी फ्रेंच फ्राइज़", "en": "Peri Peri French Fries", "price": 89, "veg": true},
        {"name": "थिक चॉकलेट कोल्ड कॉफ़ी", "en": "Chocolate Cold Coffee", "price": 80, "veg": true},
      ]
    },
    {
      "name": "The Pride Restaurant",
      "hindiName": "द प्राइड रेस्टोरेंट",
      "tag": "North Indian, Chinese & Biryani",
      "rating": "4.3",
      "time": "25-30 min",
      "discount": "FREE DELIVERY",
      "menu": [
        {"name": "पनीर टिक्का मसाला", "en": "Paneer Tikka Masala", "price": 210, "veg": true},
        {"name": "शाही वेज दम बिरयानी", "en": "Shahi Veg Biryani", "price": 170, "veg": true},
        {"name": "चिली पनीर ग्रेवी", "en": "Chilli Paneer Gravy", "price": 160, "veg": true},
      ]
    },
    {
      "name": "Sweets Ganga",
      "hindiName": "स्वीट्स गंगा (नेहरू चौक)",
      "tag": "Samosa, Jalebi & Desi Sweets",
      "rating": "4.6",
      "time": "15 min",
      "discount": "TOP SELLER",
      "menu": [
        {"name": "गरमा-गरम समोसा (2 पीस)", "en": "Hot Samosa (2 Pcs)", "price": 30, "veg": true},
        {"name": "शुद्ध देशी घी जलेबी (250g)", "en": "Desi Ghee Jalebi (250g)", "price": 80, "veg": true},
        {"name": "स्पेशल काजू कतली (250g)", "en": "Kaju Katli (250g)", "price": 220, "veg": true},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFFFF5722), size: 18),
                const SizedBox(width: 4),
                Text(
                  state.isHindi ? "गंजबासौदा" : "Ganj Basoda",
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              state.userAddress,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          // Language Switcher Button
          TextButton.icon(
            onPressed: () => state.toggleLanguage(),
            icon: const Icon(Icons.language, size: 18, color: Color(0xFFFF5722)),
            label: Text(
              state.isHindi ? "English" : "हिंदी",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF5722)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Top Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFF5722), Color(0xFFFF8A65)]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.isHindi ? "क्रेवियो एक्सक्लूसिव" : "CRAVIO EXCLUSIVE",
                        style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        state.isHindi ? "काउंटर रेट पर खाना\nघर बैठे मंगवाएं!" : "Dine-in Menu Rates\nDelivered Home!",
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.delivery_dining, size: 60, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 22),

          Text(
            state.isHindi ? "गंजबासौदा के प्रमुख रेस्टोरेंट" : "Top Restaurants in Ganj Basoda",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Restaurant Cards
          ...basodaRestaurants.map((res) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestaurantMenuScreen(restaurant: res)),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(Icons.restaurant_menu, size: 48, color: Colors.orange.shade400),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.isHindi ? res["hindiName"] : res["name"],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
                            child: Text("★ ${res["rating"]}", style: const TextStyle(color: Colors.white, fontSize: 11)),
                          ),
                        ],
                      ),
                      Text(res["tag"], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                      const Divider(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("⏱ ${res["time"]}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          Text(
                            res["discount"],
                            style: const TextStyle(fontSize: 12, color: Color(0xFFFF5722), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// ---------------- RESTAURANT MENU SCREEN ----------------
class RestaurantMenuScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  const RestaurantMenuScreen({super.key, required this.restaurant});

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    final List<Map<String, dynamic>> menu = widget.restaurant["menu"];
    final rName = widget.restaurant["name"];

    int totalAmount = 0;
    int totalItems = 0;
    List<OrderItem> selectedItems = [];

    state.cart.forEach((itemName, qty) {
      final found = menu.firstWhere((m) => m["name"] == itemName || m["en"] == itemName, orElse: () => {});
      if (found.isNotEmpty) {
        totalAmount += (found["price"] as int) * qty;
        totalItems += qty;
        selectedItems.add(OrderItem(title: state.isHindi ? found["name"] : found["en"], price: found["price"], qty: qty));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(state.isHindi ? widget.restaurant["hindiName"] : widget.restaurant["name"]),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: menu.length,
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemBuilder: (context, idx) {
          final item = menu[idx];
          final String itemKey = item["name"];
          final int qty = state.cart[itemKey] ?? 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Colors.green, size: 14),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            state.isHindi ? item["name"] : item["en"],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text("₹${item["price"]}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
                  ],
                ),
              ),
              // Add / Remove Counter
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFF5722)),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: qty == 0
                    ? TextButton(
                        onPressed: () => setState(() => state.addToCart(itemKey, rName)),
                        child: Text(
                          state.isHindi ? "+ जोड़ें" : "+ ADD",
                          style: const TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.bold),
                        ),
                      )
                    : Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16, color: Color(0xFFFF5722)),
                            onPressed: () => setState(() => state.removeFromCart(itemKey)),
                          ),
                          Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16, color: Color(0xFFFF5722)),
                            onPressed: () => setState(() => state.addToCart(itemKey, rName)),
                          ),
                        ],
                      ),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: totalItems > 0
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -3))],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  _showCheckoutSheet(context, selectedItems, totalAmount);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(
                        "$totalItems ${state.isHindi ? 'आइटम' : 'Items'} | ₹$totalAmount",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Text(
                        state.isHindi ? "ऑर्डर करें ➔" : "Checkout ➔",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  void _showCheckoutSheet(BuildContext context, List<OrderItem> items, int subtotal) {
    final state = AppState.instance;
    const deliveryFee = 20;
    final total = subtotal + deliveryFee;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.isHindi ? "ऑर्डर का विवरण" : "Bill Summary",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 20),
              ...items.map((i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${i.title} x ${i.qty}"),
                        Text("₹${i.price * i.qty}"),
                      ],
                    ),
                  )),
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.isHindi ? "डिलीवरी शुल्क" : "Delivery Fee"),
                  const Text("₹$deliveryFee"),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.isHindi ? "कुल भुगतान (COD)" : "Total Bill (COD)", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("₹$total", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFFF5722))),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "${state.isHindi ? 'डिलीवरी पता:' : 'Delivering To:'} ${state.userAddress}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    state.placeOrder(items, total);
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.isHindi ? "🎉 ऑर्डर सफलतापूर्वक दर्ज हुआ!" : "🎉 Order Placed Successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Text(
                    state.isHindi ? "ऑर्डर कन्फर्म करें (कैश ऑन डिलीवरी)" : "Confirm Order (Cash on Delivery)",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------- CUSTOMER ORDERS SCREEN ----------------
class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(state.isHindi ? "मेरे ऑर्डर" : "My Orders"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: state.liveOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.receipt_long, size: 70, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    state.isHindi ? "अभी कोई सक्रिय ऑर्डर नहीं है" : "No active orders yet",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.liveOrders.length,
              itemBuilder: (context, idx) {
                final o = state.liveOrders[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(o.id, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: o.status == 'Delivered' ? Colors.green.shade100 : Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                o.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: o.status == 'Delivered' ? Colors.green.shade800 : Colors.orange.shade800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(o.restaurantName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const Divider(height: 16),
                        ...o.items.map((i) => Text("${i.title} x ${i.qty}", style: const TextStyle(fontSize: 13))),
                        const Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.isHindi ? "कुल राशि (COD)" : "Total Bill", style: const TextStyle(color: Colors.grey)),
                            Text("₹${o.totalAmount}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ---------------- RESTAURANT PARTNER SCREEN ----------------
class RestaurantPartnerDashboard extends StatelessWidget {
  const RestaurantPartnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.isHindi ? "रेस्टोरेंट पार्टनर पोर्टल" : "Restaurant Partner Panel"),
            const Text("Hotel Marwari (Ganj Basoda)", style: TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: "Switch Role",
            onPressed: () => state.setRole('Customer'),
          )
        ],
      ),
      body: state.liveOrders.isEmpty
          ? const Center(child: Text("कोई नया ऑर्डर नहीं है (No New Orders)"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.liveOrders.length,
              itemBuilder: (context, idx) {
                final o = state.liveOrders[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order ID: ${o.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text("Status: ${o.status}", style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(),
                        Text("ग्राहक: ${o.customerName} (${o.customerPhone})"),
                        Text("पता: ${o.address}"),
                        const SizedBox(height: 6),
                        ...o.items.map((i) => Text("• ${i.title} x ${i.qty}", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                              onPressed: () => state.updateOrderStatus(o.id, 'Preparing'),
                              child: const Text("स्वीकार करें (Accept)", style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              onPressed: () => state.updateOrderStatus(o.id, 'Ready for Pickup'),
                              child: const Text("तैयार है (Ready)", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ---------------- EEVAAN VENTURES ADMIN DASHBOARD ----------------
class EevaanAdminDashboard extends StatelessWidget {
  const EevaanAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    int totalGross = 0;
    for (var o in state.liveOrders) {
      totalGross += o.totalAmount;
    }
    int commissionEarned = (totalGross * 0.10).round(); // 10% Platform fee

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        title: const Text("Eevaan Ventures Super Admin"),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: "Switch Role",
            onPressed: () => state.setRole('Customer'),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricCard("कुल ऑर्डर्स", "${state.liveOrders.length}", Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard("कुल ग्रॉस सेल", "₹$totalGross", Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildMetricCard("Cravio शुद्ध कमीशन (10%)", "₹$commissionEarned", Colors.green),
          const SizedBox(height: 24),
          const Text("लाइव ऑर्डर मॉनिटर (Live Order Dispatch)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          ...state.liveOrders.map((o) {
            return ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              title: Text("${o.restaurantName} ➔ ${o.customerName}"),
              subtitle: Text("ID: ${o.id} | Status: ${o.status}"),
              trailing: PopupMenuButton<String>(
                onSelected: (st) => state.updateOrderStatus(o.id, st),
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: "Accepted", child: Text("Mark Accepted")),
                  const PopupMenuItem(value: "Out for Delivery", child: Text("Out for Delivery")),
                  const PopupMenuItem(value: "Delivered", child: Text("Mark Delivered")),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String val, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(val, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ---------------- PROFILE & SETTINGS SCREEN ----------------
class ProfileAndSettingsScreen extends StatelessWidget {
  const ProfileAndSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(state.isHindi ? "प्रोफ़ाइल एवं सेटिंग्स" : "Profile & Settings"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Card
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: const Color(0xFFFF5722),
                child: Text(
                  state.userName[0],
                  style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.userName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(state.userPhone, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "Cravio Club Member",
                      style: TextStyle(color: Colors.orange.shade900, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
          const Divider(height: 36),

          // Role Switcher Section (Test all 3 roles from mobile!)
          Text(
            state.isHindi ? "सिस्टम मोड बदलें (Role Switcher)" : "Switch Role (Testing Mode)",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                _buildRoleButton("Customer", state.isHindi ? "ग्राहक" : "Customer", state),
                _buildRoleButton("Restaurant", state.isHindi ? "रेस्टोरेंट" : "Restaurant", state),
                _buildRoleButton("Admin", state.isHindi ? "एडमिन" : "Admin", state),
              ],
            ),
          ),

          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.language, color: Color(0xFFFF5722)),
            title: Text(state.isHindi ? "भाषा (Language)" : "Language (भाषा)"),
            trailing: Text(state.isHindi ? "हिंदी ➔" : "English ➔", style: const TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => state.toggleLanguage(),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Color(0xFFFF5722)),
            title: Text(state.isHindi ? "मेरा पता (Address)" : "My Address"),
            subtitle: Text(state.userAddress),
            trailing: const Icon(Icons.edit, size: 18),
            onTap: () {
              // Edit address popup can be placed here
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent, color: Color(0xFFFF5722)),
            title: Text(state.isHindi ? "सहायता केंद्र (Support)" : "Support Center"),
            subtitle: const Text("Presented by Eevaan Ventures"),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton(String role, String label, AppState state) {
    final isSelected = state.currentRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => state.setRole(role),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF5722) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
