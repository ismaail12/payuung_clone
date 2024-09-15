import 'package:flutter/material.dart';
import 'package:payuung/my_home_page.dart';

class VerticalSwipeableBottomBar extends StatefulWidget {
  const VerticalSwipeableBottomBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerticalSwipeableBottomBarState createState() =>
      _VerticalSwipeableBottomBarState();
}

class _VerticalSwipeableBottomBarState
    extends State<VerticalSwipeableBottomBar> {
  bool _isExpanded = false;
  final double _minHeight = 80;
  final double _maxHeight = 300;
  int _selectedIndex = 0;

  final List<NavItem> _navItems = [
    NavItem(Icons.home, 'Beranda', const MyHomePage()),
    NavItem(Icons.search, 'Cari', const SearchScreen()),
    NavItem(Icons.shopping_cart, 'Keranjang', const CartScreen()),
    NavItem(Icons.list, 'Daftar Transaksi', const TransactionListScreen()),
    NavItem(Icons.card_giftcard, 'Voucher Saya', const VoucherScreen()),
    NavItem(Icons.location_on, 'Alamat', const AddressScreen()),
    NavItem(Icons.group, 'Daftar Teman', const FriendsListScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _navItems[_selectedIndex].screen, // Display the selected page
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _isExpanded = details.delta.dy < 0;
                });
              },
              onVerticalDragEnd: (details) {
                setState(() {
                  _isExpanded = details.velocity.pixelsPerSecond.dy < 0;
                });
              },
              child: Column(
                children: [
                  _buildArrowButton(),
                  AnimatedContainer(
                    padding: EdgeInsets.zero,
                    duration: const Duration(milliseconds: 300),
                    height: _isExpanded ? _maxHeight : _minHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius:5,
                          offset: const Offset(0, -1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: _isExpanded ? _navItems.length : 3,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (index > 2) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return _navItems[index].screen;
                                      },
                                    ));
                                  } else {
                                    setState(() {
                                      _selectedIndex = index;
                                      _isExpanded = false;
                                    });
                                  }
                                },
                                child: _buildNavItem(
                                    _navItems[index], index == _selectedIndex),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Icon(
        _isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildNavItem(NavItem item, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          item.icon,
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.grey, // Mark icon as selected
        ),
        const SizedBox(height: 4),
        Text(
          item.label,
          style: TextStyle(
            fontSize: 12,
            color:
                isSelected ? Theme.of(context).primaryColor : Colors.grey, // Mark text as selected
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Define navigation item model
class NavItem {
  final IconData icon;
  final String label;
  final Widget screen;

  NavItem(this.icon, this.label, this.screen);
}

// Example screens for each menu item
class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Beranda Screen'));
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Screen'));
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Cart Screen'));
  }
}

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Transaction List Screen')));
  }
}

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Voucher Screen')));
  }
}

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Adress Screen')));
  }
}

class FriendsListScreen extends StatelessWidget {
  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('FriendsListScreen Screen')));
  }
}


