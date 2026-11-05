import 'package:flutter/material.dart';

void main() {
  runApp(const CravioApp());
}

// ---------------- APP STATE MANAGEMENT ----------------
class ActiveOrder {
  final String id;
  final String customerName;
  final String customerPhone;
  final String address;
  final String landmark;
  final String restaurantName;
  final List<Map<String, dynamic>> items;
  final int totalAmount;
  String status;

  ActiveOrder({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.landmark,
    required this.restaurantName,
    required this.items,
    required this.totalAmount,
    required this.status,
  });
}

class AppState extends ChangeNotifier {
  static final AppState instance = AppState();

  bool isHindi = true;
  String currentRole = 'Customer'; // 'Customer', 'Restaurant', 'Admin'

  // User Profile & Address
  String userName = "राहुल शर्मा";
  String userPhone = "9826012345";
  String userArea = "नेहरू चौक";
  String userHouseNo = "मकान नं. 42, गली नं. 2";
  String userLandmark = "पुरानी गल्ला मंडी के पास, गंजबासौदा";

  String get fullAddress => "$userHouseNo, $userArea ($userLandmark)";

  // Cart & Orders
  Map<String, int> cart = {};
  String activeRestaurant = "";
  List<ActiveOrder> orders = [];

  void setLanguage(bool hindi) {
    if (isHindi != hindi) {
      isHindi = hindi;
      notifyListeners();
    }
  }

  void setRole(String role) {
    currentRole = role;
    notifyListeners();
  }

  void updateAddress({
    required String name,
    required String phone,
    required String area,
    required String houseNo,
    required String landmark,
  }) {
    userName = name;
    userPhone = phone;
    userArea = area;
    userHouseNo = houseNo;
    userLandmark = landmark;
    notifyListeners();
  }

  void addToCart(String itemName, String resName) {
    if (activeRestaurant.isNotEmpty && activeRestaurant != resName) {
      cart.clear();
    }
    activeRestaurant = resName;
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

  void clearCart() {
    cart.clear();
    activeRestaurant = "";
    notifyListeners();
  }

  void placeOrder(List<Map<String, dynamic>> orderItems, int total) {
    final newOrder = ActiveOrder(
      id: "CRV-${DateTime.now().millisecondsSinceEpoch % 10000}",
      customerName: userName,
      customerPhone: userPhone,
      address: "$userHouseNo, $userArea",
      landmark: userLandmark,
      restaurantName: activeRestaurant,
      items: List.from(orderItems),
      totalAmount: total,
      status: isHindi ? "ऑर्डर दर्ज हुआ (Order Placed)" : "Order Placed",
    );
    orders.insert(0, newOrder);
    clearCart();
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final idx = orders.indexWhere((o) => o.id == orderId);
    if (idx != -1) {
      orders[idx].status = newStatus;
      notifyListeners();
    }
  }
}

// ---------------- APP ROOT ----------------
class CravioApp extends StatelessWidget {
  const CravioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'Cravio - Presented by Eevaan Ventures',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xFFFF5722),
            scaffoldBackgroundColor: const Color(0xFFFBFBFC),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFFF5722),
              primary: const Color(0xFFFF5722),
            ),
            fontFamily: 'Roboto',
          ),
          home: const MainTabNavigator(),
        );
      },
    );
  }
}

class MainTabNavigator extends StatefulWidget {
  const MainTabNavigator({super.key});

  @override
  State<MainTabNavigator> createState() => _MainTabNavigatorState();
}

class _MainTabNavigatorState extends State<MainTabNavigator> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    if (state.currentRole == 'Restaurant') {
      return const RestaurantPartnerScreen();
    }
    if (state.currentRole == 'Admin') {
      return const AdminDashboardScreen();
    }

    final pages = [
      const HomeFeedScreen(),
      const CustomerOrdersScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_tabIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -3))],
        ),
        child: BottomNavigationBar(
          currentIndex: _tabIndex,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: const Color(0xFFFF5722),
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          onTap: (i) => setState(() => _tabIndex = i),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.lunch_dining_outlined),
              activeIcon: const Icon(Icons.lunch_dining),
              label: state.isHindi ? "रेस्टोरेंट" : "Food",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long_outlined),
              activeIcon: const Icon(Icons.receipt_long),
              label: state.isHindi ? "मेरे ऑर्डर" : "Orders",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: state.isHindi ? "प्रोफ़ाइल" : "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- GANJ BASODA RESTAURANTS WITH PHOTOS ----------------
