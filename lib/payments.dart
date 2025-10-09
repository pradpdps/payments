import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  int _selectedMethod = 0; // 0: Visa, 1: Apple Pay, 2: Bank Transfer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xFFF5F6F7),
      body: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Payment Method',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Paying to: Online Store Inc.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 8),
              Text(
                '\$125.00',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Saved Methods',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              _buildPaymentMethod(
                icon: Icon(Icons.credit_card, size: 32),
                label: 'Visa **** 134',
                selected: _selectedMethod == 0,
                onTap: () {
                  setState(() {
                    _selectedMethod = 0;
                  });
                },
              ),
              SizedBox(height: 12),
              _buildPaymentMethod(
                icon: Icon(Icons.apple, size: 32),
                label: 'Apple Pay',
                selected: _selectedMethod == 1,
                onTap: () {
                  setState(() {
                    _selectedMethod = 1;
                  });
                },
              ),
              SizedBox(height: 12),
              _buildPaymentMethod(
                icon: Icon(Icons.account_balance, size: 32),
                label: 'Bank Transfer',
                selected: _selectedMethod == 2,
                onTap: () {
                  setState(() {
                    _selectedMethod = 2;
                  });
                },
              ),
              SizedBox(height: 24),
              Text(
                'Other Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Add New Bank Account',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF00796B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Icon(Icons.lock, color: Color(0xFF00796B)),
                  SizedBox(width: 8),
                  Text(
                    'Secure connection & encrypted data',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00796B),
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _showPaymentDialog,
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required Widget icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: selected
            ? Icon(Icons.radio_button_checked, color: Color(0xFF00796B))
            : Icon(Icons.radio_button_off, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Future<void> _showPaymentDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFF00796B)),
                ),
                SizedBox(height: 24),
                Text(
                  'Processing Payment...',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 2));

    // Close loader and show success
    if (mounted) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.check_circle,
                        color: Color(0xFF43A047), size: 64),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Payment Successful!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF43A047),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Thank you for your payment.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00796B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
