import 'package:flutter/material.dart';

void main() {
  runApp(const CravioApp());
}

// ---------------- APP STATE & STORE ----------------
class AppState extends ChangeNotifier {
  static final AppState instance = AppState();

  bool isHindi = true;
  String currentRole = 'Customer'; // 'Customer', 'Restaurant', 'Admin'
  String selectedRestaurant = "Hotel Marwari";
  String merchantUpiId = "9826012345@upi";

  // Customer Profile
  String userName = "राहुल शर्मा";
  String userPhone = "9826012345";
  String userArea = "नेहरू चौक";
  String userHouse = "मकान नं. 42, गली नं. 2";
  String userLandmark = "पुरानी गल्ला मंडी के पास, गंजबासौदा";
  String get fullAddress => "$userHouse, $userArea ($userLandmark)";

  // Live Restaurants & Menus (Dynamic Store)
  List<Map<String, dynamic>> restaurants = [
    {
      "name": "Hotel Marwari",
      "hindiName": "होटल मारवाड़ी",
      "image": "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&q=80",
      "area": "नेहरू चौक, गंजबासौदा",
      "tag": "शुद्ध शाकाहारी थाली, दाल बाटी व मिठाई",
      "rating": "4.8",
      "time": "20-25 min",
      "offer": "FLAT ₹30 OFF",
      "upiId": "marwari.basoda@upi",
      "menu": [
        {"id": "m1", "name": "मारवाड़ी स्पेशल थाली", "price": 180, "isAvailable": true, "desc": "दाल, शाही पनीर, सूखी सब्जी, 4 रोटी, चावल, रायता, मीठा"},
        {"id": "m2", "name": "दाल बाटी चूरमा थाली", "price": 150, "isAvailable": true, "desc": "4 देशी घी बाटी, दाल, चूरमा व चटनी"},
        {"id": "m3", "name": "पनीर बटर मसाला", "price": 160, "isAvailable": true, "desc": "रिच बटर ग्रेवी में ताजा पनीर"},
      ]
    },
    {
      "name": "Da Pixza Lover",
      "hindiName": "दा पिज़्ज़ा लवर",
      "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&q=80",
      "area": "स्टेशन रोड, गंजबासौदा",
      "tag": "चीज़ी पिज़्ज़ा, बर्गर, शेक्स और फ्राइज़",
      "rating": "4.7",
      "time": "15-20 min",
      "offer": "20% OFF",
      "upiId": "pixzalover@upi",
      "menu": [
        {"id": "p1", "name": "फार्महाउस चीज़ी पिज़्ज़ा (7 Inch)", "price": 199, "isAvailable": true, "desc": "शिमला मिर्च, प्याज, कॉर्न, डबल चीज़"},
        {"id": "p2", "name": "क्रंची वेज चीज़ बर्गर", "price": 79, "isAvailable": true, "desc": "क्रिस्पी वेज टिक्की व चीज़ स्लाइस"},
      ]
    },
    {
      "name": "The Pride Restaurant",
      "hindiName": "द प्राइड रेस्टोरेंट",
      "image": "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=600&q=80",
      "area": "बरेथ रोड, गंजबासौदा",
      "tag": "नॉर्थ इंडियन, चाइनीज़ व दम बिरयानी",
      "rating": "4.6",
      "time": "25-30 min",
      "offer": "FREE DELIVERY",
      "upiId": "thepride@upi",
      "menu": [
        {"id": "pr1", "name": "पनीर टिक्का मसाला", "price": 210, "isAvailable": true, "desc": "मसालेदार ग्रेवी में रोस्टेड पनीर"},
        {"id": "pr2", "name": "शाही वेज दम बिरयानी", "price": 170, "isAvailable": true, "desc": "बासमती चावल, वेजीस व बूंदी रायता"},
      ]
    },
    {
      "name": "Sweets Ganga",
      "hindiName": "स्वीट्स गंगा",
      "image": "https://images.unsplash.com/photo-1505253758473-96b3015f27eb?w=600&q=80",
      "area": "नेहरू चौक, गंजबासौदा",
      "tag": "समोसा, कचौरी व देशी घी की जलेबी",
      "rating": "4.9",
      "time": "15 min",
      "offer": "TOP SELLER",
      "upiId": "gangasweets@upi",
      "menu": [
        {"id": "s1", "name": "गरमा-गरम समोसा (2 पीस)", "price": 30, "isAvailable": true, "desc": "आलू-मटर मसाला व चटनी"},
        {"id": "s2", "name": "देशी घी की जलेबी (250g)", "price": 80, "isAvailable": true, "desc": "शुद्ध देशी घी में बनी कुरकुरी जलेबी"},
      ]
    }
  ];