final List<Map<String, dynamic>> basodaRestaurants = [
  {
    "id": "1",
    "name": "Hotel Marwari",
    "hindiName": "होटल मारवाड़ी",
    "image": "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&q=80",
    "area": "नेहरू चौक, गंजबासौदा",
    "tag": "शुद्ध शाकाहारी थाली, दाल बाटी व मिठाई",
    "enTag": "Pure Veg Thali, Dal Baati & Sweets",
    "rating": "4.6",
    "time": "20-25 min",
    "discount": "FLAT ₹30 OFF",
    "menu": [
      {
        "name": "मारवाड़ी स्पेशल थाली",
        "en": "Marwari Special Thali",
        "price": 180,
        "image": "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400&q=80",
        "desc": "दाल तड़का, शाही पनीर, सूखी सब्जी, 4 बटर रोटी, चावल, रायता व गुलाब जामुन",
        "enDesc": "Dal Tadka, Shahi Paneer, Sabji, 4 Butter Roti, Rice, Raita & Sweet",
      },
      {
        "name": "दाल बाटी चूरमा स्पेशल थाली",
        "en": "Dal Baati Churma Thali",
        "price": 150,
        "image": "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=400&q=80",
        "desc": "4 देशी घी बाटी, स्वादिष्ट दाल, स्पेशल चूरमा और चटनी",
        "enDesc": "4 Desi Ghee Baati with Dal, Sweet Churma & Chutney",
      },
      {
        "name": "पनीर बटर मसाला",
        "en": "Paneer Butter Masala",
        "price": 160,
        "image": "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400&q=80",
        "desc": "ताजा मलाईदार पनीर रिच टमॅटो बटर ग्रेवी में",
        "enDesc": "Rich cottage cheese in creamy tomato butter gravy",
      },
      {
        "name": "तंदूरी बटर रोटी",
        "en": "Tandoori Butter Roti",
        "price": 15,
        "image": "https://images.unsplash.com/photo-1626074353765-517a681e40be?w=400&q=80",
        "desc": "तंदूर की कुरकुरी गरमा-गरम मक्खन रोटी",
        "enDesc": "Crisp tandoori bread with melted butter",
      },
      {
        "name": "गुलाब जामुन (2 पीस)",
        "en": "Gulab Jamun (2 Pcs)",
        "price": 40,
        "image": "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400&q=80",
        "desc": "देशी घी में निर्मित रसीले गुलाब जामुन",
        "enDesc": "Warm delicious sweet khoya dumplings",
      },
    ]
  },
  {
    "id": "2",
    "name": "Da Pixza Lover",
    "hindiName": "दा पिज़्ज़ा लवर",
    "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&q=80",
    "area": "स्टेशन रोड, गंजबासौदा",
    "tag": "चीज़ी पिज़्ज़ा, बर्गर, शेक्स और फ्राइज़",
    "enTag": "Loaded Pizzas, Burgers & Shakes",
    "rating": "4.5",
    "time": "15-20 min",
    "discount": "20% OFF",
    "menu": [
      {
        "name": "फार्महाउस चीज़ी पिज़्ज़ा (7 Inch)",
        "en": "Farmhouse Cheesy Pizza",
        "price": 199,
        "image": "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80",
        "desc": "शिमला मिर्च, प्याज, स्वीट कॉर्न और डबल मोज़ेरेला चीज़",
        "enDesc": "Capsicum, Onion, Sweet Corn & Double Mozzarella",
      },
      {
        "name": "क्रंची वेज चीज़ बर्गर",
        "en": "Crunchy Veg Cheese Burger",
        "price": 79,
        "image": "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80",
        "desc": "क्रिस्पी वेज टिक्की, चीज़ स्लाइस व प्रीमियम सॉस",
        "enDesc": "Crispy veg patty, cheese slice & tasty sauce",
      },
      {
        "name": "पेरी पेरी फ्रेंच फ्राइज़",
        "en": "Peri Peri French Fries",
        "price": 89,
        "image": "https://images.unsplash.com/photo-1576107232684-1279f3908594?w=400&q=80",
        "desc": "कुरकुरे आलू फ्राइज़ चटपटे पेरी-पेरी मसाले के साथ",
        "enDesc": "Crispy fries tossed in spicy peri peri seasonings",
      },
      {
        "name": "थिक चॉकलेट कोल्ड कॉफ़ी",
        "en": "Chocolate Cold Coffee",
        "price": 80,
        "image": "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=400&q=80",
        "desc": "आइसक्रीम और चॉकलेट सिरप से भरपूर गाढ़ी कॉफ़ी",
        "enDesc": "Creamy blended cold coffee with chocolate fudge",
      },
    ]
  },
  {
    "id": "3",
    "name": "The Pride Restaurant",
    "hindiName": "द प्राइड रेस्टोरेंट",
    "image": "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=600&q=80",
    "area": "बरेथ रोड, गंजबासौदा",
    "tag": "नॉर्थ इंडियन, चाइनीज़ व दम बिरयानी",
    "enTag": "North Indian, Chinese & Biryani",
    "rating": "4.4",
    "time": "25-30 min",
    "discount": "FREE DELIVERY",
    "menu": [
      {
        "name": "पनीर टिक्का मसाला",
        "en": "Paneer Tikka Masala",
        "price": 210,
        "image": "https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=400&q=80",
        "desc": "तंदूर रोस्टेड पनीर क्यूब्स तीखी गाढ़ी ग्रेवी में",
        "enDesc": "Charcoal grilled paneer in rich spiced gravy",
      },
      {
        "name": "शाही वेज दम बिरयानी",
        "en": "Shahi Veg Dum Biryani",
        "price": 170,
        "image": "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400&q=80",
        "desc": "बासमती चावल, दम कुक्ड वेजीस, बूंदी रायता के साथ",
        "enDesc": "Fragrant basmati rice cooked with herbs & raita",
      },
      {
        "name": "चिली पनीर ग्रेवी",
        "en": "Chilli Paneer Gravy",
        "price": 160,
        "image": "https://images.unsplash.com/photo-1525755662778-989d0524087e?w=400&q=80",
        "desc": "चाइनीज स्टाइल क्रिस्पी पनीर शिमला मिर्च के साथ",
        "enDesc": "Spicy Indo-Chinese paneer with bell peppers",
      },
    ]
  },
  {
    "id": "4",
    "name": "Sweets Ganga",
    "hindiName": "स्वीट्स गंगा (नेहरू चौक)",
    "image": "https://images.unsplash.com/photo-1505253758473-96b3015f27eb?w=600&q=80",
    "area": "नेहरू चौक, गंजबासौदा",
    "tag": "समोसा, कचौरी व देशी घी की जलेबी",
    "enTag": "Samosa, Kachori & Desi Ghee Jalebi",
    "rating": "4.7",
    "time": "15 min",
    "discount": "TOP SELLER",
    "menu": [
      {
        "name": "गरमा-गरम समोसा (2 पीस)",
        "en": "Hot Samosa (2 Pcs)",
        "price": 30,
        "image": "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400&q=80",
        "desc": "मसालेदार आलू समोसा, हरी व मीठी चटनी के साथ",
        "enDesc": "Crispy spiced potato samosas with tangy chutneys",
      },
      {
        "name": "देशी घी की जलेबी (250 ग्राम)",
        "en": "Desi Ghee Jalebi (250g)",
        "price": 80,
        "image": "https://images.unsplash.com/photo-1599488615731-7e5c2823ff28?w=400&q=80",
        "desc": "कुरकुरी और रसीली शुद्ध देशी घी में तली जलेबी",
        "enDesc": "Crispy golden spirals soaked in saffron sugar syrup",
      },
      {
        "name": "स्पेशल काजू कतली (250 ग्राम)",
        "en": "Kaju Katli (250g)",
        "price": 220,
        "image": "https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?w=400&q=80",
        "desc": "100% शुद्ध काजू की पारंपरिक मिठाई",
        "enDesc": "Pure cashew nut fudge dessert",
      },
    ]
  },
];

