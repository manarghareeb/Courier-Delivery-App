import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/small_text_button_widget.dart';
import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PackageDetailsScreen extends StatelessWidget {
  final DeliveryModel package;
  const PackageDetailsScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(package.id),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Package Info',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            Text('Size: ${package.packageInfo.size}', style: TextStyles.font14GreyNormalItalic),
            Text(
              'Weight: ${package.packageInfo.weight}',
              style: TextStyles.font14GreyNormalItalic,
            ),
             Text(
              'Contents: ${package.packageInfo.contents}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 10.h),
            Text(
              'Receiver Info',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            Text(
              'Name: ${package.receiverInfo.name}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            Text(
              'Address: ${package.receiverInfo.address}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            Text(
              'Phone: ${package.receiverInfo.phone}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 10.h),
            Text(
              'Payment & Price',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            Text(
              'Method: ${package.paymentMethod}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            Text(
              'Price: ${package.totalPrice}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 10.h),
            Text(
              'Delivery Status: ${package.status}',
              style: const TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallTextButtomWidget(title: 'Add Review', onPressed: () {}),
                SmallTextButtomWidget(
                  title: 'Courier Review',
                  onPressed: () {},
                ),
                SmallTextButtomWidget(
                  title: 'Invoice',
                  onPressed: () {
                    generatePdf();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void generatePdf() async {
    final pdf = pw.Document();

    final receiverName = package.receiverInfo.name;
    final receicerPhone = package.receiverInfo.phone;
    final receirverAddress = package.receiverInfo.address;
    final paymentMethod = package.paymentMethod;
    //final date = '30 Oct 2025';
    final items = [
      {'title': 'Delivery Service', 'qty': 2, 'price': 50.0},
      {'title': 'Packaging', 'qty': 1, 'price': 20.0},
      {'title': 'Extra Charges', 'qty': 1, 'price': 10.0},
    ];

    final total = items.fold<double>(
      0,
      (sum, item) => sum + (item['qty'] as int) * (item['price'] as double),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'INVOICE',
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Client: $receiverName'),
                pw.Text('Phone: $receicerPhone'),
                pw.Text('Address: $receirverAddress'),
                pw.Text('Payment Methods: $paymentMethod'),
                pw.SizedBox(height: 20),
                pw.Divider(),
                ...items.map(
                  (item) => pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(item['title'].toString()),
                      ),
                      pw.Expanded(flex: 1, child: pw.Text('x${item['qty']}')),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          '\$${((item['qty'] as int) * (item['price'] as double)).toStringAsFixed(2)}',
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Divider(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Total',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