  Map<String, int> cart = {};
  String activeRestaurant = "";
  List<Map<String, dynamic>> orders = [];

  void toggleLang(bool hindi) {
    isHindi = hindi;
    notifyListeners();
  }

  void switchRole(String role, {String res = "Hotel Marwari"}) {
    currentRole = role;
    selectedRestaurant = res;
    notifyListeners();
  }

  // Restaurant & Admin Menu Management
  void updateDishPrice(String resName, String dishId, int newPrice) {
    for (var r in restaurants) {
      if (r["name"] == resName) {
        for (var d in (r["menu"] as List)) {
          if (d["id"] == dishId) {
            d["price"] = newPrice;
            notifyListeners();
            return;
          }
        }
      }
    }
  }

  void toggleDishAvailability(String resName, String dishId) {
    for (var r in restaurants) {
      if (r["name"] == resName) {
        for (var d in (r["menu"] as List)) {
          if (d["id"] == dishId) {
            d["isAvailable"] = !(d["isAvailable"] ?? true);
            notifyListeners();
            return;
          }
        }
      }
    }
  }

  void addNewDish(String resName, Map<String, dynamic> dish) {
    for (var r in restaurants) {
      if (r["name"] == resName) {
        (r["menu"] as List).add(dish);
        notifyListeners();
        return;
      }
    }
  }

  void updateProfile({required String name, required String phone, required String area, required String house, required String landmark}) {
    userName = name;
    userPhone = phone;
    userArea = area;
    userHouse = house;
    userLandmark = landmark;
    notifyListeners();
  }

  void addToCart(String item, String res) {
    if (activeRestaurant.isNotEmpty && activeRestaurant != res) cart.clear();
    activeRestaurant = res;
    cart[item] = (cart[item] ?? 0) + 1;
    notifyListeners();
  }

  void removeFromCart(String item) {
    if (cart.containsKey(item)) {
      if (cart[item]! > 1) {
        cart[item] = cart[item]! - 1;
      } else {
        cart.remove(item);
        if (cart.isEmpty) activeRestaurant = "";
      }
      notifyListeners();
    }
  }

  void placeOrder(List<Map<String, dynamic>> items, int total, String payment) {
    orders.insert(0, {
      "id": "CRV-${DateTime.now().millisecondsSinceEpoch % 10000}",
      "customerName": userName,
      "customerPhone": userPhone,
      "address": fullAddress,
      "res": activeRestaurant,
      "items": List.from(items),
      "total": total,
      "payment": payment,
      "status": "ऑर्डर प्राप्त हुआ (Order Received)",
      "prepTime": "तैयारी शुरू हो रही है",
    });
    cart.clear();
    activeRestaurant = "";
    notifyListeners();
  }

  void acceptOrderWithTime(String orderId, int minutes) {
    for (var o in orders) {
      if (o["id"] == orderId) {
        o["status"] = "खाना तैयार हो रहा है (Cooking)";
        o["prepTime"] = "$minutes मिनट में तैयार होगा";
        notifyListeners();
        return;
      }
    }
  }

  void markOrderReady(String orderId) {
    for (var o in orders) {
      if (o["id"] == orderId) {
        o["status"] = "तैयार है (Ready for Pickup)";
        o["prepTime"] = "डिलीवरी के लिए तैयार!";
        notifyListeners();
        return;
      }
    }
  }

  void markOrderDelivered(String orderId) {
    for (var o in orders) {
      if (o["id"] == orderId) {
        o["status"] = "सफलतापूर्वक डिलीवर (Delivered)";
        notifyListeners();
        return;
      }
    }
  }
}

// ---------------- ROOT APP ----------------
class CravioApp extends StatelessWidget {
  const CravioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'Cravio - Ganj Basoda',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF9F8F6),
            primaryColor: const Color(0xFF262220),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF262220),
              primary: const Color(0xFF262220),
              secondary: const Color(0xFFC5A059),
            ),
            fontFamily: 'Roboto',
          ),
          home: const MasterRoleRouter(),
        );
      },
    );
  }
}

