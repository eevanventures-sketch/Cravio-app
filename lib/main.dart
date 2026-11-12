import 'package:flutter/material.dart';

void main() {
  runApp(const CravioApp());
}

// ---------------- STRICT BILINGUAL DICTIONARY ----------------
final Map<String, String> hi = {
  "app_name": "C R A V I O",
  "powered_by": "ईवान वेंचर्स द्वारा संचालित",
  "select_city": "शहर चुनें:",
  "city_basoda": "गंजबासौदा",
  "city_vidisha": "विदिशा",
  "city_bhopal": "भोपाल",
  "role_customer": "👤 ग्राहक",
  "role_hotel": "🏪 होटल",
  "role_rider": "🛵 राइडर",
  "role_admin": "🛡️ एडमिन",
  "delivering_to": "डिलीवरी का पता (बदलने के लिए टैप करें):",
  "counter_rates": "काउंटर रेट की गारंटी",
  "banner_heading": "मनपसंद भोजन सीधा काउंटर रेट पर घर बैठे मंगाएं!",
  "popular_restaurants": "के प्रसिद्ध रेस्टोरेंट्स",
  "view_menu": "मेन्यू देखें और ऑर्डर करें ➔",
  "distance": "दूरी",
  "mins": "मिनट",
  "cart_summary": "अंतिम बिल व पेमेंट",
  "delivery_fee": "लोकल डिलीवरी शुल्क",
  "grand_total": "कुल देय राशि",
  "choose_payment": "पेमेंट का विकल्प चुनें:",
  "pay_phonepe": "PhonePe UPI (फ़ोनपे ऐप)",
  "pay_qr": "डायनेमिक UPI बारकोड (QR कोड स्कैन करें)",
  "pay_cod": "कैश ऑन डिलीवरी (घर पर नकद भुगतान)",
  "confirm_order": "ऑर्डर कन्फर्म करें",
  "my_orders": "मेरे ऑर्डर (लाइव ट्रैकिंग)",
  "no_orders": "अभी कोई सक्रिय ऑर्डर नहीं है।",
  "prep_time": "रेस्टोरेंट टाइमिंग:",
  "rider_assigned": "डिलीवरी राइडर:",
  "total_bill": "कुल बिल:",
  "profile_title": "मेरी प्रोफ़ाइल एवं सेटिंग्स",
  "default_address": "डिफ़ॉल्ट डिलीवरी पता:",
  "edit_address": "पता बदलें",
  "save": "सेव करें",
  "cancel": "रद्द करें",
  "hotel_terminal": "होटल पार्टनर टर्मिनल",
  "incoming_orders": "आए हुए ऑर्डर्स",
  "select_prep_time": "तैयारी का समय चुनें:",
  "accept": "स्वीकार करें",
  "ready": "खाना तैयार है (Ready)",
  "menu_management": "मेन्यू व रेट प्रबंधन:",
  "add_dish": "+ नई डिश जोड़ें",
  "rate": "रेट: ₹",
  "out_of_stock": "आज समाप्त है",
  "rider_terminal": "Cravio राइडर टर्मिनल (डिलीवरी पार्टनर)",
  "today_deliveries": "आज की डिलीवरी",
  "rider_earnings": "राइडर की कमाई (₹40/ऑर्डर)",
  "assigned_tasks": "असाइन की गई डिलीवरी टास्क:",
  "pickup_from": "पिकअप करें (होटल से):",
  "deliver_to": "डिलीवर करें (ग्राहक को):",
  "collect_cash": "कस्टमर से नकद लें:",
  "picked_up": "पिकअप किया ➔",
  "delivered": "डिलीवर किया ✓",
  "admin_title": "ईवान वेंचर्स - सुपर एडमिन कंट्रोल",
  "total_orders": "कुल ऑर्डर्स",
  "gross_sales": "कुल बिक्री",
  "net_commission": "ईवान वेंचर्स कमीशन (10%)",
  "live_dispatch": "लाइव ऑर्डर व डिलीवरी मॉनिटर:",
  "mark_delivered": "डिलीवर मार्क करें",
};

