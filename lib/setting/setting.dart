import 'package:expenses_tracker/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeProvider>(
        builder: (ctx, provider, __) {
          return SwitchListTile.adaptive(
            value: provider.getValue(),
            onChanged: (value) {
              provider.updateTheme(value: value); // pass the value here
            },
            title: Text("Dark mode"),
            subtitle: Text("change theme mode here"),
          );
        },
      ),
    );
  }
}