// ---------------- 1. HOME SCREEN ----------------
class HomeFeedScreen extends StatelessWidget {
  const HomeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        toolbarHeight: 78,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "CRAVIO",
                  style: TextStyle(
                    color: Color(0xFFFF5722),
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _showAddressSheet(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFFF5722).withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, size: 13, color: Color(0xFFFF5722)),
                        const SizedBox(width: 2),
                        Text(
                          state.userArea,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFFF5722)),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 14, color: Color(0xFFFF5722)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              "Presented by Eevaan Ventures",
              style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          // Instant Language Toggle
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _langButton("हि", state.isHindi, () => state.setLanguage(true)),
                _langButton("EN", !state.isHindi, () => state.setLanguage(false)),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Address Strip
          InkWell(
            onTap: () => _showAddressSheet(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6)],
              ),
              child: Row(
                children: [
                  const Icon(Icons.navigation, size: 18, color: Color(0xFFFF5722)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.isHindi ? "डिलीवरी का पता (टैप करके बदलें):" : "Delivering To (Tap to change):",
                          style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.fullAddress,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.edit_outlined, size: 16, color: Color(0xFFFF5722)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5722), Color(0xFFFF7A50)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: const Color(0xFFFF5722).withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          state.isHindi ? "सीधा काउंटर रेट पर" : "Direct Menu Rates",
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        state.isHindi ? "गंजबासौदा का मनपसंद खाना\nघर बैठे मंगवाएं!" : "Ganj Basoda's Best Meals\nDelivered to Doorstep!",
                        style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold, height: 1.25),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200&q=80",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          Text(
            state.isHindi ? "गंजबासौदा के प्रमुख रेस्टोरेंट्स" : "Popular Restaurants in Ganj Basoda",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Restaurant Cards
          ...basodaRestaurants.map((res) {
            return Card(
              margin: const EdgeInsets.only(bottom: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              elevation: 2.5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RestaurantDetailMenuScreen(restaurant: res)),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Restaurant Cover Photo
                    Stack(
                      children: [
                        Image.network(
                          res["image"],
                          height: 145,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 145,
                            color: Colors.orange.shade100,
                            child: const Icon(Icons.fastfood, size: 50, color: Color(0xFFFF5722)),
                          ),
                        ),
                        // Offer Badge
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF5722),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              res["discount"],
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // Time Badge
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.timer, size: 12, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  res["time"],
                                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
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
                              Text(
                                state.isHindi ? res["hindiName"] : res["name"],
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade700,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    Text("★ ${res["rating"]}", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(res["area"], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          Text(
                            state.isHindi ? res["tag"] : res["enTag"],
                            style: TextStyle(color: Colors.orange.shade900, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const Divider(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF5722),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => RestaurantDetailMenuScreen(restaurant: res)),
                                );
                              },
                              icon: const Icon(Icons.restaurant_menu, color: Colors.white, size: 18),
                              label: Text(
                                state.isHindi ? "मेन्यू देखें और ऑर्डर करें ➔" : "View Menu & Order ➔",
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
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

  Widget _langButton(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF5722) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  static void _showAddressSheet(BuildContext context) {
    final state = AppState.instance;
    final nameCtrl = TextEditingController(text: state.userName);
    final phoneCtrl = TextEditingController(text: state.userPhone);
    final areaCtrl = TextEditingController(text: state.userArea);
    final houseCtrl = TextEditingController(text: state.userHouseNo);
    final landmarkCtrl = TextEditingController(text: state.userLandmark);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.isHindi ? "डिलीवरी का पता दर्ज करें" : "Set Delivery Address",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close)),
                ],
              ),
              const Divider(),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "कस्टमर का नाम (Name)", icon: Icon(Icons.person)),
              ),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "मोबाइल नंबर (Phone)", icon: Icon(Icons.phone)),
              ),
              TextField(
                controller: areaCtrl,
                decoration: const InputDecoration(labelText: "मोहल्ला / एरिया (जैसे: नेहरू चौक, बरेथ रोड)", icon: Icon(Icons.location_city)),
              ),
              TextField(
                controller: houseCtrl,
                decoration: const InputDecoration(labelText: "मकान / दुकान नंबर (House/Shop No.)", icon: Icon(Icons.home)),
              ),
              TextField(
                controller: landmarkCtrl,
                decoration: const InputDecoration(labelText: "लैंडमार्क (जैसे: भारत पेट्रोल पंप के पास)", icon: Icon(Icons.near_me)),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    state.updateAddress(
                      name: nameCtrl.text,
                      phone: phoneCtrl.text,
                      area: areaCtrl.text,
                      houseNo: houseCtrl.text,
                      landmark: landmarkCtrl.text,
                    );
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    state.isHindi ? "पता सेव करें" : "Save Address",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
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

// ---------------- 2. RESTAURANT MENU DETAIL SCREEN ----------------
class RestaurantDetailMenuScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  const RestaurantDetailMenuScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailMenuScreen> createState() => _RestaurantDetailMenuScreenState();
}

