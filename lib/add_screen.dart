import 'package:flutter/material.dart';
import 'package:todoapp/contactModel.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // List contactList = [];
  List<Map<String, String>> contactList = [];

  _addcontact() {
    contactList.add(
        {'name': _nameTEController.text, 'number': _contactController.text});
    setState(() {});

    _nameTEController.clear();
    _contactController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff667C89),
        title: const Text(
          "Contact List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      hintText: 'Name', labelText: 'Name'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your  name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      hintText: 'Number', labelText: 'Number'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Contact Number ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addcontact();
                    }
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8.00, right: 8.00),
                          child: Container(
                            height: 100,
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Icon(Icons.person),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(' ${contactList[index]["name"]}'),
                                        Text(
                                            ' ${contactList[index]["number"]}'),
                                      ]),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: IconButton(
                                      icon: const Icon(Icons.phone),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Confirmation'),
                                              content: const Text(
                                                  'Are you sure for  delete ?'),
                                              actions: [
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.cancel),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    // _deleteProduct(productId);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                      // return ListTile(
                      //   title: Icon(Icons.phone),
                      //   subtitle: Wrap(
                      //     spacing: 16,
                      //     children: [
                      //       Text('Unit Price: ${contactList[index]["name"]}'),
                      //       Text('Quantity : ${contactList[index]["number"]}'),
                      //     ],
                      //   ),
                      //   trailing: Wrap(
                      //     children: [
                      //       IconButton(
                      //         icon: const Icon(Icons.phone),
                      //         onPressed: () {
                      //           // _showDeleteConfirmationDialog(product.id!);
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // );
                    },
                    // separatorBuilder: (_, __) => const Divider(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _contactController.dispose();
    super.dispose();
  }
}
