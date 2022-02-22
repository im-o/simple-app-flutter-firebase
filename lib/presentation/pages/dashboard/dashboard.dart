import 'package:flutter/material.dart';

import '../../../utils/color_util.dart';
import '../../../utils/text_util.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: ColorUtil.colorPrimary),
        title: const Text("Dashboard", style: TextUtil.textStyle18),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: const Icon(
              Icons.edit,
              color: ColorUtil.colorPrimary,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Icon(
              Icons.exit_to_app,
              color: ColorUtil.colorPrimary,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
            ),
          )
        ],
      ),
      body: _dashboardBody(),
    );
  }

  Widget _dashboardBody() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Rival test $index"),
            subtitle: Text("Age: 2$index"),
            leading: const CircleAvatar(
              child: Image(
                image: AssetImage(""),
              ),
            ),
            trailing: Text("Score : 10$index"),
          ),
        );
      },
    );
  }
}
