import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';
import 'package:courier_delivery_app/features/packages/cubit/package_cubit.dart';
import 'package:courier_delivery_app/features/packages/presentation/views/package_details_screen.dart';
import 'package:courier_delivery_app/features/packages/presentation/widgets/package_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    context.read<PackageCubit>().fetchPackages();
  }

  @override
  void dispose() {
    tabController?.dispose();
    searchController.dispose();
    super.dispose();
  }

  void openPackageDetails(DeliveryModel package) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PackageDetailsScreen(package: package)),
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
      body: BlocConsumer<PackageCubit, PackageState>(
        listener: (context, state) {
          if (state is PackageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is PackageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PackageSuccess) {
            final packages = state.packages;
            return TabBarView(
              controller: tabController,
              children: [
                PackageListWidget(
                  packages: packages,
                  filter: 'All',
                  onPackageTap: openPackageDetails,
                ),
                PackageListWidget(
                  packages: packages,
                  filter: 'Pending',
                  onPackageTap: openPackageDetails,
                ),
                PackageListWidget(
                  packages: packages,
                  filter: 'Delivered',
                  onPackageTap: openPackageDetails,
                ),
                PackageListWidget(
                  packages: packages,
                  filter: 'In Progress',
                  onPackageTap: openPackageDetails,
                ),
              ],
            );
          } else {
            return const Center(child: Text('No packages found.'));
          }
        },
      ),
    );
  }
}
