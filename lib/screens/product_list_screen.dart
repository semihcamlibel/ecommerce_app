import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'product_detail_screen.dart';
import '../providers/cart_provider.dart';
import '../screens/home_screen.dart';
import '../providers/favorites_provider.dart';
import '../providers/notification_provider.dart';
import 'search_screen.dart';
import 'notification_screen.dart';
import 'category_products_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  List<Map<String, dynamic>> _filterProductsByCategory(
    List<Map<String, dynamic>> products,
    String category,
  ) {
    switch (category.toLowerCase()) {
      case 'elektronik':
        return products.where((product) => [
          'iPhone 14 Pro Max',
          'MacBook Pro M2',
          'AirPods Pro 2. Nesil',
          'Samsung Galaxy Tab S9',
          'Apple Watch Series 8',
          'Sony WH-1000XM5',
        ].contains(product['name'])).toList();
      case 'giyim':
        return []; // Örnek olarak boş liste
      case 'kitap':
        return []; // Örnek olarak boş liste
      case 'spor':
        return []; // Örnek olarak boş liste
      case 'kozmetik':
        return []; // Örnek olarak boş liste
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Örnek kategori verileri
    final List<Map<String, dynamic>> categories = [
      {'name': 'Elektronik', 'icon': Icons.phone_android},
      {'name': 'Giyim', 'icon': Icons.checkroom},
      {'name': 'Kitap', 'icon': Icons.book},
      {'name': 'Spor', 'icon': Icons.sports_soccer},
      {'name': 'Kozmetik', 'icon': Icons.face},
    ];

    // Örnek ürün verileri
    final List<Map<String, dynamic>> products = [
      {
        'name': 'iPhone 14 Pro Max',
        'price': '64999',
        'description': '256 GB, Uzay Siyahı, 48MP Kamera',
        'imageUrl': 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-deeppurple?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1663703841896',
        'discount': '10%',
        'rating': 4.8,
        'reviews': 128,
      },
      {
        'name': 'MacBook Pro M2',
        'price': '52999',
        'description': '512 GB SSD, 16 GB RAM, 14 inç',
        'imageUrl': 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mbp14-spacegray-select-202301?wid=452&hei=420&fmt=jpeg&qlt=95&.v=1671304673229',
        'discount': null,
        'rating': 4.9,
        'reviews': 85,
      },
      {
        'name': 'AirPods Pro 2. Nesil',
        'price': '7999',
        'description': 'Aktif Gürültü Önleme, MagSafe Şarj',
        'imageUrl': 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MQD83?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1660803972361',
        'discount': '15%',
        'rating': 4.7,
        'reviews': 246,
      },
      {
        'name': 'Samsung Galaxy Tab S9',
        'price': '24999',
        'description': '256 GB, Wi-Fi, S Pen Dahil',
        'imageUrl': 'https://cdn.vatanbilgisayar.com/Upload/PRODUCT/samsung/thumb/137432-1-2_large.jpg',
        'discount': '20%',
        'rating': 4.6,
        'reviews': 92,
      },
      {
        'name': 'Apple Watch Series 8',
        'price': '12999',
        'description': 'GPS, 45mm, Alüminyum Kasa',
        'imageUrl': 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MPNW3ref_VW_34FR+watch-45-alum-midnight-nc-8s_VW_34FR_WF_CO_GEO_TR?wid=700&hei=700&trim=1%2C0&fmt=p-jpg&qlt=95&.v=1683224241054',
        'discount': null,
        'rating': 4.8,
        'reviews': 156,
      },
      {
        'name': 'Sony WH-1000XM5',
        'price': '8999',
        'description': 'Kablosuz Kulaklık, Gürültü Engelleme',
        'imageUrl': 'https://cdn.vatanbilgisayar.com/Upload/PRODUCT/sony/thumb/135319-1_large.jpg',
        'discount': '25%',
        'rating': 4.9,
        'reviews': 178,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Ticaret'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(allProducts: products),
                ),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
              ),
              Consumer<NotificationProvider>(
                builder: (context, notifications, child) {
                  if (notifications.unreadCount == 0) {
                    return const SizedBox.shrink();
                  }
                  return Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${notifications.unreadCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Slider Banner
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 0,
              ),
              items: [
                _buildBannerItem(
                  'Yeni Sezon İndirimi',
                  'Tüm ürünlerde %50\'ye varan indirimler',
                  Colors.blue,
                ),
                _buildBannerItem(
                  'Süper Fırsat',
                  'Elektronik ürünlerde büyük indirim',
                  Colors.orange,
                ),
                _buildBannerItem(
                  'Ücretsiz Kargo',
                  '150 TL üzeri alışverişlerde',
                  Colors.green,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Kategoriler Başlığı
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kategoriler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Tüm kategoriler sayfasına yönlendir
                    },
                    child: const Text('Tümünü Gör'),
                  ),
                ],
              ),
            ),
            
            // Kategoriler Listesi
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final filteredProducts = _filterProductsByCategory(
                        products,
                        categories[index]['name'],
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductsScreen(
                            categoryName: categories[index]['name'],
                            products: filteredProducts,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            categories[index]['icon'],
                            color: Colors.blue[700],
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            categories[index]['name'],
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Ürünler Başlığı
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Öne Çıkan Ürünler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Tüm ürünler sayfasına yönlendir
                    },
                    child: const Text('Tümünü Gör'),
                  ),
                ],
              ),
            ),
            
            // Ürün Listesi
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                                child: Image.network(
                                  product['imageUrl'],
                                  fit: BoxFit.contain,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.red[300],
                                            size: 32,
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Görsel Yüklenemedi',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (product['discount'] != null)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product['discount']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Consumer<FavoritesProvider>(
                                builder: (context, favorites, child) {
                                  final isFavorite = favorites.isFavorite(product);
                                  return IconButton(
                                    icon: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      favorites.toggleFavorite(product);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            isFavorite
                                                ? 'Ürün favorilerden çıkarıldı'
                                                : 'Ürün favorilere eklendi',
                                          ),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${product['price']} TL',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Provider.of<CartProvider>(context, listen: false)
                                        .addItem(product);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Ürün sepete eklendi'),
                                        duration: const Duration(seconds: 2),
                                        action: SnackBarAction(
                                          label: 'Sepete Git',
                                          onPressed: () {
                                            // HomeScreen'deki bottom navigation bar'ı güncellemek için
                                            Navigator.of(context).pop();
                                            if (context.mounted) {
                                              Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) => const HomeScreen(initialIndex: 1),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  child: const Text('Sepete Ekle'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerItem(String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      color,
                      color.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}