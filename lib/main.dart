import 'package:flutter/material.dart';

void main() {
  runApp(const CravioApp());
}

// ---------------- COMPLETE BILINGUAL DICTIONARY ----------------
final Map<String, String> hi = {
  "app_name": "C R A V I O",
  "powered_by": "POWERED BY EEVAAN VENTURES",
  "login_title": "Cravio अधिकृत पोर्टल लॉगिन",
  "enter_phone": "10 अंकों का मोबाइल नंबर दर्ज करें",
  "get_otp": "OTP प्राप्त करें ➔",
  "verify_otp": "OTP सत्यापित करें",
  "enter_otp_sub": "आपके मोबाइल पर भेजा गया 4 अंकों का OTP दर्ज करें:",
  "verify_btn": "सत्यापित करके लॉगिन करें ➔",
  "role_customer": "👤 ग्राहक पोर्टल (Customer)",
  "role_customer_sub": "गंजबासौदा में खाना ऑर्डर करने के लिए",
  "role_restaurant": "🏪 रेस्टोरेंट पार्टनर (Restaurant)",
  "role_restaurant_sub": "होटल मारवाड़ी, दा पिज़्ज़ा लवर (ऑर्डर तैयार करें)",
  "role_rider": "🛵 डिलीवरी पार्टनर (Delivery Boy)",
  "role_rider_sub": "खाना पिकअप व कस्टमर तक डिलीवरी करने के लिए",
  "role_admin": "🛡️ ईवान वेंचर्स एडमिन (Admin)",
  "role_admin_sub": "पूरे गंजबासौदा का कमीशन व कंट्रोल पैनल",
  "restaurants": "रेस्टोरेंट",
  "my_orders": "मेरे ऑर्डर",
  "profile": "मेरी प्रोफ़ाइल",
  "view_menu": "मेन्यू देखें और खाना चुनें ➔",
  "delivery_to": "वर्तमान डिलीवरी पता:",
  "switch_portal": "पोर्टल बदलें (Switch)",
  "change_lang": "Language (English करें)",
  "counter_assured": "सीधा काउंटर रेट पर घर बैठे",
  "banner_sub": "गंजबासौदा का मनपसंद खाना\nअब ऑनलाइन पेमेंट के साथ!",
  "logout": "लॉगआउट",
  "accept_order": "स्वीकार करें",
  "ready_order": "खाना तैयार है (Ready)",
  "picked_order": "पिकअप किया (Picked Up)",
  "deliver_order": "सफलतापूर्वक डिलीवर (Delivered)",
};

final Map<String, String> en = {
  "app_name": "C R A V I O",
  "powered_by": "POWERED BY EEVAAN VENTURES",
  "login_title": "Cravio Official Portal Login",
  "enter_phone": "Enter 10-Digit Mobile Number",
  "get_otp": "Get OTP ➔",
  "verify_otp": "Verify OTP",
  "enter_otp_sub": "Enter the 4-digit OTP sent to your phone:",
  "verify_btn": "Verify & Login ➔",
  "role_customer": "👤 Customer Portal",
  "role_customer_sub": "Order food in Ganj Basoda",
  "role_restaurant": "🏪 Restaurant Partner",
  "role_restaurant_sub": "Hotel Marwari, Da Pixza Lover (Prepare Orders)",
  "role_rider": "🛵 Delivery Partner (Rider)",
  "role_rider_sub": "Pickup and deliver food to doorstep",
  "role_admin": "🛡️ Eevaan Ventures Admin",
  "role_admin_sub": "Commission, dispatch & full business analytics",
  "restaurants": "Food",
  "my_orders": "Orders",
  "profile": "Profile",
  "view_menu": "View Menu & Order ➔",
  "delivery_to": "Delivering To:",
  "switch_portal": "Switch Portal",
  "change_lang": "भाषा (हिंदी करें)",
  "counter_assured": "AUTHENTIC COUNTER RATES",
  "banner_sub": "Ganj Basoda's Best Dining\nDirect Counter Menu Rates!",
  "logout": "Logout",
  "accept_order": "Accept Order",
  "ready_order": "Food Ready for Pickup",
  "picked_order": "Picked Up by Rider",
  "deliver_order": "Delivered to Customer",
};

// ---------------- APP CONTROLLER & STATE ----------------
class AppState extends ChangeNotifier {
  static final AppState instance = AppState();

