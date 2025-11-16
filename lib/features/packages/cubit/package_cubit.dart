import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  PackageCubit() : super(PackageInitial());

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<void> fetchPackages() async {
    emit(PackageLoading());
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        emit(PackageError('User not logged in'));
        return;
      }

      final querySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('deliveries')
          .get();

      final packages = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return DeliveryModel.fromMap(data, doc.id);
      }).toList();

      emit(PackageSuccess(packages));
    } catch (e) {
      emit(PackageError(e.toString()));
    }
  }
}