final Map<String, String> en = {
  "app_name": "C R A V I O",
  "powered_by": "POWERED BY EEVAAN VENTURES",
  "select_city": "Select City:",
  "city_basoda": "Ganj Basoda",
  "city_vidisha": "Vidisha",
  "city_bhopal": "Bhopal",
  "role_customer": "👤 Customer",
  "role_hotel": "🏪 Hotel",
  "role_rider": "🛵 Rider",
  "role_admin": "🛡️ Admin",
  "delivering_to": "Delivery Address (Tap to change):",
  "counter_rates": "COUNTER RATES ASSURED",
  "banner_heading": "Dine-in Menu Rates Delivered Directly to Doorstep!",
  "popular_restaurants": "Popular Restaurants in",
  "view_menu": "View Menu & Order ➔",
  "distance": "Distance",
  "mins": "mins",
  "cart_summary": "Order Bill & Payment",
  "delivery_fee": "Local Delivery Charge",
  "grand_total": "Total Amount",
  "choose_payment": "Choose Payment Method:",
  "pay_phonepe": "PhonePe UPI (Instant Pay)",
  "pay_qr": "Dynamic UPI Barcode (Scan QR)",
  "pay_cod": "Cash on Delivery (Pay at Doorstep)",
  "confirm_order": "Confirm Order",
  "my_orders": "My Orders (Live Tracking)",
  "no_orders": "No active orders placed yet.",
  "prep_time": "Kitchen Prep Time:",
  "rider_assigned": "Delivery Rider:",
  "total_bill": "Total Bill:",
  "profile_title": "My Profile & Settings",
  "default_address": "Default Delivery Address:",
  "edit_address": "Edit Address",
  "save": "Save",
  "cancel": "Cancel",
  "hotel_terminal": "Hotel Partner Terminal",
  "incoming_orders": "Incoming Orders",
  "select_prep_time": "Select Preparation Time:",
  "accept": "Accept Order",
  "ready": "Food Ready for Pickup",
  "menu_management": "Menu & Price Management:",
  "add_dish": "+ Add New Dish",
  "rate": "Price: ₹",
  "out_of_stock": "Out of Stock",
  "rider_terminal": "Cravio Rider Terminal (Delivery Partner)",
  "today_deliveries": "Today's Deliveries",
  "rider_earnings": "Rider Earnings (₹40/order)",
  "assigned_tasks": "Assigned Delivery Tasks:",
  "pickup_from": "Pickup From (Hotel):",
  "deliver_to": "Deliver To (Customer):",
  "collect_cash": "Collect Cash from Customer:",
  "picked_up": "Picked Up ➔",
  "delivered": "Mark Delivered ✓",
  "admin_title": "Eevaan Ventures - Super Admin Control",
  "total_orders": "Total Orders",
  "gross_sales": "Gross Sales",
  "net_commission": "Eevaan Commission (10%)",
  "live_dispatch": "Live Orders & Delivery Dispatch:",
  "mark_delivered": "Mark Delivered",
};

// ---------------- APP STATE & STORE ----------------
class AppState extends ChangeNotifier {
  static final AppState instance = AppState();

  bool isHindi = true;
  String selectedCity = "Ganj Basoda"; // 'Ganj Basoda', 'Vidisha', 'Bhopal'
  String currentRole = 'Customer'; // 'Customer', 'Restaurant', 'Rider', 'Admin'
  String selectedRestaurant = "Hotel Marwari";
  String merchantUpiId = "9826012345@upi";

  // Customer Profile
  String userName = "राहुल शर्मा";
  String userPhone = "9826012345";
  String userArea = "नेहरू चौक";
  String userHouse = "मकान नं. 42, गली नं. 2";
  String userLandmark = "पुरानी गल्ला मंडी के पास";

  String get fullAddress => "$userHouse, $userArea, $selectedCity ($userLandmark)";

  String tr(String key) {
    final dict = isHindi ? hi : en;
    return dict[key] ?? key;
  }

  void toggleLang(bool hindi) {
    isHindi = hindi;
    notifyListeners();
  }

  void setCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void switchRole(String role, {String res = "Hotel Marwari"}) {
    currentRole = role;
    selectedRestaurant = res;
    notifyListeners();
  }