  bool isHindi = true;
  bool isLoggedIn = false;
  String currentRole = 'Customer'; // 'Customer', 'Restaurant', 'Rider', 'Admin'
  String selectedRestaurant = "Hotel Marwari";
  String merchantUpiId = "9826012345@upi";

  // Active User Profile
  String userName = "राहुल शर्मा";
  String userPhone = "9826012345";
  String userArea = "नेहरू चौक";
  String userHouse = "मकान नं. 42, गली नं. 2";
  String userLandmark = "पुरानी गल्ला मंडी के पास, गंजबासौदा";
  String get fullAddress => "$userHouse, $userArea ($userLandmark)";

  String tr(String key) {
    final dict = isHindi ? hi : en;
    return dict[key] ?? key;
  }

  void toggleLang(bool hindi) {
    isHindi = hindi;
    notifyListeners();
  }

  void login({required String phone, required String role, String res = "Hotel Marwari"}) {
    userPhone = phone;
    currentRole = role;
    selectedRestaurant = res;
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }

  // Live Restaurants & Menus
  List<Map<String, dynamic>> restaurants = [
    {
      "name": "Hotel Marwari",
      "hindiName": "होटल मारवाड़ी",
      "image": "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&q=80",
      "area": "नेहरू चौक, गंजबासौदा",
      "tag": "शुद्ध शाकाहारी थाली, दाल बाटी व मिठाई",
      "rating": "4.8",
      "reviews": "1,240+",
      "time": "20-25 min",
      "offer": "FLAT ₹30 OFF",
      "upiId": "marwari.basoda@upi",
      "menu": [
        {"id": "m1", "name": "मारवाड़ी स्पेशल थाली", "price": 180, "isAvailable": true, "desc": "दाल तड़का, शाही पनीर, सूखी सब्जी, 4 बटर रोटी, चावल, रायता व मीठा"},
        {"id": "m2", "name": "दाल बाटी चूरमा थाली", "price": 150, "isAvailable": true, "desc": "4 देशी घी बाटी, स्वादिष्ट दाल, स्पेशल चूरमा और चटनी"},
        {"id": "m3", "name": "पनीर बटर मसाला", "price": 160, "isAvailable": true, "desc": "ताजा मलाईदार पनीर रिच टमॅटो बटर ग्रेवी में"},
      ]
    },
    {
      "name": "Da Pixza Lover",
      "hindiName": "दा पिज़्ज़ा लवर",
      "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&q=80",
      "area": "स्टेशन रोड, गंजबासौदा",
      "tag": "चीज़ी पिज़्ज़ा, बर्गर, शेक्स और फ्राइज़",
      "rating": "4.7",
      "reviews": "890+",
      "time": "15-20 min",
      "offer": "20% OFF",
      "upiId": "pixzalover@upi",
      "menu": [
        {"id": "p1", "name": "फार्महाउस चीज़ी पिज़्ज़ा (7 Inch)", "price": 199, "isAvailable": true, "desc": "शिमला मिर्च, प्याज, स्वीट कॉर्न और डबल मोज़ेरेला चीज़"},
        {"id": "p2", "name": "क्रंची वेज चीज़ बर्गर", "price": 79, "isAvailable": true, "desc": "क्रिस्पी वेज टिक्की, चीज़ स्लाइस व प्रीमियम सॉस"},
      ]
    },
    {
      "name": "The Pride Restaurant",
      "hindiName": "द प्राइड रेस्टोरेंट",
      "image": "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=600&q=80",
      "area": "बरेथ रोड, गंजबासौदा",
      "tag": "नॉर्थ इंडियन, चाइनीज़ व दम बिरयानी",
      "rating": "4.6",
      "reviews": "620+",
      "time": "25-30 min",
      "offer": "FREE DELIVERY",
      "upiId": "thepride@upi",
      "menu": [
        {"id": "pr1", "name": "पनीर टिक्का मसाला", "price": 210, "isAvailable": true, "desc": "तंदूर रोस्टेड पनीर क्यूब्स तीखी गाढ़ी ग्रेवी में"},
        {"id": "pr2", "name": "शाही वेज दम बिरयानी", "price": 170, "isAvailable": true, "desc": "बासमती चावल, दम कुक्ड वेजीस, बूंदी रायता के साथ"},
      ]
    },
    {
      "name": "Sweets Ganga",
      "hindiName": "स्वीट्स गंगा",
      "image": "https://images.unsplash.com/photo-1505253758473-96b3015f27eb?w=600&q=80",
      "area": "नेहरू चौक, गंजबासौदा",
      "tag": "समोसा, कचौरी व देशी घी की जलेबी",
      "rating": "4.9",
      "reviews": "1,850+",
      "time": "15 min",
      "offer": "TOP SELLER",
      "upiId": "gangasweets@upi",
      "menu": [
        {"id": "s1", "name": "गरमा-गरम समोसा (2 पीस)", "price": 30, "isAvailable": true, "desc": "मसालेदार आलू समोसा, हरी व मीठी चटनी के साथ"},
        {"id": "s2", "name": "देशी घी की जलेबी (250g)", "price": 80, "isAvailable": true, "desc": "कुरकुरी और रसीली शुद्ध देशी घी में तली जलेबी"},
      ]
    }
  ];