class MasterRoleRouter extends StatelessWidget {
  const MasterRoleRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    if (state.currentRole == 'Restaurant') return const RestaurantPartnerScreen();
    if (state.currentRole == 'Admin') return const EevaanAdminScreen();
    return const CustomerPortalView();
  }
}

// ---------------- 1. CUSTOMER PORTAL VIEW ----------------
class CustomerPortalView extends StatefulWidget {
  const CustomerPortalView({super.key});

  @override
  State<CustomerPortalView> createState() => _CustomerPortalViewState();
}

class _CustomerPortalViewState extends State<CustomerPortalView> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    final pages = [
      const CustomerHomeScreen(),
      const CustomerOrdersScreen(),
      const CustomerProfileScreen(),
    ];

    return Scaffold(
      body: pages[_tab],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1))),
        child: BottomNavigationBar(
          currentIndex: _tab,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: const Color(0xFF262220),
          unselectedItemColor: Colors.grey.shade400,
          onTap: (i) => setState(() => _tab = i),
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.storefront_outlined), activeIcon: const Icon(Icons.storefront), label: state.isHindi ? "रेस्टोरेंट" : "Food"),
            BottomNavigationBarItem(icon: const Icon(Icons.receipt_long_outlined), activeIcon: const Icon(Icons.receipt_long), label: state.isHindi ? "मेरे ऑर्डर" : "Orders"),
            BottomNavigationBarItem(icon: const Icon(Icons.person_outline), activeIcon: const Icon(Icons.person), label: state.isHindi ? "मेरी प्रोफ़ाइल" : "Profile"),
          ],
        ),
      ),
    );
  }
}

