import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> drinks = [
    {"title": "Orange Juice", "image": "assets/orange_juice.jpg", "price": 4.99},
    {"title": "Mango Juice", "image": "assets/mango.jpg", "price": 5.49},
    {"title": "Mixberry", "image": "assets/mixberry.jpg", "price": 5.99},
    {"title": "Lemon mint", "image": "assets/lemon_mint.jpg", "price": 4.49},
    {"title": "Kiwi", "image": "assets/kiwi.png", "price": 4.79},
    {"title": "Watermelon", "image": "assets/watermelon.jpg", "price": 4.59},
    {"title": "Lemon", "image": "assets/lemon.jpeg", "price": 3.99},
    {"title": "Melon", "image": "assets/melon.jpeg", "price": 4.29},
    {"title": "Pineapple", "image": "assets/pineapple.jpeg", "price": 5.29},
    {"title": "Strawberry", "image": "assets/strawberry.jpeg", "price": 4.89},  
  ];

  // Highlighted hot offers to display at the top in a PageView
  final List<Map<String, dynamic>> hotOffers = [
    {"title": "Orange Juice", "image": "assets/orange_juice.jpg", "price": 3.99},
    {"title": "Mixberry", "image": "assets/mixberry.jpg", "price": 4.79},
    {"title": "Mango Juice", "image": "assets/mango.jpg", "price": 4.49},
  ];

  final List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> drink) {
    setState(() {
      final index = cart.indexWhere((item) => item["title"] == drink["title"]);
      if (index >= 0) {
        cart[index]["quantity"] = (cart[index]["quantity"] as int) + 1;
      } else {
        cart.add({
          "title": drink["title"],
          "image": drink["image"],
          "price": drink["price"],
          "quantity": 1,
        });
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${drink["title"]} added to cart")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title:  Text('home'.tr(),style: const TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Cart(cartItems: cart),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hot Offers (PageView at top)
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'offers'.tr(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.9),
                itemCount: hotOffers.length,
                itemBuilder: (context, index) {
                  final offer = hotOffers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(offer["image"] as String, fit: BoxFit.cover),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.5)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          bottom: 12,
                          right: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  offer["title"] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${(offer["price"] as double).toStringAsFixed(2)} ${'currency'.tr()}",
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Our Drinks title above the grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'product_message'.tr(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            // Drinks Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: drinks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final drink = drinks[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.asset(
                            drink["image"]!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              // Log the failing image path to console
                              // ignore: avoid_print
                              print('Image load error for: \\${drink["image"]} -> \\${error.toString()}');
                              return Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(drink["title"]!),
                      ),
                      Text("${drink["price"].toStringAsFixed(2)} ${'currency'.tr()}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () => addToCart(drink),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Removed old bottom hot offers list
          ],
        ),
      ),
    );
  }
}
