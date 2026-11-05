import 'package:flutter/material.dart';

void main() {
  runApp(const CravioApp());
}

// ---------------- APP CONTROLLER ----------------
class AppState extends ChangeNotifier {
  static final AppState instance = AppState();

  bool isHindi = true;

  String userName = "राहुल शर्मा";
  String userPhone = "9826012345";
  String userArea = "नेहरू चौक";
  String userHouse = "मकान नं. 42, गली नं. 2";
  String userLandmark = "पुरानी गल्ला मंडी के पास, गंजबासौदा";

  String get fullAddress => "$userHouse, $userArea ($userLandmark)";

  Map<String, int> cart = {};
  String activeRestaurant = "";
  List<Map<String, dynamic>> orders = [];

  void toggleLang(bool hindi) {
    isHindi = hindi;
    notifyListeners();
  }

  void updateAddress(String name, String phone, String area, String house, String landmark) {
    userName = name;
    userPhone = phone;
    userArea = area;
    userHouse = house;
    userLandmark = landmark;
    notifyListeners();
  }

  void addToCart(String item, String res) {
    if (activeRestaurant.isNotEmpty && activeRestaurant != res) {
      cart.clear();
    }
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

  void placeOrder(List<Map<String, dynamic>> items, int total) {
    orders.insert(0, {
      "id": "CRV-${DateTime.now().millisecondsSinceEpoch % 10000}",
      "res": activeRestaurant,
      "items": List.from(items),
      "total": total,
      "status": isHindi ? "स्वीकृत (Confirmed)" : "Confirmed",
      "time": "Just now",
    });
    cart.clear();
    activeRestaurant = "";
    notifyListeners();
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
          title: 'Cravio - Ganj Basoda',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF9F8F6), // Warm Pearl Cream
            primaryColor: const Color(0xFF262220), // Brown Diamond Smoke
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF262220),
              primary: const Color(0xFF262220),
              secondary: const Color(0xFFC5A059), // Champagne Diamond Gold
            ),
            fontFamily: 'Roboto',
          ),
          home: const MainNavigationScreen(),
        );
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
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
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
        ),
        child: BottomNavigationBar(
          currentIndex: _tab,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: const Color(0xFF262220),
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          onTap: (i) => setState(() => _tab = i),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.storefront_outlined),
              activeIcon: const Icon(Icons.storefront),
              label: state.isHindi ? "रेस्टोरेंट" : "Restaurants",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long_outlined),
              activeIcon: const Icon(Icons.receipt_long),
              label: state.isHindi ? "मेरे ऑर्डर" : "My Orders",
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

// ---------------- RESTAURANTS DATABASE ----------------
final List<Map<String, dynamic>> ganjBasodaRestaurants = [
  {
    "name": "Hotel Marwari",
    "hindiName": "होटल मारवाड़ी",
    "image": "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&q=80",
    "area": "नेहरू चौक, गंजबासौदा",
    "tag": "शुद्ध शाकाहारी थाली, दाल बाटी व मिठाई",
    "enTag": "Pure Veg Thali, Dal Baati & Sweets",
    "rating": "4.8",
    "reviewsCount": "1,240+",
    "time": "20-25 min",
    "offer": "FLAT ₹30 OFF",
    "menu": [
      {
        "name": "मारवाड़ी स्पेशल थाली",
        "en": "Marwari Special Thali",
        "price": 180,
        "image": "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400&q=80",
        "desc": "दाल तड़का, शाही पनीर, सूखी सब्जी, 4 बटर रोटी, चावल, रायता व मीठा",
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
    ]
  },
  {
    "name": "Da Pixza Lover",
    "hindiName": "दा पिज़्ज़ा लवर",
    "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&q=80",
    "area": "स्टेशन रोड, गंजबासौदा",
    "tag": "चीज़ी पिज़्ज़ा, बर्गर, शेक्स और फ्राइज़",
    "enTag": "Loaded Pizzas, Burgers & Shakes",
    "rating": "4.7",
    "reviewsCount": "890+",
    "time": "15-20 min",
    "offer": "20% OFF",
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
    ]
  },
  {
    "name": "The Pride Restaurant",
    "hindiName": "द प्राइड रेस्टोरेंट",
    "image": "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=600&q=80",
    "area": "बरेथ रोड, गंजबासौदा",
    "tag": "नॉर्थ इंडियन, चाइनीज़ व दम बिरयानी",
    "enTag": "North Indian, Chinese & Biryani",
    "rating": "4.6",
    "reviewsCount": "620+",
    "time": "25-30 min",
    "offer": "FREE DELIVERY",
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
    ]
  },
  {
    "name": "Sweets Ganga",
    "hindiName": "स्वीट्स गंगा",
    "image": "https://images.unsplash.com/photo-1505253758473-96b3015f27eb?w=600&q=80",
    "area": "नेहरू चौक, गंजबासौदा",
    "tag": "समोसा, कचौरी व देशी घी की जलेबी",
    "enTag": "Samosa, Kachori & Desi Ghee Jalebi",
    "rating": "4.9",
    "reviewsCount": "1,850+",
    "time": "15 min",
    "offer": "TOP SELLER",
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
    ]
  },
];