class _RestaurantDetailMenuScreenState extends State<RestaurantDetailMenuScreen> {
  @override
  Widget build(BuildContext context) {
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
          selectedList.add({
            "title": state.isHindi ? item["name"] : item["en"],
            "price": price,
            "qty": qty,
          });
        }
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.isHindi ? res["hindiName"] : res["name"],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(res["area"], style: const TextStyle(fontSize: 11, color: Colors.grey)),
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

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dish Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 1.5)),
                          child: const Icon(Icons.circle, color: Colors.green, size: 8),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.isHindi ? item["name"] : item["en"],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹$itemPrice",
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFFF5722)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state.isHindi ? item["desc"] : item["enDesc"],
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Dish Photo & Counter Button
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item["image"],
                      width: 95,
                      height: 85,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 95,
                        height: 85,
                        color: Colors.orange.shade50,
                        child: const Icon(Icons.fastfood, color: Colors.orange),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFF5722)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)],
                    ),
                    child: qty == 0
                        ? InkWell(
                            onTap: () => setState(() => state.addToCart(itemKey, rName)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                              child: Text(
                                state.isHindi ? "+ जोड़ें" : "+ ADD",
                                style: const TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.all(4),
                                icon: const Icon(Icons.remove, size: 14, color: Color(0xFFFF5722)),
                                onPressed: () => setState(() => state.removeFromCart(itemKey)),
                              ),
                              Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.all(4),
                                icon: const Icon(Icons.add, size: 14, color: Color(0xFFFF5722)),
                                onPressed: () => setState(() => state.addToCart(itemKey, rName)),
                              ),
                            ],
                          ),
                  )
                ],
              )
            ],
          );
        },
      ),
      bottomNavigationBar: totalCount > 0
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -3))],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  _openCartBottomSheet(context, selectedList, totalAmount);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "$totalCount ${state.isHindi ? 'आइटम' : 'Items'} | ₹$totalAmount",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        state.isHindi ? "बिल देखें और ऑर्डर करें ➔" : "View Cart & Order ➔",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  void _openCartBottomSheet(BuildContext context, List<Map<String, dynamic>> items, int subtotal) {
    final state = AppState.instance;
    const deliveryCharge = 20;
    final grandTotal = subtotal + deliveryCharge;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.isHindi ? "अंतिम बिल का विवरण (Cravio Bill)" : "Order Bill Summary",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 18),
              ...items.map((i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${i['title']} x ${i['qty']}", style: const TextStyle(fontSize: 14)),
                        Text("₹${i['price'] * i['qty']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )),
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.isHindi ? "लोकल डिलीवरी चार्ज" : "Delivery Charge"),
                  const Text("₹$deliveryCharge"),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.isHindi ? "कुल भुगतान (कैश ऑन डिलीवरी)" : "Total Due (Cash on Delivery)", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text("₹$grandTotal", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFFF5722))),
                ],
              ),
              const Divider(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.isHindi ? "डिलीवरी का पता:" : "Delivering To:",
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFFF5722)),
                    ),
                    Text(
                      state.fullAddress,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                ),
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
                    state.placeOrder(items, grandTotal);
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.isHindi ? "🎉 बधाई! आपका ऑर्डर होटल को भेज दिया गया है।" : "🎉 Success! Order sent to restaurant.",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Text(
                    state.isHindi ? "ऑर्डर कन्फर्म करें (कैश ऑन डिलीवरी)" : "Confirm Cash on Delivery",
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

// ---------------- 3. CUSTOMER ORDERS SCREEN ----------------
class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFC),
      appBar: AppBar(
        title: Text(state.isHindi ? "मेरे ऑर्डर (Live Tracking)" : "My Orders"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: state.orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.receipt_long, size: 70, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    state.isHindi ? "आपने अभी तक कोई ऑर्डर नहीं किया है।" : "No active orders placed yet.",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              itemBuilder: (context, idx) {
                final o = state.orders[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
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
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: o.status.contains("Ready") || o.status.contains("Delivered") || o.status.contains("तैयार")
                                    ? Colors.green.shade100
                                    : Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                o.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: o.status.contains("Ready") || o.status.contains("Delivered") || o.status.contains("तैयार")
                                      ? Colors.green.shade900
                                      : Colors.orange.shade900,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(o.restaurantName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text("${state.isHindi ? 'पता:' : 'Address:'} ${o.address} (${o.landmark})", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        const Divider(height: 16),
                        ...o.items.map((i) => Text("• ${i['title']} x ${i['qty']}", style: const TextStyle(fontSize: 13))),
                        const Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.isHindi ? "कुल बिल (कैश ऑन डिलीवरी)" : "Total Bill (COD)", style: const TextStyle(color: Colors.grey)),
                            Text("₹${o.totalAmount}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFFF5722))),
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

// ---------------- 4. RESTAURANT PARTNER SCREEN ----------------
class RestaurantPartnerScreen extends StatelessWidget {
  const RestaurantPartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFC),
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.isHindi ? "होटल मारवाड़ी - पार्टनर पोर्टल" : "Restaurant Partner Portal"),
            const Text("Ganj Basoda Branch", style: TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => state.setRole('Customer'),
            child: const Text("वापस ग्राहक बनें", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: state.orders.isEmpty
          ? const Center(child: Text("अभी कोई नया ऑर्डर नहीं है (No new orders)"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              itemBuilder: (context, idx) {
                final o = state.orders[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ऑर्डर ID: ${o.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("स्थिति: ${o.status}", style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                        const Divider(),
                        Text("ग्राहक: ${o.customerName} (${o.customerPhone})"),
                        Text("डिलीवरी पता: ${o.address}"),
                        Text("लैंडमार्क: ${o.landmark}", style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        ...o.items.map((i) => Text("• ${i['title']} x ${i['qty']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800),
                              onPressed: () => state.updateOrderStatus(o.id, state.isHindi ? "खाना बन रहा है (Preparing)" : "Preparing"),
                              child: Text(state.isHindi ? "स्वीकार करें (Accept)" : "Accept", style: const TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
                              onPressed: () => state.updateOrderStatus(o.id, state.isHindi ? "खाना तैयार है (Ready)" : "Ready for Pickup"),
                              child: Text(state.isHindi ? "तैयार है (Ready)" : "Ready", style: const TextStyle(color: Colors.white)),
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

// ---------------- 5. EEVAAN VENTURES ADMIN SCREEN ----------------
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    int totalGross = 0;
    for (var o in state.orders) {
      totalGross += o.totalAmount;
    }
    int commissionEarned = (totalGross * 0.10).round();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        title: const Text("Eevaan Ventures Super Admin"),
        actions: [
          TextButton(
            onPressed: () => state.setRole('Customer'),
            child: const Text("ग्राहक बनें", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricCard("कुल ऑर्डर्स", "${state.orders.length}", Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard("कुल बिक्री", "₹$totalGross", Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildMetricCard("ईवान वेंचर्स कमीशन (10%)", "₹$commissionEarned", Colors.green),
          const SizedBox(height: 24),
          const Text("लाइव ऑर्डर व डिलीवरी असाइन करें:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          ...state.orders.map((o) {
            return ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              title: Text("${o.restaurantName} ➔ ${o.customerName}"),
              subtitle: Text("ID: ${o.id} | ${o.address} | Status: ${o.status}"),
              trailing: PopupMenuButton<String>(
                onSelected: (st) => state.updateOrderStatus(o.id, st),
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: "राइडर रवाना (Out for Delivery)", child: Text("Out for Delivery")),
                  const PopupMenuItem(value: "सफलतापूर्वक डिलीवर (Delivered)", child: Text("Mark Delivered")),
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

// ---------------- 6. PROFILE SCREEN ----------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFC),
      appBar: AppBar(
        title: Text(state.isHindi ? "मेरी प्रोफ़ाइल एवं सेटिंग्स" : "Profile & Settings"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: const Color(0xFFFF5722),
                child: Text(
                  state.userName.isNotEmpty ? state.userName[0] : "C",
                  style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.userName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(state.userPhone, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 2),
                    Text(state.fullAddress, style: TextStyle(color: Colors.grey.shade600, fontSize: 11), maxLines: 2),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFFFF5722)),
                onPressed: () => HomeFeedScreen._showAddressSheet(context),
              )
            ],
          ),
          const Divider(height: 36),

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
                _roleTab("Customer", state.isHindi ? "ग्राहक" : "Customer", state),
                _roleTab("Restaurant", state.isHindi ? "रेस्टोरेंट" : "Restaurant", state),
                _roleTab("Admin", state.isHindi ? "एडमिन" : "Admin", state),
              ],
            ),
          ),

          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.location_on, color: Color(0xFFFF5722)),
            title: Text(state.isHindi ? "डिलीवरी पता बदलें" : "Edit Delivery Address"),
            subtitle: Text(state.fullAddress),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => HomeFeedScreen._showAddressSheet(context),
          ),
          const ListTile(
            leading: Icon(Icons.verified, color: Color(0xFFFF5722)),
            title: Text("Cravio Platform"),
            subtitle: Text("Presented by Eevaan Ventures"),
          ),
        ],
      ),
    );
  }

  Widget _roleTab(String role, String label, AppState state) {
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
