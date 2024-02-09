import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/form_bloc.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = BlocProvider.of<FormBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your name';
                      }
                      if (value.length < 4) {
                        return '* Name should contain atleast 4 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formBloc.name = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your email';
                      }
                      // Add email validation logic if needed
                      if (!formBloc.isValidEmail(value)) {
                        return '* Email not valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formBloc.email = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: '',
                      counterText: "",
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your phone number';
                      }
                      // Add phone validation logic if needed
                      if (value.length != 10) {
                        return 'Number must contain 10 digits';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formBloc.phone = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    value: formBloc.gender!.isNotEmpty ? formBloc.gender : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        formBloc.gender = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                    items: <String>['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    value:
                        formBloc.country!.isNotEmpty ? formBloc.country : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        formBloc.country = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your country';
                      }
                      return null;
                    },
                    items: <String>['India'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your state';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formBloc.states = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      formBloc.city = value!;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          formBloc.clearValue(); // Clear dropdown values
                          _formKey.currentState?.reset();
                          Navigator.pop(context);// Reset form fields
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
