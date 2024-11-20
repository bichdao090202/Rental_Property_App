// import 'package:flutter/material.dart';
//
// class DigitalSignatureScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chữ ký số')),
//       body: Center(child: Text('digital-signature')),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/data/models/signature.dart';
import 'package:rental_property_app/data/services/api_service.dart';
import 'package:rental_property_app/presentation/providers/auth_provider.dart';
class DigitalSignatureScreen extends StatefulWidget {
  @override
  _DigitalSignatureScreenState createState() => _DigitalSignatureScreenState();
}

class _DigitalSignatureScreenState extends State<DigitalSignatureScreen> {
  List<Signature> _signatures = [];
  bool _isLoading = true;
  bool _isCheckingSignature = false;
  final _formKey = GlobalKey<FormState>();

  String _selectedProvider = '';
  final _userIdController = TextEditingController();
  bool? _isSignatureValid;

  final List<Map<String, String>> providers = [
    {'value': 'VNPT', 'label': 'VNPT'},
    {'value': 'VIETTEL', 'label': 'Viettel'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchSignatures();
  }

  Future<void> _fetchSignatures() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.userInfo?.id != null) {
        final response = await ApiService().getListSignaturesByUserId(authProvider.userInfo!.id);

        if (response['status'] == 'SUCCESS') {
          setState(() {
            _signatures = (response['data'] as List)
                .map((json) => Signature.fromJson(json))
                .toList();
            _isLoading = false;
          });
        }
      }
    } catch (error) {
      print('Error fetching signatures: $error');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _checkSignature() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCheckingSignature = true);
    try {
      final response = await ApiService().post(
        'http://54.253.233.87:8010/sign/get_certificate',
        {
          'provider': _selectedProvider,
          'user_id': _userIdController.text,
        },
      );
      setState(() => _isSignatureValid = true);
    } catch (error) {
      setState(() => _isSignatureValid = false);
      print('Error checking signature: $error');
    } finally {
      setState(() => _isCheckingSignature = false);
    }
  }

  Future<void> _addSignature() async {
    setState(() => _isCheckingSignature = true);
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await ApiService().signPost('signatures', {
        'service_type': _selectedProvider,
        'user_id': authProvider.userInfo!.id,
        'cccd_number': _userIdController.text,
      });
      _fetchSignatures();
      Navigator.pop(context);
    } catch (error) {
      print('Error adding signature: $error');
    } finally {
      setState(() => _isCheckingSignature = false);
    }
  }

  void _showAddSignatureDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Thêm chữ ký số',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Nhà cung cấp',
                  border: OutlineInputBorder(),
                ),
                value: _selectedProvider.isEmpty ? null : _selectedProvider,
                items: providers.map((provider) {
                  return DropdownMenuItem(
                    value: provider['value'],
                    child: Text(provider['label']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedProvider = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn nhà cung cấp';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _userIdController,
                decoration: InputDecoration(
                  labelText: 'User ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập User ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              if (_isSignatureValid != null)
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isSignatureValid!
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _isSignatureValid!
                        ? 'Chữ ký số hợp lệ.'
                        : 'Chữ ký số không hợp lệ.',
                    style: TextStyle(
                      color: _isSignatureValid! ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isCheckingSignature ? null : _checkSignature,
                      child: _isCheckingSignature
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : Text('Kiểm tra'),
                    ),
                  ),
                  if (_isSignatureValid == true) ...[
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isCheckingSignature ? null : _addSignature,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text('Thêm chữ ký'),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chữ ký số'),
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _fetchSignatures,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Danh sách chữ ký số của bạn',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: _showAddSignatureDialog,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    if (_signatures.isEmpty)
                      Center(
                        child: Text(
                          'Bạn chưa có chữ ký số nào',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (_signatures.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final signature = _signatures[index];
                    return Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(
                          'Nhà cung cấp: ${signature.serviceType}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('ID: ${signature.cccdNumber}'),
                        leading: const CircleAvatar(
                          child: Icon(Icons.draw),
                        ),
                      ),
                    );
                  },
                  childCount: _signatures.length,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }
}