import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Ayarlar sayfasına yönlendir
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profil Başlığı
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kullanıcı Adı',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'kullanici@email.com',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // Menü Öğeleri
            _buildMenuItem(
              icon: Icons.shopping_bag,
              title: 'Siparişlerim',
              onTap: () {
                // TODO: Siparişler sayfasına yönlendir
              },
            ),
            _buildMenuItem(
              icon: Icons.location_on,
              title: 'Adreslerim',
              onTap: () {
                // TODO: Adresler sayfasına yönlendir
              },
            ),
            _buildMenuItem(
              icon: Icons.payment,
              title: 'Ödeme Yöntemlerim',
              onTap: () {
                // TODO: Ödeme yöntemleri sayfasına yönlendir
              },
            ),
            _buildMenuItem(
              icon: Icons.notifications,
              title: 'Bildirim Ayarları',
              onTap: () {
                // TODO: Bildirim ayarları sayfasına yönlendir
              },
            ),
            _buildMenuItem(
              icon: Icons.help,
              title: 'Yardım ve Destek',
              onTap: () {
                // TODO: Yardım sayfasına yönlendir
              },
            ),
            _buildMenuItem(
              icon: Icons.exit_to_app,
              title: 'Çıkış Yap',
              onTap: () {
                // TODO: Çıkış işlemini gerçekleştir
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 