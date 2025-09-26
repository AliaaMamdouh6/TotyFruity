import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const Cart({super.key, required this.cartItems});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void incrementQuantity(int index) {
    setState(() {
      widget.cartItems[index]["quantity"] = (widget.cartItems[index]["quantity"] as int) + 1;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      final current = widget.cartItems[index]["quantity"] as int;
      if (current > 1) {
        widget.cartItems[index]["quantity"] = current - 1;
      } else {
        widget.cartItems.removeAt(index);
      }
    });
  }

  double get cartTotal {
    double total = 0;
    for (final item in widget.cartItems) {
      total += (item["price"] as double) * (item["quantity"] as int);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('cart'.tr())),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      final price = item["price"] as double;
                      final quantity = item["quantity"] as int;
                      final itemTotal = price * quantity;
                return ListTile(
                        leading: Image.asset(item["image"] as String, width: 50),
                        title: Text(item["title"] as String),
                        subtitle: Text(
                          "${price.toStringAsFixed(2)} ${'currency'.tr()}  x $quantity = ${itemTotal.toStringAsFixed(2)} ${'currency'.tr()}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => decrementQuantity(index),
                            ),
                            Text(quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => incrementQuantity(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: const Border(
                      top: BorderSide(color: Colors.black12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${'total'.tr()}: ${cartTotal.toStringAsFixed(2)} ${'currency'.tr()}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('checkout'.tr()),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
