import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'home_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Form alanları için controller'lar
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  String _selectedPaymentMethod = 'Kredi Kartı';
  bool _saveAddress = false;
  bool _saveCard = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  void _showOrderConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Sipariş Onayı'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'Siparişiniz başarıyla oluşturuldu!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).clear();
              Navigator.of(ctx).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep++;
              });
            } else {
              if (_formKey.currentState?.validate() ?? false) {
                _showOrderConfirmation();
              }
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            // Teslimat Bilgileri
            Step(
              title: const Text('Teslimat Bilgileri'),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Ad Soyad',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen ad soyad giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-posta',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen e-posta giriniz';
                      }
                      if (!value.contains('@')) {
                        return 'Geçerli bir e-posta giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Telefon',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen telefon numarası giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Adres',
                      prefixIcon: Icon(Icons.location_on),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen adres giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Bu adresi kaydet'),
                    value: _saveAddress,
                    onChanged: (bool value) {
                      setState(() {
                        _saveAddress = value;
                      });
                    },
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
            ),
            
            // Ödeme Yöntemi
            Step(
              title: const Text('Ödeme Yöntemi'),
              content: Column(
                children: [
                  RadioListTile(
                    title: const Text('Kredi Kartı'),
                    value: 'Kredi Kartı',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Havale/EFT'),
                    value: 'Havale/EFT',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Kapıda Ödeme'),
                    value: 'Kapıda Ödeme',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                  if (_selectedPaymentMethod == 'Kredi Kartı') ...[
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Kart Numarası',
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                      validator: (value) {
                        if (_selectedPaymentMethod == 'Kredi Kartı') {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen kart numarası giriniz';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _expiryController,
                            decoration: const InputDecoration(
                              labelText: 'Son Kullanma',
                              hintText: 'AA/YY',
                            ),
                            validator: (value) {
                              if (_selectedPaymentMethod == 'Kredi Kartı') {
                                if (value == null || value.isEmpty) {
                                  return 'Gerekli';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                            ),
                            validator: (value) {
                              if (_selectedPaymentMethod == 'Kredi Kartı') {
                                if (value == null || value.isEmpty) {
                                  return 'Gerekli';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cardHolderController,
                      decoration: const InputDecoration(
                        labelText: 'Kart Üzerindeki İsim',
                      ),
                      validator: (value) {
                        if (_selectedPaymentMethod == 'Kredi Kartı') {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen kart üzerindeki ismi giriniz';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Bu kartı kaydet'),
                      value: _saveCard,
                      onChanged: (bool value) {
                        setState(() {
                          _saveCard = value;
                        });
                      },
                    ),
                  ],
                ],
              ),
              isActive: _currentStep >= 1,
            ),
            
            // Sipariş Özeti
            Step(
              title: const Text('Sipariş Özeti'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ürünler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item['name']),
                        subtitle: Text('${item['quantity']} adet'),
                        trailing: Text(
                          '${(double.parse(item['price']) * item['quantity']).toStringAsFixed(2)} TL',
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ara Toplam',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${cart.totalAmount.toStringAsFixed(2)} TL',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kargo',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        cart.totalAmount >= 150 ? 'Ücretsiz' : '14.99 TL',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Toplam',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${(cart.totalAmount + (cart.totalAmount >= 150 ? 0 : 14.99)).toStringAsFixed(2)} TL',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
            ),
          ],
        ),
      ),
    );
  }
} 