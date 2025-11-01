import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:nominatim_flutter/model/request/search_request.dart';
import 'package:nominatim_flutter/model/response/nominatim_response.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

class AddressTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final GlobalKey<FormState> formKey;
  final String? Function(String?)? validator;

  const AddressTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    required this.formKey,
    this.validator,
  });

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {

  List<NominatimResponse> addresses = [];
  bool isLoading = false;
  
  Future<void> searchAddress(String query) async {
    if (query.isEmpty) {
      setState(() => addresses = []);
      return;
    }
    setState(() => isLoading = true);
    try {
      final searchRequest = SearchRequest(
        query: query,
        limit: 3,
        addressDetails: true,
        extraTags: true,
        nameDetails: true,
        countryCodes: ['eg'],
      );
      final searchResult = await NominatimFlutter.instance.search(
        searchRequest: searchRequest,
        language: 'en-US,en;q=0.5',
      );
      setState(() => addresses = searchResult);
    } catch (e) {
      debugPrint('Error searching: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            style: TextStyles.font14WhiteNormal.copyWith(color: Colors.black),
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: ColorManager.textFieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => searchAddress(value),
          ),
          ...addresses.map(
            (s) => ListTile(
              title: Text(s.displayName ?? ''),
              onTap: () {
                widget.controller.text = s.displayName ?? '';
                setState(() => addresses = []);
              },
            ),
          ),
        ],
      ),
    );
  }
}