  Map<String, int> cart = {};
  String activeRestaurant = "";
  List<Map<String, dynamic>> orders = [];

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
      "prepTime": "रेस्टोरेंट से स्वीकृति प्रतीक्षित",
      "riderAssigned": "अमित सिंह (Rider)",
    });
    cart.clear();
    activeRestaurant = "";
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String status, {String? prepTime}) {
    for (var o in orders) {
      if (o["id"] == orderId) {
        o["status"] = status;
        if (prepTime != null) o["prepTime"] = prepTime;
        notifyListeners();
        return;
      }
    }
  }

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
}

// ---------------- APP ROOT ----------------
class CravioApp extends StatelessWidget {
  const CravioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;

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
          home: state.isLoggedIn ? const MasterPortalRouter() : const LoginOtpScreen(),
        );
      },
    );
  }
}

// ---------------- 1. LOGIN & OTP SCREEN (3-IN-1 PORTAL) ----------------
class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({super.key});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  final _phoneCtrl = TextEditingController(text: "9826012345");
  String _selectedRole = "Customer"; // 'Customer', 'Restaurant', 'Rider', 'Admin'
  String _selectedRes = "Hotel Marwari";

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF262220),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Header Logo
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.5)),
                  ),
                  child: Text(
                    state.tr("app_name"),
                    style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, fontSize: 26, letterSpacing: 4),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  state.tr("powered_by"),
                  style: const TextStyle(color: Colors.white60, fontSize: 9, letterSpacing: 1.5, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 28),

                // Card Container
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.tr("login_title"), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixText: "+91  ",
                          prefixStyle: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF262220)),
                          labelText: state.tr("enter_phone"),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 18),

                      Text(state.isHindi ? "पोर्टल का प्रकार चुनें:" : "Select Portal Role:", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                      const SizedBox(height: 8),

                      _roleCard("Customer", state.tr("role_customer"), state.tr("role_customer_sub")),
                      _roleCard("Restaurant", state.tr("role_restaurant"), state.tr("role_restaurant_sub")),
                      if (_selectedRole == "Restaurant") ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                          child: DropdownButton<String>(
                            value: _selectedRes,
                            isExpanded: true,
                            underline: const SizedBox(),
                            onChanged: (val) => setState(() => _selectedRes = val!),
                            items: const [
                              DropdownMenuItem(value: "Hotel Marwari", child: Text("होटल मारवाड़ी")),
                              DropdownMenuItem(value: "Da Pixza Lover", child: Text("दा पिज़्ज़ा लवर")),
                              DropdownMenuItem(value: "The Pride Restaurant", child: Text("द प्राइड रेस्टोरेंट")),
                              DropdownMenuItem(value: "Sweets Ganga", child: Text("स्वीट्स गंगा")),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                      _roleCard("Rider", state.tr("role_rider"), state.tr("role_rider_sub")),
                      _roleCard("Admin", state.tr("role_admin"), state.tr("role_admin_sub")),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            if (_phoneCtrl.text.trim().length >= 10) {
                              _showOtpDialog(context, _phoneCtrl.text.trim(), _selectedRole, _selectedRes);
                            }
                          },
                          child: Text(state.tr("get_otp"), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleCard(String key, String title, String sub) {
    final sel = _selectedRole == key;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: sel ? const Color(0xFFC5A059).withOpacity(0.12) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: sel ? const Color(0xFFC5A059) : Colors.grey.shade300, width: sel ? 1.5 : 1),
      ),
      child: ListTile(
        dense: true,
        onTap: () => setState(() => _selectedRole = key),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: sel ? const Color(0xFF262220) : Colors.black87)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        trailing: Icon(sel ? Icons.radio_button_checked : Icons.radio_button_off, color: sel ? const Color(0xFFC5A059) : Colors.grey, size: 18),
      ),
    );
  }

  void _showOtpDialog(BuildContext context, String phone, String role, String res) {
    final otpCtrl = TextEditingController(text: "1234");
    final state = AppState.instance;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(state.tr("verify_otp")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${state.tr("enter_otp_sub")} +91 $phone"),
              const SizedBox(height: 12),
              TextField(
                controller: otpCtrl,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 8),
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "1234"),
              ),
              const SizedBox(height: 6),
              const Text("डेमो OTP: 1234", style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("रद्द करें")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220)),
              onPressed: () {
                Navigator.pop(ctx);
                state.login(phone: phone, role: role, res: res);
              },
              child: Text(state.tr("verify_btn"), style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

// ---------------- 2. MASTER PORTAL ROUTER ----------------
class MasterPortalRouter extends StatelessWidget {
  const MasterPortalRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    if (state.currentRole == 'Restaurant') return const RestaurantPartnerScreen();
    if (state.currentRole == 'Rider') return const DeliveryRiderScreen();
    if (state.currentRole == 'Admin') return const EevaanAdminScreen();

    return const CustomerPortalView();
  }
}

