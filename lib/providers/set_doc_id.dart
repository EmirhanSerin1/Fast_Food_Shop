import 'package:flutter/widgets.dart';

class DocId extends ChangeNotifier{
  int _docId = 0;

  get docId => _docId;

  void increaseDocId(){
    _docId++;
    notifyListeners();
  }

  void cleanDocId(){
    _docId =0;
    notifyListeners();
  }

}