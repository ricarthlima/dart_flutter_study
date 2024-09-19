import 'package:dart_flutter/models/account.dart';
import 'package:dart_flutter/services/account_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

Future<dynamic> showUpinsertAccount(BuildContext context) {
  String accountType = "AMBROSIA";
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool isLoading = false;
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Form(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Adicionar nova conta",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      label: Text("Nome"),
                      prefixIcon: Icon(Icons.people),
                    ),
                  ),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      label: Text(
                        "Último nome",
                      ),
                      prefixIcon: Icon(Icons.people),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Tipo da conta"),
                  DropdownButton<String>(
                    value: accountType,
                    items: const [
                      DropdownMenuItem<String>(
                        value: "AMBROSIA",
                        child: Text("Ambrosia"),
                      ),
                      DropdownMenuItem<String>(
                        value: "CANJICA",
                        child: Text("Canjica"),
                      ),
                      DropdownMenuItem<String>(
                        value: "PUDIM",
                        child: Text("Pudim"),
                      ),
                      DropdownMenuItem<String>(
                        value: "BRIGADEIRO",
                        child: Text("Brigadeiro"),
                      ),
                    ],
                    isExpanded: true,
                    iconSize: 24,
                    onChanged: (value) {
                      setState(() {
                        accountType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (!isLoading) {
                        setState(() {
                          isLoading = true;
                        });
                        Account account = Account(
                          id: const Uuid().v1(),
                          name: nameController.text,
                          lastName: lastNameController.text,
                          balance: 0,
                          accountType: accountType,
                        );
                        AccountService().addAccount(account).then(
                          (value) {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                    child: (isLoading)
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Adicionar"),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
