import 'package:flutter/material.dart';

void main() {
  runApp(const CravioApp());
}

// ---------------- GLOBAL APPLICATION STATE ----------------
class ActiveOrder {
  final String id;
  final String customerName;
  final String customerPhone;
  final String address;
  final String restaurantName;
  final List<Map<String, dynamic>> items;
  final int totalAmount;
  String status;

  ActiveOrder({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.address,
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

  // User Profile
  String userName = "राहुल शर्मा (Rahul Sharma)";
  String userPhone = "9826012345";
  String userAddress = "नेहरू चौक, स्टेशन रोड, गंजबासौदा";

  // Cart & Orders
  Map<String, int> cart = {}; // ItemName -> Qty
  String activeRestaurant = "";
  List<ActiveOrder> orders = [];

  void toggleLanguage() {
    isHindi = !isHindi;
    notifyListeners();
  }

  void setRole(String role) {
    currentRole = role;
    notifyListeners();
  }

  void updateProfile(String name, String phone, String address) {
    userName = name;
    userPhone = phone;
    userAddress = address;
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

  void createOrder(List<Map<String, dynamic>> orderItems, int total) {
    final newOrder = ActiveOrder(
      id: "CRV-${DateTime.now().millisecondsSinceEpoch % 10000}",
      customerName: userName,
      customerPhone: userPhone,
      address: userAddress,
      restaurantName: activeRestaurant,
      items: List.from(orderItems),
      totalAmount: total,
      status: isHindi ? "ऑर्डर दर्ज हुआ (Placed)" : "Order Placed",
    );
    orders.insert(0, newOrder);
    clearCart();
    notifyListeners();
  }

  void updateStatus(String orderId, String newStatus) {
    final idx = orders.indexWhere((o) => o.id == orderId);
    if (idx != -1) {
      orders[idx].status = newStatus;
      notifyListeners();
    }
  }
}

// ---------------- MAIN WIDGET ----------------
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
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5722)),
            scaffoldBackgroundColor: const Color(0xFFF8F9FA),
            fontFamily: 'Roboto',
          ),
          home: const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    // Admin View
    if (state.currentRole == 'Admin') {
      return const EevaanAdminView();
    }
    // Restaurant Partner View
    if (state.currentRole == 'Restaurant') {
      return const RestaurantPartnerView();
    }

    // Customer View with Navigation
    final pages = [
      const HomeFeedView(),
      const CustomerOrdersView(),
      const ProfileSettingsView(),
    ];

    return Scaffold(
      body: pages[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        selectedItemColor: const Color(0xFFFF5722),
        unselectedItemColor: Colors.grey.shade600,
        onTap: (i) => setState(() => _currentTab = i),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant),
            label: state.isHindi ? "होम (Home)" : "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt_long),
            label: state.isHindi ? "मेरे ऑर्डर" : "My Orders",
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

// ---------------- RESTAURANTS DATABASE ----------------
final List<Map<String, dynamic>> ganjBasodaRestaurants = [
  {
    "id": "1",
    "name": "Hotel Marwari",
    "hindiName": "होटल मारवाड़ी",
    "location": "नेहरू चौक, गंजबासौदा",
    "enLocation": "Nehru Chowk, Ganj Basoda",
    "tag": "शुद्ध शाकाहारी भोजन, थाली व मिठाई",
    "enTag": "Pure Veg Meals, Thali & Sweets",
    "rating": "4.5",
    "time": "20-25 min",
    "offer": "FLAT ₹30 OFF",
    "menu": [
      {
        "id": "m1",
        "name": "मारवाड़ी स्पेशल थाली",
        "en": "Marwari Special Thali",
        "price": 180,
        "desc": "दाल तड़का, शाही पनीर, सूखी मौसमी सब्जी, 4 बटर रोटी, चावल, रायता व गुलाब जामुन",
        "enDesc": "Dal Tadka, Shahi Paneer, Veg Sabji, 4 Butter Roti, Rice, Raita & Sweet",
      },
      {
        "id": "m2",
        "name": "दाल बाटी चूरमा स्पेशल थाली",
        "en": "Dal Baati Churma Thali",
        "price": 150,
        "desc": "4 देशी घी बाटी, स्वादिष्ट दाल, स्पेशल चूरमा और लहसुन चटनी",
        "enDesc": "4 Desi Ghee Baati, Dal, Churma & Garlic Chutney",
      },
      {
        "id": "m3",
        "name": "पनीर बटर मसाला",
        "en": "Paneer Butter Masala",
        "price": 160,
        "desc": "ताजा मलाईदार पनीर रिच टमॅटो-बटर ग्रेवी में",
        "enDesc": "Fresh Cottage Cheese in rich creamy butter gravy",
      },
      {
        "id": "m4",
        "name": "तंदूरी बटर रोटी",
        "en": "Tandoori Butter Roti",
        "price": 15,
        "desc": "तंदूर में सिकी गरमा-गरम मक्खन रोटी",
        "enDesc": "Crisp clay-oven baked bread with fresh butter",
      },
      {
        "id": "m5",
        "name": "गुलाब जामुन (2 पीस)",
        "en": "Gulab Jamun (2 Pcs)",
        "price": 40,
        "desc": "शुद्ध खोया से निर्मित गरमा-गरम गुलाब जामुन",
        "enDesc": "Warm delicious sweet khoya dumplings",
      },
    ]
  },
  {
    "id": "2",
    "name": "Da Pixza Lover",
    "hindiName": "दा पिज़्ज़ा लवर",
    "location": "स्टेशन मेन रोड, गंजबासौदा",
    "enLocation": "Station Main Road, Ganj Basoda",
    "tag": "पिज़्ज़ा, बर्गर, शेक्स और फ्राइज़",
    "enTag": "Pizzas, Burgers, Shakes & Snacks",
    "rating": "4.4",
    "time": "15-20 min",
    "offer": "20% OFF",
    "menu": [
      {
        "id": "p1",
        "name": "फार्महाउस चीज़ी पिज़्ज़ा (7 Inch)",
        "en": "Farmhouse Cheesy Pizza",
        "price": 199,
        "desc": "ताजा शिमला मिर्च, प्याज, स्वीट कॉर्न और डबल मोज़ेरेला चीज़",
        "enDesc": "Capsicum, Onion, Sweet Corn & Loaded Mozzarella",
      },
      {
        "id": "p2",
        "name": "क्रंची वेज चीज़ बर्गर",
        "en": "Crunchy Veg Cheese Burger",
        "price": 79,
        "desc": "क्रिस्पी वेज टिक्की, चीज़ स्लाइस और सीक्रेट सॉस",
        "enDesc": "Crispy Veg Patty, Cheese Slice & Secret Herb Sauce",
      },
      {
        "id": "p3",
        "name": "पेरी पेरी फ्रेंच फ्राइज़",
        "en": "Peri Peri French Fries",
        "price": 89,
        "desc": "क्रिस्पी पोटैटो फ्राइज़ तीखे पेरी-पेरी मसाले के साथ",
        "enDesc": "Crispy golden potato fries tossed in spicy peri-peri mix",
      },
      {
        "id": "p4",
        "name": "थिक चॉकलेट कोल्ड कॉफ़ी",
        "en": "Chocolate Cold Coffee",
        "price": 80,
        "desc": "वैनिला आइसक्रीम और चॉकलेट सिरप से भरपूर गाढ़ी कॉफ़ी",
        "enDesc": "Rich creamy blended cold coffee with chocolate fudge",
      },
    ]
  },
  {
    "id": "3",
    "name": "The Pride Restaurant",
    "hindiName": "द प्राइड रेस्टोरेंट",
    "location": "बरेथ रोड, गंजबासौदा",
    "enLocation": "Bareth Road, Ganj Basoda",
    "tag": "नॉर्थ इंडियन, चाइनीज़ व दम बिरयानी",
    "enTag": "North Indian, Chinese & Dum Biryani",
    "rating": "4.3",
    "time": "25-30 min",
    "offer": "FREE DELIVERY",
    "menu": [
      {
        "id": "pr1",
        "name": "पनीर टिक्का मसाला",
        "en": "Paneer Tikka Masala",
        "price": 210,
        "desc": "चारकोल रोस्टेड पनीर क्यूब्स तीखी गाढ़ी ग्रेवी में",
        "enDesc": "Charcoal grilled paneer in rich spiced red gravy",
      },
      {
        "id": "pr2",
        "name": "शाही वेज दम बिरयानी",
        "en": "Shahi Veg Dum Biryani",
        "price": 170,
        "desc": "लॉन्ग ग्रेन बासमती राइस, दम कुक्ड वेजीस, बूंदी रायता",
        "enDesc": "Basmati rice dum cooked with exotic herbs, served with raita",
      },
      {
        "id": "pr3",
        "name": "चिली पनीर ड्राई / ग्रेवी",
        "en": "Chilli Paneer",
        "price": 160,
        "desc": "चाइनीज स्टाइल क्रिस्पी पनीर शिमला मिर्च के साथ",
        "enDesc": "Indo-Chinese spiced paneer with bell peppers",
      },
    ]
  },
  {
    "id": "4",
    "name": "Sweets Ganga",
    "hindiName": "स्वीट्स गंगा (नेहरू चौक)",
    "location": "नेहरू चौक, गंजबासौदा",
    "enLocation": "Nehru Chowk, Ganj Basoda",
    "tag": "समोसा, कचौरी, देशी घी की जलेबी",
    "enTag": "Samosa, Kachori & Desi Ghee Jalebi",
    "rating": "4.6",
    "time": "15 min",
    "offer": "TOP SELLER",
    "menu": [
      {
        "id": "s1",
        "name": "गरमा-गरम समोसा (2 पीस)",
        "en": "Hot Samosa (2 Pcs)",
        "price": 30,
        "desc": "मसालेदार काजू-किशमिश आलू समोसा, हरी व मीठी चटनी के साथ",
        "enDesc": "Crispy spiced potato samosas with green & tamarind chutneys",
      },
      {
        "id": "s2",
        "name": "देशी घी की जलेबी (250 ग्राम)",
        "en": "Desi Ghee Jalebi (250g)",
        "price": 80,
        "desc": "कुरकुरी और रसीली शुद्ध देशी घी में बनी जलेबी",
        "enDesc": "Fresh crispy spiral sweets soaked in saffron sugar syrup",
      },
      {
        "id": "s3",
        "name": "स्पेशल काजू कतली (250 ग्राम)",
        "en": "Special Kaju Katli (250g)",
        "price": 220,
        "desc": "100% शुद्ध काजू और चांदी के वर्क से सजी पारंपरिक मिठाई",
        "enDesc": "Pure cashew nut diamond sweets",
      },
    ]
  },
];

// ---------------- 1. HOME FEED VIEW ----------------
class HomeFeedView extends StatelessWidget {
  const HomeFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 75,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFFF5722).withOpacity(0.3)),
                  ),
                  child: const Text(
                    "📍 गंजबासौदा",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFFF5722)),
                  ),
                ),
              ],
            ),
            const Text(
              "Presented by Eevaan Ventures",
              style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ActionChip(
              backgroundColor: const Color(0xFFFF5722),
              avatar: const Icon(Icons.language, color: Colors.white, size: 16),
              label: Text(
                state.isHindi ? "English" : "हिंदी",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              onPressed: () => state.toggleLanguage(),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          state.isHindi ? "सीधा रेस्टोरेंट के रेट पर" : "Direct Menu Rates",
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.isHindi ? "गंजबासौदा का मनपसंद खाना\nअब घर बैठे मंगाएं!" : "Ganj Basoda's Best Taste\nDelivered to Doorstep!",
                        style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold, height: 1.25),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.delivery_dining, size: 60, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text(
            state.isHindi ? "गंजबासौदा के प्रसिद्ध रेस्टोरेंट्स" : "Popular Restaurants in Ganj Basoda",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Restaurant Cards
          ...ganjBasodaRestaurants.map((res) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 2.5,
              child: Padding(
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
                          decoration: BoxDecoration(color: Colors.green.shade700, borderRadius: BorderRadius.circular(5)),
                          child: Text("★ ${res["rating"]}", style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      state.isHindi ? res["location"] : res["enLocation"],
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    Text(
                      state.isHindi ? res["tag"] : res["enTag"],
                      style: TextStyle(color: Colors.orange.shade900, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 15, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(res["time"], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4)),
                          child: Text(res["offer"], style: const TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const Divider(height: 22),
                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5722),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RestaurantDetailMenuScreen(restaurant: res),
                            ),
                          );
                        },
                        icon: const Icon(Icons.menu_book, color: Colors.white, size: 18),
                        label: Text(
                          state.isHindi ? "मेन्यू देखें और खाना चुनें ➔" : "View Menu & Select Food ➔",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
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
}

// ---------------- 2. RESTAURANT DETAIL & MENU SCREEN ----------------
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.isHindi ? res["hindiName"] : res["name"],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              state.isHindi ? res["location"] : res["enLocation"],
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
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
              // Add / Minus Counter Button
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFF5722)),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: qty == 0
                    ? InkWell(
                        onTap: () => setState(() => state.addToCart(itemKey, rName)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          child: Text(
                            state.isHindi ? "+ जोड़ें" : "+ ADD",
                            style: const TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16, color: Color(0xFFFF5722)),
                            onPressed: () => setState(() => state.removeFromCart(itemKey)),
                          ),
                          Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
                        "$totalCount ${state.isHindi ? 'सामान' : 'Items'} | ₹$totalAmount",
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
                        Text("${i['title']}  x ${i['qty']}", style: const TextStyle(fontSize: 14)),
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
              Text(
                "${state.isHindi ? 'डिलीवरी पता:' : 'Delivering To:'} ${state.userAddress}",
                style: const TextStyle(color: Colors.black87, fontSize: 12),
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
                    state.createOrder(items, grandTotal);
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.isHindi ? "🎉 बधाई! आपका ऑर्डर सफलतापूर्वक दर्ज हुआ।" : "🎉 Success! Order Placed Successfully.",
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

// ---------------- 3. CUSTOMER ORDERS VIEW ----------------
class CustomerOrdersView extends StatelessWidget {
  const CustomerOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
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

// ---------------- 4. RESTAURANT PARTNER VIEW ----------------
class RestaurantPartnerView extends StatelessWidget {
  const RestaurantPartnerView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.isHindi ? "रेस्टोरेंट पार्टनर पोर्टल" : "Restaurant Partner Portal"),
            const Text("होटल मारवाड़ी - गंजबासौदा", style: TextStyle(fontSize: 11, color: Colors.white70)),
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
                        const SizedBox(height: 8),
                        ...o.items.map((i) => Text("• ${i['title']} x ${i['qty']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800),
                              onPressed: () => state.updateStatus(o.id, state.isHindi ? "खाना बन रहा है (Preparing)" : "Preparing"),
                              child: Text(state.isHindi ? "स्वीकार करें (Accept)" : "Accept", style: const TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
                              onPressed: () => state.updateStatus(o.id, state.isHindi ? "खाना तैयार है (Ready)" : "Ready for Pickup"),
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

// ---------------- 5. EEVAAN VENTURES ADMIN VIEW ----------------
class EevaanAdminView extends StatelessWidget {
  const EevaanAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    int totalGross = 0;
    for (var o in state.orders) {
      totalGross += o.totalAmount;
    }
    int commissionEarned = (totalGross * 0.10).round(); // 10% Eevaan Ventures Commission

    return Scaffold(
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
                child: _buildMetricCard("कुल ग्रॉस बिक्री", "₹$totalGross", Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildMetricCard("ईवान वेंचर्स शुद्ध कमीशन (10%)", "₹$commissionEarned", Colors.green),
          const SizedBox(height: 24),
          const Text("लाइव ऑर्डर व डिलीवरी असाइन करें:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          ...state.orders.map((o) {
            return ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              title: Text("${o.restaurantName} ➔ ${o.customerName}"),
              subtitle: Text("ID: ${o.id} | Status: ${o.status}"),
              trailing: PopupMenuButton<String>(
                onSelected: (st) => state.updateStatus(o.id, st),
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

// ---------------- 6. PROFILE & SETTINGS VIEW ----------------
class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

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
                    Text(state.userAddress, style: TextStyle(color: Colors.grey.shade600, fontSize: 11), maxLines: 2),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFFFF5722)),
                onPressed: () => _editProfileDialog(context),
              )
            ],
          ),
          const Divider(height: 36),

          // Role Switcher
          Text(
            state.isHindi ? "सिस्टम मोड बदलें (Role Switcher)" : "Switch System Role",
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
            leading: const Icon(Icons.language, color: Color(0xFFFF5722)),
            title: Text(state.isHindi ? "भाषा (Language)" : "Language"),
            trailing: Text(state.isHindi ? "हिंदी ➔ English" : "English ➔ हिंदी", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF5722))),
            onTap: () => state.toggleLanguage(),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Color(0xFFFF5722)),
            title: Text(state.isHindi ? "डिलीवरी पता बदलें" : "Edit Address"),
            subtitle: Text(state.userAddress),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => _editProfileDialog(context),
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

  void _editProfileDialog(BuildContext context) {
    final state = AppState.instance;
    final nameCtrl = TextEditingController(text: state.userName);
    final phoneCtrl = TextEditingController(text: state.userPhone);
    final addrCtrl = TextEditingController(text: state.userAddress);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(state.isHindi ? "प्रोफ़ाइल बदलें" : "Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "नाम (Name)")),
              TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: "फ़ोन नंबर (Phone)")),
              TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: "गंजबासौदा का पता (Address)")),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("रद्द करें")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF5722)),
              onPressed: () {
                state.updateProfile(nameCtrl.text, phoneCtrl.text, addrCtrl.text);
                Navigator.pop(ctx);
              },
              child: const Text("सेव करें", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
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
