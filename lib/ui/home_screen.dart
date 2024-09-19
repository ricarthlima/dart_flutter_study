import 'package:dart_flutter/models/account.dart';
import 'package:dart_flutter/services/account_service.dart';
import 'package:dart_flutter/ui/upinsert_account_modal.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Account>> _refreshFuture = AccountService().getAll();

  Future<void> _refresh() async {
    setState(() {
      _refreshFuture = AccountService().getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema de Gestão de Contas"),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "login");
            },
            icon: const Icon(Icons.logout),
            tooltip: "Sair",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showUpinsertAccount(context).then(
            (value) {
              _refresh();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: FutureBuilder<List<Account>>(
              future: _refreshFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Nenhuma conta encontrada"));
                }

                List<Account> listAccount = snapshot.data!;

                return ListView(
                  children: List<Widget>.generate(
                        listAccount.length,
                        (index) {
                          Account account = listAccount[index];
                          return AccountWidget(account: account);
                        },
                      ) +
                      [const SizedBox(height: 128)],
                );
              }),
        ),
      ),
    );
  }
}

class AccountWidget extends StatelessWidget {
  final Account account;
  const AccountWidget({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[300],
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${account.name} ${account.lastName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Row(
                children: [
                  const Text(
                    "ID: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(account.id, overflow: TextOverflow.ellipsis),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Saldo: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("R\$ ${account.balance.toStringAsFixed(2)}"),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Tipo: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(account.accountType ?? "Sem tipo de conta declarado."),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Em breve, configurações de conta."),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
