# Old good factory

Main obstacle in creating native experience on Flutter is the fact that you are asked to rebuild two layouts using platform specific widgets e.g. *CupertinoButton* and *FlatButton*, *CupertinoNavBar* ro *AppBar*.

Instead of writing entire layout twice why not make widgets aware of the platform and provide specific implementation.

Solution is to use abstract widget which will provide two (or more in the future) implementations. 

## Getting Started

For help getting started with Flutter, view our online
[documentation](http://flutter.io/).
