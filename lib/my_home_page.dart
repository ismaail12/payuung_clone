import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payuung/bloc/auth/auth_bloc.dart';
import 'package:payuung/profile_screen.dart';
import 'package:payuung/service/user_services.dart';

const List<String> list = <String>[
  'Terpopuler',
  'A to Z',
  'Z to A',
  'Harga Terendah',
  'Harga Tertinggi'
];

class MenuItem {
  final String icon, name;

  MenuItem(this.icon, this.name);
}

class WellnessMenuItem {
  final String image, name, price;

  WellnessMenuItem(this.image, this.name, this.price);
}

final financeProductMenuList = [
  MenuItem('assets/icons/item1.svg', 'Urun'),
  MenuItem('assets/icons/item2.svg', 'Pembiayaan Porsi Haji'),
  MenuItem('assets/icons/item3.svg', 'Financial Check Up'),
  MenuItem('assets/icons/item4.svg', 'Asuransi Mobil'),
  MenuItem('assets/icons/item4.svg', 'Asuransi Properti'),
];

final categoryList = [
  MenuItem('assets/icons/item5.svg', 'Hobi'),
  MenuItem('assets/icons/item6.svg', 'Merchandise'),
  MenuItem('assets/icons/item7.svg', 'Gaya Hidup Sehat'),
  MenuItem('assets/icons/item8.svg', 'Konseling & Rohani'),
  MenuItem('assets/icons/item9.svg', 'Self Development'),
  MenuItem('assets/icons/item10.svg', 'Perencanaan Keuangan'),
  MenuItem('assets/icons/item11.svg', 'Konsultasi Medis'),
  MenuItem('assets/icons/item12.svg', 'Lainnya'),
];

final wellnessList = [
  WellnessMenuItem(
      'assets/images/wellness1.png', 'Voucher digital indomaret', 'Rp. 25.000'),
  WellnessMenuItem('assets/images/wellness2.png',
      'Voucher digital Grab Transport', 'Rp. 20.000'),
  WellnessMenuItem(
      'assets/images/wellness3.png', 'Voucher digital HNM', 'Rp. 100.000'),
  WellnessMenuItem(
      'assets/images/wellness4.png', 'Voucher digital Excelso', 'Rp. 50.000'),
  WellnessMenuItem('assets/images/wellness5.png',
      'Voucher digital Haagend Dazs', 'Rp. 100.000'),
  WellnessMenuItem(
      'assets/images/wellness6.png', 'Voucher digital Alfamart', 'Rp. 200.000'),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String dropdownValue = list.first;

  final userService = UserService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Malam',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {

                if (state is AuthLoading) {
                  return const Text('Loading..', style: TextStyle(fontSize: 12, color: Colors.white),);
                }

                if (state is Authenticated) {
                  return Text(
                    state.user.fullName ?? "",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }
                return const Text('Silahkan tambah data user');
              },
            ),
          ],
        ),
        actions: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const SizedBox(
                  height: 40,
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 32.0, // Icon size
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    constraints: const BoxConstraints(
                      maxWidth: 18.0,
                      maxHeight: 18.0,
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 12.0, // Circle radius
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 18,
              child: Text(
                'I',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TabBar(
                            onTap: (index) {
                              _tabController.animateTo(0);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    backgroundColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: const Text(
                                      textAlign: TextAlign.center,
                                      'Masukan email dan password Payuung Karywan',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    children: <Widget>[
                                      const TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Alamat Email',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('Sambungkan')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Kembali'))
                                    ],
                                  );
                                },
                              );
                            },
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Theme.of(context).primaryColor,
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            dividerColor: Colors.transparent,
                            tabs: const [
                              Tab(text: 'Payuung Pribadi'),
                              Tab(text: 'Payuung Karyawan'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Produk Keuangan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GridView.builder(
                    itemCount: financeProductMenuList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            financeProductMenuList[index].icon,
                            height: 40,
                          ),
                          Text(
                            financeProductMenuList[index].name,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kategori Pilihan',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            const Text('Wishlist'),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle),
                                child: const Text('1')),
                          ],
                        ),
                      )
                    ],
                  ),
                  GridView.builder(
                    itemCount: categoryList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            categoryList[index].icon,
                            height: 40,
                          ),
                          Text(
                            categoryList[index].name,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Explore Wellness',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 28,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 0,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          underline: const SizedBox(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GridView.builder(
                    itemCount: wellnessList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.5,
                              child: Image.asset(
                                wellnessList[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              wellnessList[index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              wellnessList[index].price,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
