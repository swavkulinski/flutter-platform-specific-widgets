import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_switch_lab/platform_widget.dart';

void main() {
  //debugPaintLayerBordersEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _switch = new List.filled(30, false);

  @override
  Widget build(BuildContext context) {
    return new PlatformScaffold(
        title: "Here we go!",
        child: new ListView.builder(
          itemCount: _switch.length,
          itemBuilder: (context, index) => new ItemWidget(
                child: new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Flex(
                      direction: Axis.horizontal,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        _imageWidget('/assets/images/dummy.jpg'),
                        _spacerWidget,
                        _titleAndDescriptionWidget('title', index),
                        _switchWidget(index),
                      ]),
                ),
              ),
        ));
  }

  Widget _imageWidget(imageAsset) => new Flexible(
        flex: 4,
        fit: FlexFit.tight,
        child: new Image.asset(imageAsset),
      );

  final _spacerWidget = new ConstrainedBox(
    constraints: const BoxConstraints.tightFor(width: 10.0),
  );

  Widget _titleAndDescriptionWidget(title, index) => new Flexible(
      flex: 4,
      fit: FlexFit.tight,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Text(
            "$title $index ",
            style: Theme.of(context).textTheme.display1,
          ),
          new Text(
            "desctiption goes here",
            style: Theme.of(context).textTheme.body1,
          ),
        ],
      ));

  Widget _switchWidget(index) => new Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: new PlatformSwitch(
          onChanged: (value) => setState(() => _switch[index] = value),
          value: _switch[index],
        ),
      );
}

class PlatformScaffold extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  final String title;
  final Widget child;

  PlatformScaffold({this.title, this.child});

  @override
  Scaffold createAndroidWidget(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: child,
    );
  }

  @override
  CupertinoPageScaffold createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return new CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        middle: new Text(title),
      ),
      child: child,
    );
  }
}

class PlatformButton extends PlatformWidget<CupertinoButton, RaisedButton> {
  final VoidCallback onPressed;
  final Widget child;

  PlatformButton({this.child, this.onPressed});

  @override
  RaisedButton createAndroidWidget(BuildContext context) {
    return new RaisedButton(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  CupertinoButton createIosWidget(BuildContext context) {
    return new CupertinoButton(
      child: child,
      onPressed: onPressed,
      color: Colors.blue,
    );
  }
}

class PlatformSwitch extends PlatformWidget<CupertinoSwitch, Switch> {
  final onChanged;
  final value;

  PlatformSwitch({this.onChanged, this.value});

  @override
  Switch createAndroidWidget(BuildContext context) {
    return new Switch(
      onChanged: onChanged,
      value: value,
    );
  }

  @override
  CupertinoSwitch createIosWidget(BuildContext context) {
    return new CupertinoSwitch(
      onChanged: onChanged,
      value: value,
    );
  }
}

class ItemWidget extends PlatformWidget<Widget, Widget> {
  final Widget child;

  ItemWidget({this.child});

  @override
  Widget createAndroidWidget(BuildContext context) => new Card(
        child: child,
      );
  @override
  Widget createIosWidget(BuildContext context) => child;
}