// ---------------- 3. CUSTOMER PORTAL VIEW ----------------
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF262220),
        unselectedItemColor: Colors.grey.shade400,
        onTap: (i) => setState(() => _tab = i),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.storefront_outlined), activeIcon: const Icon(Icons.storefront), label: state.tr("restaurants")),
          BottomNavigationBarItem(icon: const Icon(Icons.receipt_long_outlined), activeIcon: const Icon(Icons.receipt_long), label: state.tr("my_orders")),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), activeIcon: const Icon(Icons.person), label: state.tr("profile")),
        ],
      ),
    );
  }
}

// ---------------- 4. CUSTOMER HOME SCREEN ----------------
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
        toolbarHeight: 90,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.4))),
                  child: Text(state.tr("app_name"), style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 3)),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.verified, color: Color(0xFFC5A059), size: 16),
              ],
            ),
            const SizedBox(height: 4),
            Text(state.tr("powered_by"), style: const TextStyle(color: Colors.white60, fontSize: 9, letterSpacing: 1.5, fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          // Instant Language Toggle
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.5))),
              child: Row(
                children: [
                  _langPill("हि", state.isHindi, () => state.toggleLang(true)),
                  _langPill("EN", !state.isHindi, () => state.toggleLang(false)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Role Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFFC5A059).withOpacity(0.12), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.4))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_pin, size: 16, color: Color(0xFF262220)),
                    const SizedBox(width: 6),
                    Text(state.isHindi ? "मोड: ग्राहक पोर्टल (Customer)" : "Mode: Customer Portal", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF262220))),
                  ],
                ),
                InkWell(
                  onTap: () => state.logout(),
                  child: Text(state.tr("switch_portal") + " ➔", style: const TextStyle(color: Color(0xFF262220), fontWeight: FontWeight.bold, fontSize: 12)),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Address Strip
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
                      Text(state.tr("delivery_to"), style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                      Text(state.fullAddress, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF262220)), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

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
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFC5A059), borderRadius: BorderRadius.circular(4)), child: Text(state.tr("counter_assured"), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 8),
                      Text(state.tr("banner_sub"), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.3)),
                    ],
                  ),
                ),
                ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network("https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200&q=80", height: 75, width: 75, fit: BoxFit.cover)),
              ],
            ),
          ),
          const SizedBox(height: 22),

          Text(state.isHindi ? "गंजबासौदा के प्रमुख रेस्टोरेंट्स" : "Popular Restaurants in Ganj Basoda", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
          const SizedBox(height: 14),

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
                    Image.network(res["image"], height: 155, width: double.infinity, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.isHindi ? res["hindiName"] : res["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                              Text("★ ${res["rating"]}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 13, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(res["area"], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          Text(res["tag"], style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.w600)),
                          const Divider(height: 22),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerMenuDetailScreen(restaurant: res)));
                              },
                              child: Text(state.tr("view_menu"), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
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
}

