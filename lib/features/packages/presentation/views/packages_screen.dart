import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/features/packages/presentation/views/package_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> dummyPackages = [
    {
      'id': '#12345',
      'date': '29/10/2025',
      'receiver': 'John Doe',
      'address': 'Cairo',
      'phone': '01012345678',
      'payment': 'Cash',
      'price': '250 EGP',
      'status': 'Pending',
    },
    {
      'id': '#12346',
      'date': '28/10/2025',
      'receiver': 'Sara Ali',
      'address': 'Giza',
      'phone': '01087654321',
      'payment': 'Online',
      'price': '300 EGP',
      'status': 'Delivered',
    },
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    searchController.dispose();
    super.dispose();
  }

  void openPackageDetails(Map<String, String> package) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PackageDetailsScreen(package: package),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 48.h,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search packages...',
                    filled: true,
                    fillColor: ColorManager.textFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
              IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
            ],
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          labelColor: ColorManager.mainColor,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Delivered'),
            Tab(text: 'In Progress'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: List.generate(4, (index) {
          return ListView.builder(
            itemCount: dummyPackages.length,
            itemBuilder: (context, i) {
              final package = dummyPackages[i];
              return Card(
                color: ColorManager.textFieldColor,
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: ListTile(
                  title: Text(
                    '${package['id']} - ${package['receiver']}',
                    style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
                  ),
                  subtitle: Text(
                    'Price: ${package['price']} | Status: ${package['status']}',
                    style: TextStyles.font14GreyNormalItalic,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                  onTap: () => openPackageDetails(package),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

