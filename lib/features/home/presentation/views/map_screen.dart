import 'package:courier_delivery_app/features/packages/cubit/package_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nominatim_flutter/model/request/search_request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng? pickupLocation;
  LatLng? dropOffLocation;

  Future<LatLng?> getCoordinates(String address) async {
    try {
      final searchRequest = SearchRequest(
        query: address,
        limit: 1,
        countryCodes: ['eg'],
      );
      final result = await NominatimFlutter.instance.search(
        searchRequest: searchRequest,
        language: 'en',
      );
      if (result.isNotEmpty) {
        final lat = double.parse(result.first.lat ?? '0');
        final lon = double.parse(result.first.lon ?? '0');
        return LatLng(lat, lon);
      }
    } catch (e) {
      debugPrint('Error fetching coordinates: $e');
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    context.read<PackageCubit>().fetchPackages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackageCubit, PackageState>(
      listener: (context, state) async {
        if (state is PackageError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is PackageSuccess) {
          final package = state.packages.last;

          pickupLocation = await getCoordinates(package.pickupLocation);
          dropOffLocation = await getCoordinates(package.dropOffLocation);
          setState(() {});
        }
      },
      builder: (context, state) {
        if (state is PackageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (pickupLocation == null || dropOffLocation == null) {
          return const Scaffold(
            body: Center(child: Text('Loading locations...')),
          );
        } else {
          return Scaffold(
          appBar: AppBar(title: const Text('Delivery Map'), centerTitle: true,),
          body: FlutterMap(
            options: MapOptions(
              initialCenter: pickupLocation!,
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.courier_delivery_app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: pickupLocation!,
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: dropOffLocation!,
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.flag, color: Colors.red, size: 40),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [pickupLocation!, dropOffLocation!],
                    color: Colors.blue,
                    strokeWidth: 4.0,
                  ),
                ],
              ),
            ],
          ),
        );
        }
      },
    );
  }
}