// ---------------- 1. CUSTOMER HOME SCREEN ----------------
class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppState.instance.isHindi ? "✓ मेन्यू और रेट्स तुरंत अपडेट हो गए!" : "✓ Menus & rates updated live!",
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF262220),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      key: ValueKey("HomeLangKey_${state.isHindi}"),
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF262220), // Brown Diamond Smoke
        elevation: 0,
        toolbarHeight: 88,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Stylish CRAVIO Typography
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.4)),
                  ),
                  child: const Text(
                    "C R A V I O",
                    style: TextStyle(
                      color: Color(0xFFC5A059),
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      letterSpacing: 3,
                    ),
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
          // Instant 0ms Language Toggle
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 14),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  _langButton("हि", state.isHindi, () {
                    setState(() => state.toggleLang(true));
                  }),
                  _langButton("EN", !state.isHindi, () {
                    setState(() => state.toggleLang(false));
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: const Color(0xFFC5A059),
        backgroundColor: const Color(0xFF262220),
        onRefresh: _refreshData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Delivery Address Bar
            InkWell(
              onTap: () => _openAddressDialog(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6)],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 20, color: Color(0xFFC5A059)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.isHindi ? "वर्तमान डिलीवरी पता (बदलने के लिए टैप करें):" : "Delivery Address (Tap to change):",
                            style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            state.fullAddress,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF262220)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Digital Trust & Verified Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _digitalBadge(Icons.star, "4.8 ★ रेटिंग्स", "1,450+ ऑर्डर्स"),
                  Container(height: 24, width: 1, color: Colors.grey.shade200),
                  _digitalBadge(Icons.verified_user, "100% हाइजीन", "गंजबासौदा वेरिफाइड"),
                  Container(height: 24, width: 1, color: Colors.grey.shade200),
                  _digitalBadge(Icons.bolt, "20-25 मिनट", "फास्ट डिलीवरी"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Executive Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF262220), Color(0xFF383330)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF262220).withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4)),
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
                          decoration: BoxDecoration(
                            color: const Color(0xFFC5A059),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            state.isHindi ? "काउंटर रेट पर घर बैठे" : "AUTHENTIC COUNTER RATES",
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.isHindi ? "गंजबासौदा के प्रसिद्ध रेस्टोरेंट्स\nअब सिर्फ एक क्लिक पर!" : "Ganj Basoda's Famous Dining\nDelivered Directly to You!",
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.3),
                        ),
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
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            Text(
              state.isHindi ? "गंजबासौदा के प्रमुख रेस्टोरेंट्स" : "Popular Restaurants in Ganj Basoda",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF262220)),
            ),
            const SizedBox(height: 14),

            // Restaurant Cards
            ...ganjBasodaRestaurants.map((res) {
              return Card(
                margin: const EdgeInsets.only(bottom: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 1.5,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RestaurantMenuScreen(restaurant: res)),
                    );
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
                          ),
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF262220),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFC5A059)),
                              ),
                              child: Text(
                                res["offer"],
                                style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
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
                                  const Icon(Icons.timer_outlined, size: 12, color: Colors.white),
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
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF262220),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: const Color(0xFFC5A059)),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "★ ${res["rating"]}",
                                        style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " (${res["reviewsCount"]})",
                                        style: const TextStyle(color: Colors.white70, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(res["area"], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                            Text(
                              state.isHindi ? res["tag"] : res["enTag"],
                              style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            const Divider(height: 22),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF262220),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => RestaurantMenuScreen(restaurant: res)),
                                  );
                                },
                                child: Text(
                                  state.isHindi ? "मेन्यू देखें और खाना चुनें ➔" : "View Menu & Order ➔",
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
      ),
    );
  }

  Widget _digitalBadge(IconData icon, String title, String sub) {
    return Column(
      children: [
        Icon(icon, size: 16, color: const Color(0xFFC5A059)),
        const SizedBox(height: 2),
        Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
        Text(sub, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }

  Widget _langButton(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFC5A059) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  void _openAddressDialog(BuildContext context) {
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
                state.isHindi ? "डिलीवरी का पता अपडेट करें" : "Update Delivery Address",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220)),
              ),
              const Divider(),
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "कस्टमर का नाम")),
              TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "मोबाइल नंबर")),
              TextField(controller: areaCtrl, decoration: const InputDecoration(labelText: "मोहल्ला / एरिया (जैसे: नेहरू चौक, बरेथ रोड)")),
              TextField(controller: houseCtrl, decoration: const InputDecoration(labelText: "मकान / दुकान नंबर")),
              TextField(controller: landmarkCtrl, decoration: const InputDecoration(labelText: "लैंडमार्क (जैसे: भारत पेट्रोल पंप के पास)")),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF262220),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    state.updateAddress(nameCtrl.text, phoneCtrl.text, areaCtrl.text, houseCtrl.text, landmarkCtrl.text);
                    Navigator.pop(ctx);
                    setState(() {});
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
class RestaurantMenuScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  const RestaurantMenuScreen({super.key, required this.restaurant});

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
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
              selectedList.add({
                "title": state.isHindi ? item["name"] : item["en"],
                "price": price,
                "qty": qty,
              });
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
                Text(
                  state.isHindi ? res["hindiName"] : res["name"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(res["area"], style: const TextStyle(fontSize: 11, color: Colors.white70)),
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
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF262220)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "₹$itemPrice",
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFC5A059)),
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
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF262220)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)],
                        ),
                        child: qty == 0
                            ? InkWell(
                                onTap: () => state.addToCart(itemKey, rName),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                  child: Text(
                                    "+ ADD",
                                    style: TextStyle(color: Color(0xFF262220), fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(4),
                                    icon: const Icon(Icons.remove, size: 14, color: Color(0xFF262220)),
                                    onPressed: () => state.removeFromCart(itemKey),
                                  ),
                                  Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  IconButton(
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(4),
                                    icon: const Icon(Icons.add, size: 14, color: Color(0xFF262220)),
                                    onPressed: () => state.addToCart(itemKey, rName),
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
                      backgroundColor: const Color(0xFF262220),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      _openCheckout(context, selectedList, totalAmount);
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
      },
    );
  }

  void _openCheckout(BuildContext context, List<Map<String, dynamic>> items, int subtotal) {
    final state = AppState.instance;
    const delivery = 20;
    final grandTotal = subtotal + delivery;

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
                state.isHindi ? "अंतिम बिल विवरण (Cravio Bill)" : "Order Bill Summary",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220)),
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
                  const Text("₹$delivery"),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.isHindi ? "कुल भुगतान (कैश ऑन डिलीवरी)" : "Total Due (COD)", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text("₹$grandTotal", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFC5A059))),
                ],
              ),
              const Divider(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.isHindi ? "डिलीवरी का पता:" : "Delivering To:",
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFC5A059)),
                    ),
                    Text(
                      state.fullAddress,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF262220)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF262220),
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
                        backgroundColor: const Color(0xFF262220),
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
          appBar: AppBar(
            title: Text(state.isHindi ? "मेरे ऑर्डर (Live Tracking)" : "My Orders"),
            backgroundColor: const Color(0xFF262220),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: state.orders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.receipt_long_outlined, size: 70, color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        state.isHindi ? "अभी कोई सक्रिय ऑर्डर नहीं है।" : "No active orders yet.",
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
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(o["id"], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.green.shade300),
                                  ),
                                  child: Text(
                                    o["status"],
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(o["res"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                            const Divider(height: 16),
                            ...((o["items"] as List).map((i) => Text("• ${i['title']} x ${i['qty']}", style: const TextStyle(fontSize: 13)))),
                            const Divider(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.isHindi ? "कुल बिल (कैश ऑन डिलीवरी)" : "Total Bill (COD)", style: const TextStyle(color: Colors.grey)),
                                Text("₹${o['total']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFC5A059))),
                              ],
                            ),
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

// ---------------- 4. CUSTOMER PROFILE VIEW ----------------
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
          appBar: AppBar(
            title: Text(state.isHindi ? "मेरी प्रोफ़ाइल" : "My Profile"),
            backgroundColor: const Color(0xFF262220),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFF262220),
                    child: Icon(Icons.person, color: Color(0xFFC5A059), size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.userName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                        Text(state.userPhone, style: const TextStyle(color: Colors.grey)),
                        Text(state.fullAddress, style: TextStyle(color: Colors.grey.shade600, fontSize: 11), maxLines: 2),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 36),
              ListTile(
                leading: const Icon(Icons.location_on_outlined, color: Color(0xFF262220)),
                title: Text(state.isHindi ? "डिलीवरी पता बदलें" : "Edit Address"),
                subtitle: Text(state.fullAddress),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  // Direct address edit
                },
              ),
              ListTile(
                leading: const Icon(Icons.support_agent, color: Color(0xFF262220)),
                title: Text(state.isHindi ? "कस्टमर केयर सपोर्ट" : "Customer Support"),
                subtitle: const Text("गंजबासौदा हेल्पलाइन"),
              ),
              const ListTile(
                leading: Icon(Icons.verified_outlined, color: Color(0xFFC5A059)),
                title: Text("Cravio Platform"),
                subtitle: Text("Presented by Eevaan Ventures"),
              ),
            ],
          ),
        );
      },
    );
  }
}
