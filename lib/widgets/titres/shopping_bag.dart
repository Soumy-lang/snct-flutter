import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart'; 

 class CartSheet extends StatelessWidget {
  const CartSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFF3F6FA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ListView(
          controller: controller,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mon panier', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (cart.isEmpty && cart.isEmptytrajet )
              const Text('Le panier est vide', style: TextStyle(fontSize: 16, color: Colors.black54))
            else ...[
  if (!cart.isEmpty)
    ...cart.items.map((item) => ListTile(
          title: Text(item.label),
          subtitle: Text(item.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.price),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => cart.removeFromCart(item),
              ),
            ],
          ),
        )),
  if (!cart.isEmptytrajet)
    ...cart.billets.map((billet) => ListTile(
          title: Text('${billet.departureTime} → ${billet.arrivalTime}'),
          subtitle: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children:[ Text('${billet.from} → ${billet.to}'),
          Text(billet.trainLabel,)]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(billet.price),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => cart.removeFromCarts(billet),
              ),
            ],
          ),
        )),
] ,
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              
            ),
            const SizedBox(height: 16),          
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total :', style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text("${(cart.total + cart.totals).toStringAsFixed(2)} €",
                          style: const TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    label: const Text('Valider mon panier'),
                  ),
                  const SizedBox(height: 12),
                  
                ],
              
            ),
            ),
          
          ],
        ),
      ),
    );
  }
}
