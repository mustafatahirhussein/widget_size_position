import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.deepPurple),
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isCallBackExecuted = false;
  GlobalKey globalKey = GlobalKey();
  Size size;
  Offset offset;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateSizeAndPosition();
    });
    super.initState();
  }

  calculateSizeAndPosition() {
    final RenderBox renderBox = globalKey.currentContext.findRenderObject();

    setState(() {
      offset = renderBox.localToGlobal(Offset.zero);
      size = renderBox.size;

      _isCallBackExecuted = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          "Get Widget's Size & Position",
          style: textStyle.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 70),
        child: _isCallBackExecuted
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loadWidgets(context, textStyle),
            Divider(),
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              title: Text(
                "Size",
                style: textStyle.copyWith(fontSize: 24),
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Height: ${size.height.toStringAsFixed(2)}",
                    style: textStyle.copyWith(fontSize: 25),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Width: ${size.width.toStringAsFixed(2)}",
                    style: textStyle.copyWith(fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              title: Text(
                "Position",
                style: textStyle.copyWith(fontSize: 24),
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "X: ${size.height.toStringAsFixed(2)}",
                    style: textStyle.copyWith(fontSize: 24),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Y: ${size.height.toStringAsFixed(2)}",
                    style: textStyle.copyWith(fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        )
            : loadWidgets(context, textStyle),
      ),
    );
  }

  loadWidgets(BuildContext context, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Card(
        elevation: 5,
        child: ListTile(
          key: globalKey,
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: FlutterLogo(),
          ),
          title: Text(
            "Widget's Position & Size",
            style: style.copyWith(fontSize: 24),
          ),
          subtitle: Text(
            "Easy Learning by Mustafa Tahir",
            style: style.copyWith(fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