// ---------------- 2. CUSTOMER HOME SCREEN ----------------
class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      key: ValueKey("CustomerHome_${state.isHindi}"),
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF262220),
        elevation: 0,
        toolbarHeight: 92,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.4)),
                  ),
                  child: const Text(
                    "C R A V I O",
                    style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 3),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.verified, color: Color(0xFFC5A059), size: 16),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              "POWERED BY EEVAAN VENTURES",
              style: TextStyle(color: Colors.white60, fontSize: 9, letterSpacing: 1.5, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_account_outlined, color: Color(0xFFC5A059)),
            tooltip: "पोर्टल बदलें (Customer / Restaurant / Admin)",
            onPressed: () => _openRoleSwitcher(context),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  _langPill("हि", state.isHindi, () => setState(() => state.toggleLang(true))),
                  _langPill("EN", !state.isHindi, () => setState(() => state.toggleLang(false))),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Quick Switch Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFC5A059).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.person_pin, size: 16, color: Color(0xFF262220)),
                    SizedBox(width: 6),
                    Text("मोड: ग्राहक पोर्टल (Customer Mode)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF262220))),
                  ],
                ),
                InkWell(
                  onTap: () => _openRoleSwitcher(context),
                  child: const Text("पोर्टल बदलें ➔", style: TextStyle(color: Color(0xFF262220), fontWeight: FontWeight.bold, fontSize: 12)),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Address Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 20, color: Color(0xFFC5A059)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.isHindi ? "डिलीवरी का पता (प्रोफ़ाइल से बदलें):" : "Delivering To:", style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                      Text(state.fullAddress, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF262220)), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Badges
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.3))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _badge(Icons.star, "4.8 ★ रेटिंग्स", "1,450+ ऑर्डर्स"),
                Container(height: 24, width: 1, color: Colors.grey.shade200),
                _badge(Icons.qr_code_2, "UPI बारकोड", "PhonePe व GPay"),
                Container(height: 24, width: 1, color: Colors.grey.shade200),
                _badge(Icons.timer, "लाइव टाइमिंग", "30 मिनट में खाना"),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Banner
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF262220), Color(0xFF383330)]), borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFC5A059), borderRadius: BorderRadius.circular(4)), child: const Text("COUNTER RATES ASSURED", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 8),
                      Text(state.isHindi ? "गंजबासौदा के प्रसिद्ध रेस्टोरेंट्स\nसीधा काउंटर रेट पर घर बैठे!" : "Ganj Basoda's Best Dining\nDirect Counter Menu Rates!", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.3)),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200&q=80",
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(width: 75, height: 75, color: const Color(0xFFC5A059), child: const Icon(Icons.restaurant, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          Text(state.isHindi ? "गंजबासौदा के प्रमुख रेस्टोरेंट्स" : "Popular Restaurants in Ganj Basoda", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
          const SizedBox(height: 14),

          // Restaurants
          ...state.restaurants.map((res) {
            return Card(
              margin: const EdgeInsets.only(bottom: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
              clipBehavior: Clip.antiAlias,
              elevation: 1.5,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerMenuDetailScreen(restaurant: res)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          res["image"],
                          height: 155,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(height: 155, color: Colors.grey.shade200, child: const Center(child: Icon(Icons.fastfood, size: 50, color: Color(0xFFC5A059)))),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFF262220), borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFC5A059))),
                            child: Text(res["offer"] ?? "", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_outlined, size: 12, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(res["time"] ?? "", style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.isHindi ? (res["hindiName"] ?? res["name"]) : res["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(color: const Color(0xFF262220), borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFC5A059))),
                                child: Text("★ ${res["rating"]}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(res["area"] ?? "", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          Text(res["tag"] ?? "", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.w600)),
                          const Divider(height: 22),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerMenuDetailScreen(restaurant: res)));
                              },
                              child: Text(state.isHindi ? "मेन्यू देखें और खाना चुनें ➔" : "View Menu & Order ➔", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _badge(IconData icon, String title, String sub) {
    return Column(
      children: [
        Icon(icon, size: 16, color: const Color(0xFFC5A059)),
        const SizedBox(height: 2),
        Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
        Text(sub, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }

  Widget _langPill(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: active ? const Color(0xFFC5A059) : Colors.transparent, borderRadius: BorderRadius.circular(16)),
        child: Text(text, style: TextStyle(color: active ? Colors.white : Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  void _openRoleSwitcher(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("पोर्टल बदलें (Select Role):", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
              const Divider(height: 20),
              ListTile(
                leading: const Icon(Icons.person, color: Color(0xFFC5A059), size: 28),
                title: const Text("👤 ग्राहक पोर्टल (Customer Mode)", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("खाना ऑर्डर करने के लिए"),
                onTap: () {
                  AppState.instance.switchRole("Customer");
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.storefront, color: Color(0xFFC5A059), size: 28),
                title: const Text("🏪 रेस्टोरेंट पार्टनर (Restaurant Mode)", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("होटल मारवाड़ी: ऑर्डर एक्सेप्ट करें, टाइमिंग दें, रेट बदलें"),
                onTap: () {
                  AppState.instance.switchRole("Restaurant", res: "Hotel Marwari");
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings, color: Color(0xFFC5A059), size: 28),
                title: const Text("🛡️ ईवान वेंचर्स एडमिन (Super Admin)", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("कमीशन, कुल बिक्री और पूरे बिज़नेस का हिसाब"),
                onTap: () {
                  AppState.instance.switchRole("Admin");
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------- 3. CUSTOMER MENU & PAYMENT (DYNAMIC UPI QR) ----------------
class CustomerMenuDetailScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  const CustomerMenuDetailScreen({super.key, required this.restaurant});

  @override
  State<CustomerMenuDetailScreen> createState() => _CustomerMenuDetailScreenState();
}

class _CustomerMenuDetailScreenState extends State<CustomerMenuDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        final res = widget.restaurant;
        final List menuList = res["menu"];
        final String rName = res["name"];

        int totalAmount = 0;
        int totalCount = 0;
        List<Map<String, dynamic>> selectedList = [];

        state.cart.forEach((itemName, qty) {
          for (var item in menuList) {
            if (item["name"] == itemName || item["en"] == itemName) {
              int price = (item["price"] as num).toInt();
              totalAmount += price * qty;
              totalCount += qty;
              selectedList.add({"title": item["name"], "price": price, "qty": qty});
            }
          }
        });

        return Scaffold(
          backgroundColor: const Color(0xFFF9F8F6),
          appBar: AppBar(
            backgroundColor: const Color(0xFF262220),
            foregroundColor: Colors.white,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.isHindi ? (res["hindiName"] ?? res["name"]) : res["name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(res["area"] ?? "", style: const TextStyle(fontSize: 11, color: Colors.white70)),
              ],
            ),
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: menuList.length,
            separatorBuilder: (_, __) => const Divider(height: 24),
            itemBuilder: (context, idx) {
              final item = menuList[idx];
              final String itemKey = item["name"];
              final int qty = state.cart[itemKey] ?? 0;
              final int itemPrice = (item["price"] as num).toInt();
              final bool isAvail = item["isAvailable"] ?? true;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 1.5)), child: const Icon(Icons.circle, color: Colors.green, size: 8)),
                            const SizedBox(width: 8),
                            Expanded(child: Text(item["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF262220)))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text("₹$itemPrice", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFC5A059))),
                        const SizedBox(height: 4),
                        Text(item["desc"] ?? "", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                        if (!isAvail)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text("⚠ आज समाप्त है (Out of Stock)", style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF262220))),
                    child: !isAvail
                        ? const Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), child: Text("समाप्त", style: TextStyle(color: Colors.grey, fontSize: 11)))
                        : qty == 0
                            ? InkWell(
                                onTap: () => state.addToCart(itemKey, rName),
                                child: const Padding(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6), child: Text("+ ADD", style: TextStyle(color: Color(0xFF262220), fontWeight: FontWeight.bold, fontSize: 12))),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.all(4), icon: const Icon(Icons.remove, size: 14, color: Color(0xFF262220)), onPressed: () => state.removeFromCart(itemKey)),
                                  Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.all(4), icon: const Icon(Icons.add, size: 14, color: Color(0xFF262220)), onPressed: () => state.addToCart(itemKey, rName)),
                                ],
                              ),
                  )
                ],
              );
            },
          ),
          bottomNavigationBar: totalCount > 0
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -3))]),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () => _openDynamicPaymentSheet(context, selectedList, totalAmount, res["upiId"] ?? state.merchantUpiId),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 10), child: Text("$totalCount सामान | ₹$totalAmount", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
                        Padding(padding: const EdgeInsets.only(right: 10), child: const Text("पेमेंट व बारकोड ➔", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
                      ],
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  void _openDynamicPaymentSheet(BuildContext context, List<Map<String, dynamic>> items, int subtotal, String targetUpi) {
    final state = AppState.instance;
    const delivery = 20;
    final grandTotal = subtotal + delivery;
    String selectedPayment = "DynamicQR";
    final qrApiUrl = "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=upi://pay?pa=$targetUpi&pn=Cravio%20Basoda&am=$grandTotal&cu=INR";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("अंतिम बिल व पेमेंट (Dynamic UPI QR)", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                    const Divider(height: 18),
                    ...items.map((i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("${i['title']} x ${i['qty']}"), Text("₹${i['price'] * i['qty']}", style: const TextStyle(fontWeight: FontWeight.bold))]),
                        )),
                    const Divider(height: 16),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("लोकल डिलीवरी चार्ज"), Text("₹20")]),
                    const SizedBox(height: 6),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("कुल देय राशि", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), Text("₹$grandTotal", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Color(0xFFC5A059)))]),
                    const Divider(height: 20),

                    if (selectedPayment == "DynamicQR") ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFC5A059))),
                        child: Column(
                          children: [
                            const Text("PhonePe / GPay / Paytm से स्कैन करें:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF262220))),
                            const SizedBox(height: 8),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(qrApiUrl, height: 160, width: 160, fit: BoxFit.contain),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text("UPI ID: $targetUpi | राशि: ₹$grandTotal", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    Text("पेमेंट का विकल्प चुनें:", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                    const SizedBox(height: 8),

                    _payTile("डायनेमिक UPI बारकोड (Scan & Pay)", "स्कैन करके तुरंत ऑनलाइन पे करें", Icons.qr_code, const Color(0xFFC5A059), selectedPayment == "DynamicQR", () => setSheetState(() => selectedPayment = "DynamicQR")),
                    _payTile("PhonePe (फ़ोनपे ऐप)", "सीधे फ़ोनपे से भुगतान", Icons.account_balance_wallet, const Color(0xFF5F259F), selectedPayment == "PhonePe", () => setSheetState(() => selectedPayment = "PhonePe")),
                    _payTile("Cash on Delivery (नकद)", "घर पर डिलीवरी मिलने पर नकद दें", Icons.money, Colors.green.shade800, selectedPayment == "Cash on Delivery", () => setSheetState(() => selectedPayment = "Cash on Delivery")),

                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          state.placeOrder(items, grandTotal, selectedPayment);
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("🎉 बधाई! आपका ऑर्डर होटल को भेज दिया गया है।"), backgroundColor: Color(0xFF262220)),
                          );
                        },
                        child: Text("ऑर्डर कन्फर्म करें (₹$grandTotal - $selectedPayment)", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _payTile(String title, String sub, IconData icon, Color color, bool sel, VoidCallback tap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(color: sel ? color.withOpacity(0.08) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: sel ? color : Colors.grey.shade200, width: sel ? 1.5 : 1)),
      child: ListTile(
        dense: true,
        onTap: tap,
        leading: Icon(icon, color: color, size: 22),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: sel ? color : Colors.black87)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        trailing: Icon(sel ? Icons.radio_button_checked : Icons.radio_button_off, color: sel ? color : Colors.grey, size: 18),
      ),
    );
  }
}

