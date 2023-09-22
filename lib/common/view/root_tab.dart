import 'package:code_factory_middle/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RootTab extends StatelessWidget {
  const RootTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Container(
        child: const Center(
          child: Text('Root tab'),
        ),
      ),
    );
  }
}
