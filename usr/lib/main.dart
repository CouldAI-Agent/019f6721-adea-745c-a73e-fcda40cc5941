import 'package:flutter/material.dart';

void main() {
  runApp(const BusinessApp());
}

class BusinessApp extends StatelessWidget {
  const BusinessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Business',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AddBusinessScreen(),
      },
    );
  }
}

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid. In a real app, this would send data to a backend.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Business information submitted successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      // Clear form after successful submission
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _addressController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Business'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine the maximum width for the form content
            // This ensures it looks good on both mobile and wide screens (desktop/web)
            double formMaxWidth = constraints.maxWidth > 600 ? 500 : double.infinity;
            
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: formMaxWidth,
                  decoration: constraints.maxWidth > 600 
                    ? BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      )
                    : null,
                  padding: constraints.maxWidth > 600 
                    ? const EdgeInsets.all(32.0)
                    : EdgeInsets.zero,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (constraints.maxWidth > 600)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Text(
                              'Register New Business',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Business Name',
                            prefixIcon: Icon(Icons.business),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a business name';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Contact Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter an email address';
                            }
                            // Basic email validation pattern
                            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            labelText: 'Business Address',
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(),
                            filled: true,
                            alignLabelWithHint: true,
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a business address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submitForm(),
                        ),
                        const SizedBox(height: 32),
                        
                        FilledButton.icon(
                          onPressed: _submitForm,
                          icon: const Icon(Icons.save),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Save Business Details',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
