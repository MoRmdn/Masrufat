import 'package:flutter/material.dart';

import '../Providers/accounts_provider.dart';
import '../Widgets/add_account_widget.dart';

class AddAccount extends StatefulWidget {
  accountType? type;
  static const String routeNamed = '/addAccount';
  AddAccount({
    this.type,
  });

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final TextEditingController accNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.type = ModalRoute.of(context)!.settings.arguments as accountType;
    return Scaffold(
      appBar: AppBar(
        title: widget.type == accountType.credit
            ? const Text('Add Credit Account')
            : const Text('Add Debit Account'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.savings_rounded),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            RowBuilder(
                title: 'Account Name',
                lableTitle: 'Name',
                keyboardType: TextInputType.text,
                textController: accNameController),
            const SizedBox(
              height: 5,
            ),
            RowBuilder(
                title: 'Description',
                lableTitle: 'info',
                keyboardType: TextInputType.text,
                textController: descriptionController),
            const SizedBox(
              height: 5,
            ),
            RowBuilder(
                title: 'Balance',
                lableTitle: '00.0',
                keyboardType: TextInputType.number,
                textController: balanceController),
            const SizedBox(
              height: 5,
            ),
            RowBuilder(
                title: 'Account Name',
                lableTitle: 'Name',
                keyboardType: TextInputType.text,
                textController: accNameController),
          ],
        ),
      ),
    );
  }
}