// ---------------- 4. CUSTOMER ORDERS SCREEN ----------------
class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;

        return Scaffold(
          backgroundColor: const Color(0xFFF9F8F6),
          appBar: AppBar(title: const Text("मेरे ऑर्डर (Live Tracking)"), backgroundColor: const Color(0xFF262220), foregroundColor: Colors.white, elevation: 0),
          body: state.orders.isEmpty
              ? const Center(child: Text("अभी कोई सक्रिय ऑर्डर नहीं है।"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.orders.length,
                  itemBuilder: (context, idx) {
                    final o = state.orders[idx];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(o["id"], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: Text(o["status"], style: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.bold, fontSize: 11))),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(o["res"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: const Color(0xFFC5A059).withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  const Icon(Icons.timer, size: 16, color: Color(0xFF262220)),
                                  const SizedBox(width: 6),
                                  Text("रेस्टोरेंट टाइमिंग: ${o["prepTime"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF262220))),
                                ],
                              ),
                            ),
                            Text("पेमेंट: ${o['payment']}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            const Divider(height: 16),
                            ...((o["items"] as List).map((i) => Text("• ${i['title']} x ${i['qty']}", style: const TextStyle(fontSize: 13)))),
                            const Divider(height: 16),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("कुल राशि:"), Text("₹${o['total']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFC5A059)))]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

// ---------------- 5. CUSTOMER PROFILE SCREEN ----------------
class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;

        return Scaffold(
          backgroundColor: const Color(0xFFF9F8F6),
          appBar: AppBar(title: const Text("मेरी प्रोफ़ाइल"), backgroundColor: const Color(0xFF262220), foregroundColor: Colors.white, elevation: 0),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 28, backgroundColor: Color(0xFF262220), child: Icon(Icons.person, color: Color(0xFFC5A059), size: 30)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.userName, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                          Text("+91 ${state.userPhone}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
                      onPressed: () => _editProfileModal(context),
                      child: const Text("बदलें", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("डिलीवरी का पूरा पता:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF262220))),
                        IconButton(icon: const Icon(Icons.edit, size: 18, color: Color(0xFFC5A059)), onPressed: () => _editProfileModal(context)),
                      ],
                    ),
                    const Divider(),
                    Text("📍 मोहल्ला: ${state.userArea}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text("🏠 मकान / दुकान: ${state.userHouse}", style: const TextStyle(fontSize: 13)),
                    const SizedBox(height: 4),
                    Text("🚩 लैंडमार्क: ${state.userLandmark}", style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                leading: const Icon(Icons.storefront, color: Color(0xFF262220)),
                title: const Text("रेस्टोरेंट टर्मिनल में जाएं"),
                subtitle: const Text("होटल मारवाड़ी - ऑर्डर स्वीकार करें व मेन्यू बदलें"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => state.switchRole("Restaurant", res: "Hotel Marwari"),
              ),
            ],
          ),
        );
      },
    );
  }

  static void _editProfileModal(BuildContext context) {
    final state = AppState.instance;
    final nameCtrl = TextEditingController(text: state.userName);
    final phoneCtrl = TextEditingController(text: state.userPhone);
    final areaCtrl = TextEditingController(text: state.userArea);
    final houseCtrl = TextEditingController(text: state.userHouse);
    final landmarkCtrl = TextEditingController(text: state.userLandmark);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("कस्टमर प्रोफ़ाइल व पता अपडेट करें", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                const Divider(),
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "कस्टमर का नाम (Full Name)")),
                TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "मोबाइल नंबर")),
                TextField(controller: areaCtrl, decoration: const InputDecoration(labelText: "मोहल्ला / एरिया")),
                TextField(controller: houseCtrl, decoration: const InputDecoration(labelText: "मकान नंबर")),
                TextField(controller: landmarkCtrl, decoration: const InputDecoration(labelText: "लैंडमार्क")),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () {
                      state.updateProfile(name: nameCtrl.text, phone: phoneCtrl.text, area: areaCtrl.text, house: houseCtrl.text, landmark: landmarkCtrl.text);
                      Navigator.pop(ctx);
                    },
                    child: const Text("प्रोफ़ाइल सेव करें", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------- 6. RESTAURANT PARTNER TERMINAL ----------------
class RestaurantPartnerScreen extends StatefulWidget {
  const RestaurantPartnerScreen({super.key});

  @override
  State<RestaurantPartnerScreen> createState() => _RestaurantPartnerScreenState();
}

class _RestaurantPartnerScreenState extends State<RestaurantPartnerScreen> {
  int _selectedMinutes = 30;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        final resName = state.selectedRestaurant;
        final resObj = state.restaurants.firstWhere((r) => r["name"] == resName, orElse: () => state.restaurants.first);
        final resOrders = state.orders.where((o) => o["res"] == resName).toList();
        final menuList = resObj["menu"] as List;

        return Scaffold(
          backgroundColor: const Color(0xFFF9F8F6),
          appBar: AppBar(
            backgroundColor: const Color(0xFF262220),
            foregroundColor: Colors.white,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$resName - टर्मिनल", style: const TextStyle(fontSize: 16)),
                Text("UPI: ${resObj["upiId"] ?? state.merchantUpiId}", style: const TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => state.switchRole("Customer"),
                child: const Text("ग्राहक बनें", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              )
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Standee Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code_scanner, size: 40, color: Color(0xFFC5A059)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$resName काउंटर QR स्टैंडी", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const Text("दुकान के काउंटर पर लगाने के लिए डिजिटल स्टैंडी देखें", style: TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220)),
                        onPressed: () => _showCounterStandee(context, resName, resObj["upiId"] ?? state.merchantUpiId),
                        child: const Text("देखें", style: TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text("आए हुए ऑर्डर्स (${resOrders.length}):", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
              const SizedBox(height: 10),
              if (resOrders.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Text("अभी कोई नया ऑर्डर नहीं है।")),
                )
              else
                ...resOrders.map((o) {
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
                              Text("ऑर्डर ID: ${o["id"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(o["status"], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(),
                          Text("ग्राहक: ${o["customerName"]} (${o["customerPhone"]})"),
                          Text("डिलीवरी पता: ${o["address"]}"),
                          Text("पेमेंट: ${o["payment"]} | कुल: ₹${o["total"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          ...((o["items"] as List).map((i) => Text("• ${i['title']} x ${i['qty']}", style: const TextStyle(fontWeight: FontWeight.bold)))),
                          const Divider(),
                          Row(
                            children: [
                              const Text("तैयारी का समय:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              DropdownButton<int>(
                                value: _selectedMinutes,
                                items: const [
                                  DropdownMenuItem(value: 15, child: Text("15 मिनट")),
                                  DropdownMenuItem(value: 20, child: Text("20 मिनट")),
                                  DropdownMenuItem(value: 30, child: Text("30 मिनट")),
                                  DropdownMenuItem(value: 45, child: Text("45 मिनट")),
                                ],
                                onChanged: (v) => setState(() => _selectedMinutes = v!),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                                  onPressed: () => state.acceptOrderWithTime(o["id"], _selectedMinutes),
                                  child: Text("स्वीकारें ($_selectedMinutes मिनट)", style: const TextStyle(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                                  onPressed: () => state.markOrderReady(o["id"]),
                                  child: const Text("तैयार है (Ready)", style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),

              const SizedBox(height: 20),

              // Menu & Price Manager
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("मेन्यू व रेट प्रबंधन ($resName):", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
                    icon: const Icon(Icons.add, size: 16, color: Colors.white),
                    label: const Text("नई डिश", style: TextStyle(color: Colors.white, fontSize: 11)),
                    onPressed: () => _showAddDishModal(context, resName),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              ...menuList.map((dish) {
                final bool isAvail = dish["isAvailable"] ?? true;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(Icons.restaurant, color: isAvail ? Colors.green : Colors.grey),
                    title: Text(dish["name"], style: TextStyle(fontWeight: FontWeight.bold, decoration: isAvail ? null : TextDecoration.lineThrough)),
                    subtitle: Text("रेट: ₹${dish["price"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFFC5A059), size: 20),
                          tooltip: "रेट बदलें",
                          onPressed: () => _showEditPriceModal(context, resName, dish["id"], dish["name"], dish["price"]),
                        ),
                        Switch(
                          value: isAvail,
                          activeColor: Colors.green,
                          onChanged: (_) => state.toggleDishAvailability(resName, dish["id"]),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showCounterStandee(BuildContext context, String resName, String upiId) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFF262220), borderRadius: BorderRadius.circular(8)),
                child: const Text("C R A V I O", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
              ),
              const SizedBox(height: 8),
              Text(resName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF262220))),
              const Text("काउंटर ऑर्डर स्टैंडी", style: TextStyle(fontSize: 11, color: Colors.grey)),
              const Divider(height: 20),
              Image.network("https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=upi://pay?pa=$upiId&pn=$resName", height: 160, width: 160),
              const SizedBox(height: 8),
              Text("UPI: $upiId", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text("घर बैठे यही खाना काउंटर रेट पर मंगाने के लिए Cravio ऐप डाउनलोड करें!", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("बंद करें"))],
        );
      },
    );
  }

  void _showEditPriceModal(BuildContext context, String resName, String dishId, String dishName, int currentPrice) {
    final priceCtrl = TextEditingController(text: "$currentPrice");
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("$dishName का रेट बदलें"),
          content: TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "नया रेट (₹)")),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("रद्द करें")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220)),
              onPressed: () {
                final np = int.tryParse(priceCtrl.text) ?? currentPrice;
                AppState.instance.updateDishPrice(resName, dishId, np);
                Navigator.pop(ctx);
              },
              child: const Text("रेट सेव करें", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showAddDishModal(BuildContext context, String resName) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("नई डिश जोड़ें"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "डिश का नाम")),
                TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "रेट (₹)")),
                TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "विवरण")),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("रद्द करें")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220)),
              onPressed: () {
                if (nameCtrl.text.isNotEmpty && priceCtrl.text.isNotEmpty) {
                  AppState.instance.addNewDish(resName, {
                    "id": "new_${DateTime.now().millisecondsSinceEpoch}",
                    "name": nameCtrl.text,
                    "price": int.tryParse(priceCtrl.text) ?? 100,
                    "isAvailable": true,
                    "desc": descCtrl.text,
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text("जोड़ें", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

// ---------------- 7. EEVAAN VENTURES ADMIN SCREEN ----------------
class EevaanAdminScreen extends StatelessWidget {
  const EevaanAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        int totalSales = 0;
        for (var o in state.orders) {
          totalSales += (o["total"] as num).toInt();
        }
        int commission = (totalSales * 0.10).round();

        return Scaffold(
          backgroundColor: const Color(0xFFF9F8F6),
          appBar: AppBar(
            backgroundColor: const Color(0xFF262220),
            foregroundColor: Colors.white,
            title: const Text("ईवान वेंचर्स - सुपर एडमिन"),
            actions: [
              TextButton(
                onPressed: () => state.switchRole("Customer"),
                child: const Text("ग्राहक बनें", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              )
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(child: _metric("कुल ऑर्डर्स", "${state.orders.length}", Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _metric("कुल बिक्री", "₹$totalSales", const Color(0xFFC5A059))),
                ],
              ),
              const SizedBox(height: 12),
              _metric("ईवान वेंचर्स शुद्ध कमीशन (10%)", "₹$commission", Colors.green.shade800),
              const SizedBox(height: 24),
              const Text("गंजबासौदा लाइव ऑर्डर मॉनिटर:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
              const SizedBox(height: 10),
              if (state.orders.isEmpty) const Text("अभी कोई सक्रिय ऑर्डर नहीं है।"),
              ...state.orders.map((o) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text("${o["res"]} ➔ ${o["customerName"]} (₹${o["total"]})"),
                    subtitle: Text("ID: ${o["id"]} | ${o["payment"]} | ${o["status"]}"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (st) => state.markOrderDelivered(o["id"]),
                      itemBuilder: (ctx) => const [PopupMenuItem(value: "Delivered", child: Text("डिलीवर मार्क करें"))],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _metric(String title, String val, Color col) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: col.withOpacity(0.4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: col, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(val, style: TextStyle(color: col, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