// ---------------- 5. CUSTOMER MENU & PAYMENT SCREEN ----------------
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
            if (item["name"] == itemName) {
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
            title: Text(state.isHindi ? res["hindiName"] : res["name"]),
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
                        Text(item["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF262220))),
                        const SizedBox(height: 4),
                        Text("₹$itemPrice", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFC5A059))),
                        const SizedBox(height: 4),
                        Text(item["desc"] ?? "", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
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
                    onPressed: () => _openCheckoutSheet(context, selectedList, totalAmount, res["upiId"] ?? state.merchantUpiId),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 10), child: Text("$totalCount सामान | ₹$totalAmount", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
                        Padding(padding: const EdgeInsets.only(right: 10), child: const Text("पेमेंट व ऑर्डर ➔", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
                      ],
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  void _openCheckoutSheet(BuildContext context, List<Map<String, dynamic>> items, int subtotal, String targetUpi) {
    final state = AppState.instance;
    const delivery = 20;
    final grandTotal = subtotal + delivery;
    String selectedPayment = "PhonePe";
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
                    Text("अंतिम बिल व पेमेंट (Payment Checkout)", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
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
                            Center(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(qrApiUrl, height: 160, width: 160, fit: BoxFit.contain))),
                            const SizedBox(height: 6),
                            Text("UPI ID: $targetUpi | राशि: ₹$grandTotal", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    Text("पेमेंट का विकल्प चुनें:", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                    const SizedBox(height: 8),

                    _tile("PhonePe UPI (फ़ोनपे)", "Instant PhonePe Payment", Icons.account_balance_wallet, const Color(0xFF5F259F), selectedPayment == "PhonePe", () => setSheetState(() => selectedPayment = "PhonePe")),
                    _tile("डायनेमिक UPI बारकोड (QR Scan)", "QR कोड स्कैन करके पे करें", Icons.qr_code, const Color(0xFFC5A059), selectedPayment == "DynamicQR", () => setSheetState(() => selectedPayment = "DynamicQR")),
                    _tile("Cash on Delivery (कैश)", "डिलीवरी मिलने पर नकद दें", Icons.money, Colors.green.shade800, selectedPayment == "Cash on Delivery", () => setSheetState(() => selectedPayment = "Cash on Delivery")),

                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          state.placeOrder(items, grandTotal, selectedPayment);
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎉 ऑर्डर सफलतापूर्वक दर्ज हुआ!"), backgroundColor: Color(0xFF262220)));
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

  Widget _tile(String title, String sub, IconData icon, Color color, bool sel, VoidCallback tap) {
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

// ---------------- 6. CUSTOMER ORDERS SCREEN ----------------
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
          appBar: AppBar(title: Text(state.tr("my_orders")), backgroundColor: const Color(0xFF262220), foregroundColor: Colors.white, elevation: 0),
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
                            Text("डिलीवरी राइडर: ${o["riderAssigned"]}", style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
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

// ---------------- 7. CUSTOMER PROFILE SCREEN ----------------
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
            title: Text(state.tr("profile")),
            backgroundColor: const Color(0xFF262220),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              TextButton.icon(
                onPressed: () => state.logout(),
                icon: const Icon(Icons.logout, color: Color(0xFFC5A059), size: 16),
                label: Text(state.tr("logout"), style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
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
                    const Text("डिफ़ॉल्ट डिलीवरी पता (गंजबासौदा):", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF262220))),
                    const Divider(),
                    Text("📍 मोहल्ला: ${state.userArea}"),
                    Text("🏠 मकान: ${state.userHouse}"),
                    Text("🚩 लैंडमार्क: ${state.userLandmark}", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                leading: const Icon(Icons.swap_horiz, color: Color(0xFF262220)),
                title: Text(state.tr("switch_portal")),
                subtitle: const Text("रेस्टोरेंट, राइडर या एडमिन में लॉगिन करें"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => state.logout(),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------- 8. RESTAURANT PARTNER TERMINAL ----------------
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
                Text("UPI: ${resObj["upiId"]}", style: const TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
              ],
            ),
            actions: [
              IconButton(icon: const Icon(Icons.logout, color: Color(0xFFC5A059)), onPressed: () => state.logout()),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
                          Text("पता: ${o["address"]}"),
                          Text("पेमेंट: ${o["payment"]} | कुल: ₹${o["total"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Divider(),
                          Row(
                            children: [
                              const Text("तैयारी का समय चुनें:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              DropdownButton<int>(
                                value: _selectedMinutes,
                                items: const [
                                  DropdownMenuItem(value: 15, child: Text("15 मिनट")),
                                  DropdownMenuItem(value: 25, child: Text("25 मिनट")),
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
                                  onPressed: () => state.updateOrderStatus(o["id"], "खाना बन रहा है (Cooking)", prepTime: "$_selectedMinutes मिनट में तैयार होगा"),
                                  child: Text("स्वीकारें ($_selectedMinutes मिनट)", style: const TextStyle(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                                  onPressed: () => state.updateOrderStatus(o["id"], "तैयार है (Ready for Pickup)", prepTime: "डिलीवरी के लिए तैयार!"),
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
              // Menu Editor
              Text("मेन्यू व रेट प्रबंधन ($resName):", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
              const SizedBox(height: 10),
              ...menuList.map((dish) {
                final bool isAvail = dish["isAvailable"] ?? true;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(dish["name"], style: TextStyle(fontWeight: FontWeight.bold, decoration: isAvail ? null : TextDecoration.lineThrough)),
                    subtitle: Text("रेट: ₹${dish["price"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFFC5A059)),
                          onPressed: () => _editPrice(context, resName, dish["id"], dish["name"], dish["price"]),
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

  void _editPrice(BuildContext context, String resName, String dishId, String dishName, int currentPrice) {
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
              child: const Text("सेव करें", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

// ---------------- 9. DELIVERY RIDER TERMINAL (DELIVERY BOY APP) ----------------
class DeliveryRiderScreen extends StatelessWidget {
  const DeliveryRiderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;

        return Scaffold(
          backgroundColor: const Color(0xFFF9F8F6),
          appBar: AppBar(
            backgroundColor: const Color(0xFF262220),
            foregroundColor: Colors.white,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cravio राइडर टर्मिनल", style: TextStyle(fontSize: 16)),
                Text("डिलीवरी पार्टनर पोर्टल (Ganj Basoda)", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
              ],
            ),
            actions: [
              IconButton(icon: const Icon(Icons.logout, color: Color(0xFFC5A059)), onPressed: () => state.logout()),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Rider Stats Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF262220), borderRadius: BorderRadius.circular(14)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _riderStat("आज की डिलीवरी", "${state.orders.length} ऑर्डर्स"),
                    Container(height: 30, width: 1, color: Colors.white24),
                    _riderStat("राइडर कमाई (₹40/ऑर्डर)", "₹${state.orders.length * 40}"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text("असाइन की गई डिलीवरी टास्क:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
              const SizedBox(height: 10),

              if (state.orders.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Text("अभी कोई डिलीवरी असाइन नहीं है।")),
                )
              else
                ...state.orders.map((o) {
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
                              Text("ऑर्डर ID: ${o["id"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4)), child: Text(o["status"], style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 11))),
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.store, color: Color(0xFFC5A059), size: 20),
                              const SizedBox(width: 8),
                              Expanded(child: Text("पिकअप करें: ${o["res"]} (होटल से खाना उठाएं)", style: const TextStyle(fontWeight: FontWeight.bold))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.home, color: Colors.green, size: 20),
                              const SizedBox(width: 8),
                              Expanded(child: Text("डिलीवर करें: ${o["customerName"]} (${o["address"]})")),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.payments, color: Colors.teal, size: 20),
                              const SizedBox(width: 8),
                              Text("कस्टमर से नकद लें: ₹${o["total"]} (${o["payment"]})", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                                  onPressed: () => state.updateOrderStatus(o["id"], "राइडर रवाना (On the Way)"),
                                  child: const Text("पिकअप किया ➔", style: TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                                  onPressed: () => state.updateOrderStatus(o["id"], "सफलतापूर्वक डिलीवर (Delivered)"),
                                  child: const Text("डिलीवर किया ✓", style: TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ),
                            ],
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

  Widget _riderStat(String title, String val) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        const SizedBox(height: 4),
        Text(val, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// ---------------- 10. EEVAAN VENTURES ADMIN SCREEN ----------------
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
              IconButton(icon: const Icon(Icons.logout, color: Color(0xFFC5A059)), onPressed: () => state.logout()),
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
              const Text("गंजबासौदा लाइव ऑर्डर डिस्पैच:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
              const SizedBox(height: 10),
              if (state.orders.isEmpty) const Text("अभी कोई सक्रिय ऑर्डर नहीं है।"),
              ...state.orders.map((o) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text("${o["res"]} ➔ ${o["customerName"]} (₹${o["total"]})"),
                    subtitle: Text("ID: ${o["id"]} | ${o["payment"]} | ${o["status"]}"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (st) => state.updateOrderStatus(o["id"], st),
                      itemBuilder: (ctx) => const [
                        PopupMenuItem(value: "सफलतापूर्वक डिलीवर (Delivered)", child: Text("डिलीवर मार्क करें")),
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
