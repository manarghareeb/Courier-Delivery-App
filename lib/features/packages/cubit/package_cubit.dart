import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  PackageCubit() : super(PackageInitial());

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<void> loadPackages() async {
    emit(PackageLoading());
    try {
      final user = auth.currentUser;
      if (user == null) {
        emit(PackageError('User not logged in'));
        return;
      }

      final snapshot =
          await firestore
              .collection('users')
              .doc(user.uid)
              .collection('deliveries')
              .get();

      final pending = <Map<String, dynamic>>[];
      final inTransit = <Map<String, dynamic>>[];
      final delivered = <Map<String, dynamic>>[];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final status = data['status'] ?? 'Pending';

        if (status == 'Pending') {
          pending.add(data);
        } else if (status == 'In Transit') {
          inTransit.add(data);
        } else if (status == 'Delivered') {
          delivered.add(data);
        }
      }

      emit(
        PackageSuccess(
          pending: pending,
          inTransit: inTransit,
          delivered: delivered,
        ),
      );
    } catch (e) {
      emit(PackageError(e.toString()));
    }
  }
}