  // Multi-City Restaurants Database (Ganj Basoda, Vidisha, Bhopal)
  List<Map<String, dynamic>> allRestaurants = [
    // --- GANJ BASODA ---
    {
      "city": "Ganj Basoda",
      "name": "Hotel Marwari",
      "hindiName": "होटल मारवाड़ी",
      "image": "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&q=80",
      "area": "Nehru Chowk, Ganj Basoda",
      "hindiArea": "नेहरू चौक, गंजबासौदा",
      "tag": "Pure Veg Thali, Dal Baati & Sweets",
      "hindiTag": "शुद्ध शाकाहारी थाली, दाल बाटी व मिठाई",
      "rating": "4.8",
      "distance": "1.2 km",
      "time": "20-25 min",
      "upiId": "marwari.basoda@upi",
      "menu": [
        {"id": "b1", "name": "Marwari Special Thali", "hindiName": "मारवाड़ी स्पेशल थाली", "price": 180, "isAvailable": true, "desc": "Dal Tadka, Shahi Paneer, Sabji, 4 Roti, Rice, Raita & Sweet", "hindiDesc": "दाल तड़का, शाही पनीर, सब्जी, 4 रोटी, चावल, रायता व मीठा"},
        {"id": "b2", "name": "Dal Baati Churma Thali", "hindiName": "दाल बाटी चूरमा थाली", "price": 150, "isAvailable": true, "desc": "4 Desi Ghee Baati, Dal, Churma & Chutney", "hindiDesc": "4 देशी घी बाटी, स्वादिष्ट दाल, स्पेशल चूरमा और चटनी"},
        {"id": "b3", "name": "Paneer Butter Masala", "hindiName": "पनीर बटर मसाला", "price": 160, "isAvailable": true, "desc": "Cottage cheese in rich butter tomato gravy", "hindiDesc": "रिच बटर ग्रेवी में ताजा पनीर"},
      ]
    },
    {
      "city": "Ganj Basoda",
      "name": "Da Pixza Lover",
      "hindiName": "दा पिज़्ज़ा लवर",
      "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&q=80",
      "area": "Station Road, Ganj Basoda",
      "hindiArea": "स्टेशन रोड, गंजबासौदा",
      "tag": "Cheesy Pizza, Burgers & Shakes",
      "hindiTag": "चीज़ी पिज़्ज़ा, बर्गर, शेक्स और फ्राइज़",
      "rating": "4.7",
      "distance": "1.8 km",
      "time": "15-20 min",
      "upiId": "pixzalover@upi",
      "menu": [
        {"id": "bp1", "name": "Farmhouse Cheesy Pizza (7 Inch)", "hindiName": "फार्महाउस चीज़ी पिज़्ज़ा (7 Inch)", "price": 199, "isAvailable": true, "desc": "Capsicum, Onion, Sweet Corn, Double Cheese", "hindiDesc": "शिमला मिर्च, प्याज, कॉर्न, डबल चीज़"},
        {"id": "bp2", "name": "Crunchy Veg Cheese Burger", "hindiName": "क्रंची वेज चीज़ बर्गर", "price": 79, "isAvailable": true, "desc": "Crispy Veg Patty with Cheese Slice", "hindiDesc": "क्रिस्पी वेज टिक्की व चीज़ स्लाइस"},
      ]
    },
    {
      "city": "Ganj Basoda",
      "name": "Sweets Ganga",
      "hindiName": "स्वीट्स गंगा",
      "image": "https://images.unsplash.com/photo-1505253758473-96b3015f27eb?w=600&q=80",
      "area": "Nehru Chowk, Ganj Basoda",
      "hindiArea": "नेहरू चौक, गंजबासौदा",
      "tag": "Desi Ghee Jalebi, Samosa & Sweets",
      "hindiTag": "देशी घी की जलेबी, समोसा व मिठाइयाँ",
      "rating": "4.9",
      "distance": "0.9 km",
      "time": "15 min",
      "upiId": "gangasweets@upi",
      "menu": [
        {"id": "bs1", "name": "Hot Samosa (2 Pcs)", "hindiName": "गरमा-गरम समोसा (2 पीस)", "price": 30, "isAvailable": true, "desc": "Crispy spiced potato samosas with chutney", "hindiDesc": "आलू-मटर मसाला व चटनी"},
        {"id": "bs2", "name": "Desi Ghee Jalebi (250g)", "hindiName": "देशी घी की जलेबी (250g)", "price": 80, "isAvailable": true, "desc": "Fresh hot crispy jalebi", "hindiDesc": "शुद्ध देशी घी में बनी कुरकुरी जलेबी"},
      ]
    },

    // --- VIDISHA (विदिशा) ---
    {
      "city": "Vidisha",
      "name": "Hotel Shree Radhey",
      "hindiName": "होटल श्री राधे",
      "image": "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=600&q=80",
      "area": "Station Road, Vidisha",
      "hindiArea": "स्टेशन रोड, विदिशा",
      "tag": "North Indian Deluxe Meals & Thali",
      "hindiTag": "डीलक्स थाली, भोजन एवं नाश्ता",
      "rating": "4.7",
      "distance": "2.1 km",
      "time": "20-25 min",
      "upiId": "shreeradhey@upi",
      "menu": [
        {"id": "v1", "name": "Shree Radhey Deluxe Thali", "hindiName": "श्री राधे डीलक्स थाली", "price": 200, "isAvailable": true, "desc": "Paneer, Dal Fry, Seasonal Sabji, 4 Roti, Rice & Gulab Jamun", "hindiDesc": "शाही पनीर, दाल फ्राई, मौसमी सब्जी, 4 रोटी, चावल व गुलाब जामुन"},
        {"id": "v2", "name": "Kadhai Paneer Special", "hindiName": "कड़ाही पनीर स्पेशल", "price": 170, "isAvailable": true, "desc": "Spicy bell pepper and paneer gravy", "hindiDesc": "तीखी शिमला मिर्च व पनीर की स्वादिष्ट सब्जी"},
      ]
    },
    {
      "city": "Vidisha",
      "name": "Bapu Ki Kutiya (Vidisha)",
      "hindiName": "बापू की कुटिया (विदिशा)",
      "image": "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=600&q=80",
      "area": "Ahmadpur Road, Vidisha",
      "hindiArea": "अहमदपुर रोड, विदिशा",
      "tag": "Famous Dal Bafla & Pure Desi Meals",
      "hindiTag": "प्रसिद्ध दाल बाफला व शुद्ध देशी भोजन",
      "rating": "4.8",
      "distance": "2.8 km",
      "time": "25-30 min",
      "upiId": "bapuvidisha@upi",
      "menu": [
        {"id": "vb1", "name": "Special Dal Bafla Thali", "hindiName": "स्पेशल दाल बाफला थाली", "price": 180, "isAvailable": true, "desc": "Authentic MP Dal Bafla with Desi Ghee & Laddu", "hindiDesc": "देशी घी में डूबे बाफले, दाल, कढ़ी, चटनी और लड्डू"},
        {"id": "vb2", "name": "Sev Tamatar Ki Sabji", "hindiName": "सेव टमाटर की सब्जी", "price": 120, "isAvailable": true, "desc": "Authentic Malwa style sweet and tangy gravy", "hindiDesc": "पारंपरिक मालवा स्टाइल खट्टी-मीठी सेव टमाटर सब्जी"},
      ]
    },
    {
      "city": "Vidisha",
      "name": "Milan Sweets & Restaurant",
      "hindiName": "मिलन स्वीट्स एंड रेस्टोरेंट",
      "image": "https://images.unsplash.com/photo-1599488615731-7e5c2823ff28?w=600&q=80",
      "area": "Main Market, Vidisha",
      "hindiArea": "मेन मार्केट, विदिशा",
      "tag": "Fresh Sweets, Snacks, Chole Bhature",
      "hindiTag": "ताज़ा मिठाइयाँ, छोले भटूरे एवं स्नैक्स",
      "rating": "4.6",
      "distance": "1.5 km",
      "time": "15-20 min",
      "upiId": "milansweets@upi",
      "menu": [
        {"id": "vm1", "name": "Special Chole Bhature", "hindiName": "स्पेशल छोले भटूरे (2 पीस)", "price": 90, "isAvailable": true, "desc": "Crispy bhature with spicy Punjabi chole", "hindiDesc": "कुरकुरे भटूरे मसालेदार पंजाबी छोले व सलाद के साथ"},
        {"id": "vm2", "name": "Kaju Katli (250g)", "hindiName": "काजू कतली (250 ग्राम)", "price": 240, "isAvailable": true, "desc": "Pure Cashew Sweets", "hindiDesc": "100% शुद्ध काजू की शाही मिठाई"},
      ]
    },

    // --- BHOPAL (भोपाल) ---
    {
      "city": "Bhopal",
      "name": "Manohar Dairy & Restaurant",
      "hindiName": "मनोहर डेयरी एंड रेस्टोरेंट",
      "image": "https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=600&q=80",
      "area": "New Market, Bhopal",
      "hindiArea": "न्यू मार्केट, भोपाल",
      "tag": "Iconic Dosa, Thali, Chole Bhature & Sweets",
      "hindiTag": "भोपाल का सबसे प्रसिद्ध भोजन, डोसा व मिठाइयाँ",
      "rating": "4.9",
      "distance": "3.5 km",
      "time": "25-30 min",
      "upiId": "manohardairy@upi",
      "menu": [
        {"id": "mno1", "name": "Manohar Executive Thali", "hindiName": "मनोहर एग्जीक्यूटिव थाली", "price": 260, "isAvailable": true, "desc": "2 Paneer dishes, Dal Makhani, 4 Butter Roti, Pulao & Sweet", "hindiDesc": "शाही पनीर, दाल मखनी, रायता, 4 बटर रोटी, पुलाव व रसमलाई"},
        {"id": "mno2", "name": "Special Masala Dosa", "hindiName": "स्पेशल मसाला डोसा", "price": 130, "isAvailable": true, "desc": "Crispy butter dosa with sambhar & coconut chutneys", "hindiDesc": "मक्खन लगा कुरकुरा डोसा, गरमा-गरम सांभर व नारियल चटनी"},
      ]
    },
    {
      "city": "Bhopal",
      "name": "Sagar Gaire Fast Food",
      "hindiName": "सागर गैरे फास्ट फूड",
      "image": "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600&q=80",
      "area": "10 No. Market, MP Nagar, Bhopal",
      "hindiArea": "10 नंबर मार्केट, एमपी नगर, भोपाल",
      "tag": "Legendary Cheese Pasta, Sandwiches, Burgers",
      "hindiTag": "भोपाल का मशहूर चीज़ पास्ता, सैंडविच व कोल्ड कॉफ़ी",
      "rating": "4.8",
      "distance": "2.4 km",
      "time": "20-25 min",
      "upiId": "sagargaire@upi",
      "menu": [
        {"id": "sg1", "name": "Loaded Cheese Red Sauce Pasta", "hindiName": "लोडेड चीज़ रेड सॉस पास्ता", "price": 140, "isAvailable": true, "desc": "Bhopal's most famous creamy spicy pasta", "hindiDesc": "मसालेदार रिच चीज़ी रेड सॉस पास्ता"},
        {"id": "sg2", "name": "Special Veg Cheese Sandwich", "hindiName": "स्पेशल वेज चीज़ ग्रिल्ड सैंडविच", "price": 95, "isAvailable": true, "desc": "Triple layer grilled sandwich with loaded cheese", "hindiDesc": "ट्रिपल लेयर ग्रिल्ड सैंडविच भरपूर चीज़ के साथ"},
      ]
    },
    {
      "city": "Bhopal",
      "name": "Bapu Ki Kutiya (MP Nagar)",
      "hindiName": "बापू की कुटिया (एमपी नगर)",
      "image": "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600&q=80",
      "area": "Zone 1, MP Nagar, Bhopal",
      "hindiArea": "ज़ोन 1, एमपी नगर, भोपाल",
      "tag": "Pure Vegetarian Family Dining & Biryani",
      "hindiTag": "शुद्ध शाकाहारी फैमिली रेस्टोरेंट व बिरयानी",
      "rating": "4.7",
      "distance": "3.1 km",
      "time": "25-30 min",
      "upiId": "bapubhopal@upi",
      "menu": [
        {"id": "bp1", "name": "Paneer Tikka Lababdar", "hindiName": "पनीर टिक्का लबाबदार", "price": 220, "isAvailable": true, "desc": "Roasted paneer cubes in thick creamy gravy", "hindiDesc": "तंदूरी पनीर क्यूब्स गाढ़ी मलाईदार ग्रेवी में"},
        {"id": "bp2", "name": "Shahi Veg Dum Biryani", "hindiName": "शाही वेज दम बिरयानी", "price": 180, "isAvailable": true, "desc": "Aromatic long grain basmati rice with raita", "hindiDesc": "बासमती चावल, दम कुक्ड वेजीस व बूंदी रायता"},
      ]
    },
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

  void placeOrder(List<Map<String, dynamic>> items, int total, String payment, String dist) {
    orders.insert(0, {
      "id": "CRV-${DateTime.now().millisecondsSinceEpoch % 10000}",
      "customerName": userName,
      "customerPhone": userPhone,
      "address": fullAddress,
      "city": selectedCity,
      "res": activeRestaurant,
      "distance": dist,
      "items": List.from(items),
      "total": total,
      "payment": payment,
      "status": isHindi ? "ऑर्डर प्राप्त हुआ (Order Received)" : "Order Received",
      "prepTime": isHindi ? "स्वीकृति प्रतीक्षित (30 मिनट)" : "Pending (30 mins)",
      "riderAssigned": "अमित सिंह (Rider)",
      "riderPhone": "9826099999",
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
    for (var r in allRestaurants) {
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
    for (var r in allRestaurants) {
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
    for (var r in allRestaurants) {
      if (r["name"] == resName) {
        (r["menu"] as List).add(dish);
        notifyListeners();
        return;
      }
    }
  }

  void updateCustomerAddress({required String name, required String phone, required String area, required String house, required String landmark}) {
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
          key: ValueKey("CravioRoot_${state.isHindi}_${state.selectedCity}_${state.currentRole}"),
          title: 'Cravio - Food Delivery',
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
          home: const MasterMainScreen(),
        );
      },
    );
  }
}

// ---------------- UNIVERSAL MASTER SCREEN (TOP 4-ROLE SWITCHER BAR) ----------------
class MasterMainScreen extends StatefulWidget {
  const MasterMainScreen({super.key});

  @override
  State<MasterMainScreen> createState() => _MasterMainScreenState();
}

class _MasterMainScreenState extends State<MasterMainScreen> {
  int _customerTab = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
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
                  child: Text(
                    state.tr("app_name"),
                    style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 3),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.verified, color: Color(0xFFC5A059), size: 16),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              state.tr("powered_by"),
              style: const TextStyle(color: Colors.white60, fontSize: 9, letterSpacing: 1.5, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          // Instant 0ms Language Switcher
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 14),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.6)),
              ),
              child: Row(
                children: [
                  _langPill("हि", state.isHindi, () => state.toggleLang(true)),
                  _langPill("EN", !state.isHindi, () => state.toggleLang(false)),
                ],
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: const Color(0xFF1E1A18),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                _roleTab("Customer", state.tr("role_customer")),
                _roleTab("Restaurant", state.tr("role_hotel")),
                _roleTab("Rider", state.tr("role_rider")),
                _roleTab("Admin", state.tr("role_admin")),
              ],
            ),
          ),
        ),
      ),
      body: _buildCurrentPortal(state),
      bottomNavigationBar: state.currentRole == 'Customer'
          ? BottomNavigationBar(
              currentIndex: _customerTab,
              backgroundColor: Colors.white,
              selectedItemColor: const Color(0xFF262220),
              unselectedItemColor: Colors.grey.shade400,
              onTap: (i) => setState(() => _customerTab = i),
              items: [
                BottomNavigationBarItem(icon: const Icon(Icons.storefront_outlined), activeIcon: const Icon(Icons.storefront), label: state.isHindi ? "रेस्टोरेंट" : "Food"),
                BottomNavigationBarItem(icon: const Icon(Icons.receipt_long_outlined), activeIcon: const Icon(Icons.receipt_long), label: state.isHindi ? "मेरे ऑर्डर" : "Orders"),
                BottomNavigationBarItem(icon: const Icon(Icons.person_outline), activeIcon: const Icon(Icons.person), label: state.isHindi ? "प्रोफ़ाइल" : "Profile"),
              ],
            )
          : null,
    );
  }

  Widget _buildCurrentPortal(AppState state) {
    switch (state.currentRole) {
      case 'Restaurant':
        return const RestaurantPartnerScreen();
      case 'Rider':
        return const DeliveryRiderScreen();
      case 'Admin':
        return const EevaanAdminScreen();
      default:
        final customerViews = [
          const CustomerHomeScreen(),
          const CustomerOrdersScreen(),
          const CustomerProfileScreen(),
        ];
        return customerViews[_customerTab];
    }
  }

  Widget _roleTab(String roleKey, String label) {
    final state = AppState.instance;
    final isSel = state.currentRole == roleKey;
    return Expanded(
      child: GestureDetector(
        onTap: () => state.switchRole(roleKey),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSel ? const Color(0xFFC5A059) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isSel ? const Color(0xFFC5A059) : Colors.white24),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSel ? Colors.black : Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  Widget _langPill(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFC5A059) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.black : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// ---------------- 1. CUSTOMER HOME SCREEN (WITH CITY SWITCHER & DISTANCE) ----------------
class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    final cityRestaurants = state.allRestaurants.where((r) => r["city"] == state.selectedCity).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // City Selector Bar
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.5)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6)],
          ),
          child: Row(
            children: [
              Text(
                state.tr("select_city"),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF262220)),
              ),
              const SizedBox(width: 8),
              _cityPill("Ganj Basoda", state.tr("city_basoda"), state),
              const SizedBox(width: 6),
              _cityPill("Vidisha", state.tr("city_vidisha"), state),
              const SizedBox(width: 6),
              _cityPill("Bhopal", state.tr("city_bhopal"), state),
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
                    Text(state.tr("delivering_to"), style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                    Text(state.fullAddress, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF262220)), overflow: TextOverflow.ellipsis),
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
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFC5A059), borderRadius: BorderRadius.circular(4)), child: Text(state.tr("counter_rates"), style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 8),
                    Text(state.tr("banner_heading"), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.3)),
                  ],
                ),
              ),
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network("https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200&q=80", height: 75, width: 75, fit: BoxFit.cover)),
            ],
          ),
        ),
        const SizedBox(height: 22),

        // Section Title with Selected City
        Text(
          "${state.selectedCity} ${state.tr("popular_restaurants")}",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF262220)),
        ),
        const SizedBox(height: 14),

        // Restaurants List
        ...cityRestaurants.map((res) {
          final title = state.isHindi ? res["hindiName"] : res["name"];
          final area = state.isHindi ? res["hindiArea"] : res["area"];
          final tag = state.isHindi ? res["hindiTag"] : res["tag"];

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
                      Image.network(res["image"], height: 155, width: double.infinity, fit: BoxFit.cover),
                      // Distance Badge
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xFF262220), borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFC5A059))),
                          child: Row(
                            children: [
                              const Icon(Icons.navigation, size: 10, color: Color(0xFFC5A059)),
                              const SizedBox(width: 4),
                              Text("${res["distance"]} ${state.tr("distance")}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      // ETA Delivery Time
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
                              Text(res["time"], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
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
                            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                            Text("★ ${res["rating"]}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(area, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                        Text(tag, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.w600)),
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
    );
  }

  Widget _cityPill(String cityKey, String label, AppState state) {
    final isSel = state.selectedCity == cityKey;
    return GestureDetector(
      onTap: () => state.setCity(cityKey),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSel ? const Color(0xFFC5A059) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSel ? Colors.black : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

// ---------------- 2. RESTAURANT MENU & PAYMENT SCREEN (WITH DISTANCE & LIVE QR) ----------------
class CustomerMenuDetailScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  const CustomerMenuDetailScreen({super.key, required this.restaurant});

  @override
  State<CustomerMenuDetailScreen> createState() => _CustomerMenuDetailScreenState();
}

class _CustomerMenuDetailScreenState extends State<CustomerMenuDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    final res = widget.restaurant;
    final List menuList = res["menu"];
    final String rName = res["name"];
    final title = state.isHindi ? res["hindiName"] : res["name"];
    final area = state.isHindi ? res["hindiArea"] : res["area"];

    int totalAmount = 0;
    int totalCount = 0;
    List<Map<String, dynamic>> selectedList = [];

    state.cart.forEach((itemName, qty) {
      for (var item in menuList) {
        if (item["name"] == itemName) {
          int price = (item["price"] as num).toInt();
          totalAmount += price * qty;
          totalCount += qty;
          selectedList.add({
            "title": state.isHindi ? item["hindiName"] : item["name"],
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
            Text(title, style: const TextStyle(fontSize: 16)),
            Text("$area | 📍 ${res["distance"]}", style: const TextStyle(fontSize: 11, color: Color(0xFFC5A059))),
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
          final dishTitle = state.isHindi ? item["hindiName"] : item["name"];
          final dishDesc = state.isHindi ? item["hindiDesc"] : item["desc"];

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dishTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF262220))),
                    const SizedBox(height: 4),
                    Text("₹$itemPrice", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFC5A059))),
                    const SizedBox(height: 4),
                    Text(dishDesc, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    if (!isAvail)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text("⚠ ${state.tr("out_of_stock")}", style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF262220))),
                child: !isAvail
                    ? Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), child: Text(state.tr("out_of_stock"), style: const TextStyle(color: Colors.grey, fontSize: 11)))
                    : qty == 0
                        ? InkWell(
                            onTap: () => setState(() => state.addToCart(itemKey, rName)),
                            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6), child: Text("+ ADD", style: TextStyle(color: Color(0xFF262220), fontWeight: FontWeight.bold, fontSize: 12))),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.all(4), icon: const Icon(Icons.remove, size: 14, color: Color(0xFF262220)), onPressed: () => setState(() => state.removeFromCart(itemKey))),
                              Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.all(4), icon: const Icon(Icons.add, size: 14, color: Color(0xFF262220)), onPressed: () => setState(() => state.addToCart(itemKey, rName))),
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
                onPressed: () => _openCheckoutSheet(context, selectedList, totalAmount, res["upiId"] ?? state.merchantUpiId, res["distance"]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: const EdgeInsets.only(left: 10), child: Text("$totalCount Items | ₹$totalAmount", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
                    Padding(padding: const EdgeInsets.only(right: 10), child: Text("${state.tr("confirm_order")} ➔", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  void _openCheckoutSheet(BuildContext context, List<Map<String, dynamic>> items, int subtotal, String targetUpi, String distance) {
    final state = AppState.instance;
    const delivery = 20;
    final grandTotal = subtotal + delivery;
    String selectedPayment = "PhonePe";
    final qrApiUrl = "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=upi://pay?pa=$targetUpi&pn=Cravio&am=$grandTotal&cu=INR";

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
                    Text(state.tr("cart_summary"), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                    const Divider(height: 18),
                    ...items.map((i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("${i['title']} x ${i['qty']}"), Text("₹${i['price'] * i['qty']}", style: const TextStyle(fontWeight: FontWeight.bold))]),
                        )),
                    const Divider(height: 16),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(state.tr("delivery_fee")), const Text("₹20")]),
                    const SizedBox(height: 6),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(state.tr("grand_total"), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), Text("₹$grandTotal", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Color(0xFFC5A059)))]),
                    const Divider(height: 20),

                    // Dynamic QR Display
                    if (selectedPayment == "DynamicQR") ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFC5A059))),
                        child: Column(
                          children: [
                            Text(state.isHindi ? "PhonePe / GPay से स्कैन करके पे करें:" : "Scan & Pay with any UPI app:", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF262220))),
                            const SizedBox(height: 8),
                            Center(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(qrApiUrl, height: 150, width: 150, fit: BoxFit.contain))),
                            const SizedBox(height: 6),
                            Text("UPI ID: $targetUpi | ₹$grandTotal", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    Text(state.tr("choose_payment"), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                    const SizedBox(height: 8),

                    _payTile(state.tr("pay_phonepe"), "Instant UPI", Icons.account_balance_wallet, const Color(0xFF5F259F), selectedPayment == "PhonePe", () => setSheetState(() => selectedPayment = "PhonePe")),
                    _payTile(state.tr("pay_qr"), "Scan Dynamic QR", Icons.qr_code, const Color(0xFFC5A059), selectedPayment == "DynamicQR", () => setSheetState(() => selectedPayment = "DynamicQR")),
                    _payTile(state.tr("pay_cod"), "Pay on Delivery", Icons.money, Colors.green.shade800, selectedPayment == "Cash on Delivery", () => setSheetState(() => selectedPayment = "Cash on Delivery")),

                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          state.placeOrder(items, grandTotal, selectedPayment, distance);
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.isHindi ? "🎉 ऑर्डर दर्ज हुआ! रेस्टोरेंट को सूचना भेजी गई।" : "🎉 Order Placed Successfully!"), backgroundColor: const Color(0xFF262220)));
                        },
                        child: Text("${state.tr("confirm_order")} (₹$grandTotal - $selectedPayment)", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
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

// ---------------- 3. CUSTOMER ORDERS SCREEN ----------------
class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(title: Text(state.tr("my_orders")), backgroundColor: const Color(0xFF262220), foregroundColor: Colors.white, elevation: 0),
      body: state.orders.isEmpty
          ? Center(child: Text(state.tr("no_orders")))
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
                        Text("${o["res"]} (${o["city"]})", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: const Color(0xFFC5A059).withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              const Icon(Icons.timer, size: 16, color: Color(0xFF262220)),
                              const SizedBox(width: 6),
                              Text("${state.tr("prep_time")} ${o["prepTime"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF262220))),
                            ],
                          ),
                        ),
                        Text("${state.tr("rider_assigned")} ${o["riderAssigned"]} (Ph: ${o["riderPhone"]})", style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
                        const Divider(height: 16),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(state.tr("total_bill")), Text("₹${o['total']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFC5A059)))]),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ---------------- 4. CUSTOMER PROFILE SCREEN ----------------
class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return ListView(
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
                child: Text(state.tr("edit_address"), style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
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
              Text(state.tr("default_address"), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF262220))),
              const Divider(),
              Text("📍 ${state.fullAddress}"),
            ],
          ),
        ),
      ],
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
                Text(state.isHindi ? "डिलीवरी पता अपडेट करें" : "Update Delivery Address", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF262220))),
                const Divider(),
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Full Name")),
                TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "Phone")),
                TextField(controller: areaCtrl, decoration: const InputDecoration(labelText: "Area / Colony")),
                TextField(controller: houseCtrl, decoration: const InputDecoration(labelText: "House / Shop No.")),
                TextField(controller: landmarkCtrl, decoration: const InputDecoration(labelText: "Landmark")),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220), padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () {
                      state.updateCustomerAddress(name: nameCtrl.text, phone: phoneCtrl.text, area: areaCtrl.text, house: houseCtrl.text, landmark: landmarkCtrl.text);
                      Navigator.pop(ctx);
                    },
                    child: Text(state.tr("save"), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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

// ---------------- 5. RESTAURANT PARTNER SCREEN (ORDER ACCEPT + TIME + LIVE MENU MANAGER) ----------------
class RestaurantPartnerScreen extends StatefulWidget {
  const RestaurantPartnerScreen({super.key});

  @override
  State<RestaurantPartnerScreen> createState() => _RestaurantPartnerScreenState();
}

class _RestaurantPartnerScreenState extends State<RestaurantPartnerScreen> {
  int _selectedMinutes = 30;

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    final resName = state.selectedRestaurant;
    final resObj = state.allRestaurants.firstWhere((r) => r["name"] == resName, orElse: () => state.allRestaurants.first);
    final resOrders = state.orders.where((o) => o["res"] == resName).toList();
    final menuList = resObj["menu"] as List;
    final title = state.isHindi ? resObj["hindiName"] : resObj["name"];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: const Color(0xFF262220), borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$title (${resObj["city"]})", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("UPI: ${resObj["upiId"]}", style: const TextStyle(fontSize: 11, color: Color(0xFFC5A059))),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                onPressed: () => _showAddDishModal(context, resName),
                child: Text(state.tr("add_dish"), style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Text("${state.tr("incoming_orders")} (${resOrders.length}):", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
        const SizedBox(height: 10),

        if (resOrders.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: const Center(child: Text("No incoming orders right now.")),
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
                        Text("Order ID: ${o["id"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(o["status"], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(),
                    Text("Customer: ${o["customerName"]} (${o["customerPhone"]})"),
                    Text("Address: ${o["address"]}"),
                    Text("Payment: ${o["payment"]} | Total: ₹${o["total"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Divider(),
                    Row(
                      children: [
                        Text(state.tr("select_prep_time"), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        DropdownButton<int>(
                          value: _selectedMinutes,
                          items: [15, 25, 30, 45].map((m) => DropdownMenuItem(value: m, child: Text("$m ${state.tr("mins")}"))).toList(),
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
                            onPressed: () => state.updateOrderStatus(o["id"], state.isHindi ? "खाना बन रहा है (Cooking)" : "Cooking", prepTime: "$_selectedMinutes ${state.tr("mins")}"),
                            child: Text("${state.tr("accept")} ($_selectedMinutes ${state.tr("mins")})", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                            onPressed: () => state.updateOrderStatus(o["id"], state.isHindi ? "तैयार है (Ready for Pickup)" : "Ready for Pickup", prepTime: "Ready!"),
                            child: Text(state.tr("ready"), style: const TextStyle(color: Colors.white)),
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
        Text("${state.tr("menu_management")} ($title):", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
        const SizedBox(height: 10),

        ...menuList.map((dish) {
          final bool isAvail = dish["isAvailable"] ?? true;
          final dName = state.isHindi ? dish["hindiName"] : dish["name"];

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(dName, style: TextStyle(fontWeight: FontWeight.bold, decoration: isAvail ? null : TextDecoration.lineThrough)),
              subtitle: Text("${state.tr("rate")}${dish["price"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFFC5A059)),
                    onPressed: () => _editPrice(context, resName, dish["id"], dName, dish["price"]),
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
    );
  }

  void _editPrice(BuildContext context, String resName, String dishId, String dishName, int currentPrice) {
    final priceCtrl = TextEditingController(text: "$currentPrice");
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("$dishName Price Update"),
          content: TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "New Price (₹)")),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220)),
              onPressed: () {
                final np = int.tryParse(priceCtrl.text) ?? currentPrice;
                AppState.instance.updateDishPrice(resName, dishId, np);
                Navigator.pop(ctx);
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showAddDishModal(BuildContext context, String resName) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Add New Dish"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Dish Name")),
              TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Price (₹)")),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF262220)),
              onPressed: () {
                if (nameCtrl.text.isNotEmpty && priceCtrl.text.isNotEmpty) {
                  AppState.instance.addNewDish(resName, {
                    "id": "new_${DateTime.now().millisecondsSinceEpoch}",
                    "name": nameCtrl.text,
                    "hindiName": nameCtrl.text,
                    "price": int.tryParse(priceCtrl.text) ?? 100,
                    "isAvailable": true,
                    "desc": "Freshly prepared meal",
                    "hindiDesc": "ताज़ा तैयार स्वादिष्ट भोजन",
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text("Add", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

// ---------------- 6. DELIVERY RIDER SCREEN (WITH DISTANCE & MAP ROUTE) ----------------
class DeliveryRiderScreen extends StatelessWidget {
  const DeliveryRiderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF262220), borderRadius: BorderRadius.circular(14)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _riderStat(state.tr("today_deliveries"), "${state.orders.length} Tasks"),
              Container(height: 30, width: 1, color: Colors.white24),
              _riderStat(state.tr("rider_earnings"), "₹${state.orders.length * 40}"),
            ],
          ),
        ),
        const SizedBox(height: 20),

        Text(state.tr("assigned_tasks"), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
        const SizedBox(height: 10),

        if (state.orders.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: const Center(child: Text("No delivery tasks assigned currently.")),
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
                        Text("Task ID: ${o["id"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4)), child: Text(o["status"], style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 11))),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.store, color: Color(0xFFC5A059), size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text("${state.tr("pickup_from")} ${o["res"]} (📍 ${o["distance"]})", style: const TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.home, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text("${state.tr("deliver_to")} ${o["customerName"]} (${o["address"]})")),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.payments, color: Colors.teal, size: 20),
                        const SizedBox(width: 8),
                        Text("${state.tr("collect_cash")} ₹${o["total"]} (${o["payment"]})", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                            onPressed: () => state.updateOrderStatus(o["id"], state.isHindi ? "राइडर रवाना (On the Way)" : "On the Way"),
                            child: Text(state.tr("picked_up"), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                            onPressed: () => state.updateOrderStatus(o["id"], state.isHindi ? "सफलतापूर्वक डिलीवर (Delivered)" : "Delivered"),
                            child: Text(state.tr("delivered"), style: const TextStyle(color: Colors.white, fontSize: 12)),
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

// ---------------- 7. EEVAAN VENTURES ADMIN SCREEN ----------------
class EevaanAdminScreen extends StatelessWidget {
  const EevaanAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;

    int totalSales = 0;
    for (var o in state.orders) {
      totalSales += (o["total"] as num).toInt();
    }
    int commission = (totalSales * 0.10).round();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(child: _metric(state.tr("total_orders"), "${state.orders.length}", Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: _metric(state.tr("gross_sales"), "₹$totalSales", const Color(0xFFC5A059))),
          ],
        ),
        const SizedBox(height: 12),
        _metric(state.tr("net_commission"), "₹$commission", Colors.green.shade800),
        const SizedBox(height: 24),
        Text(state.tr("live_dispatch"), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF262220))),
        const SizedBox(height: 10),
        if (state.orders.isEmpty) const Text("No orders placed yet."),
        ...state.orders.map((o) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text("${o["res"]} ➔ ${o["customerName"]} (₹${o["total"]})"),
              subtitle: Text("ID: ${o["id"]} | ${o["payment"]} | ${o["status"]}"),
              trailing: PopupMenuButton<String>(
                onSelected: (st) => state.updateOrderStatus(o["id"], state.isHindi ? "सफलतापूर्वक डिलीवर (Delivered)" : "Delivered"),
                itemBuilder: (ctx) => [PopupMenuItem(value: "Delivered", child: Text(state.tr("mark_delivered")))],
              ),
            ),
          );
        }).toList(),
      ],
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
