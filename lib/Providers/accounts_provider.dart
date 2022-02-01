import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/acount.dart';

enum accountType {
  credit,
  debit,
}

class AccountsProvider with ChangeNotifier {
  final List<Account> _accounts = [];

  List<Account> get accList {
    return [..._accounts];
  }
}
