import 'dart:developer' as developer;
import 'dart:math';
import '../model/sequence.dart';
import '../classes/colorset.dart';

// This Settings class creates a "singleton" which
// I am using as our Global State Object

class Settings {
  int _boardSize;
  bool _boardCreated;
  List _boardList;
  int _sequenceLength;
  int initialBoardSize = 5;
  int initialSequenceLength = 4;
  int _minBoardSize = 3;
  int _maxBoardSize = 10;
  int _minSequenceLength = 3;
  int _maxSequenceLength = 10;
  bool _showSequence;
  Sequence _sequence;
  Colorset _myColorSet;
  int _colorIndex = 0;
  int _minColorIndex = 0;
  int _maxColorIndex =2;
  // List _sequenceIndexes = [];

  //Settings( this._boardSize, this._sequenceLength);

  // Singleton settings object
  static final Settings _settings = Settings._internal();

  // Internal Named constructor
  Settings._internal();

  factory Settings() {
    // return the singleton object
    return _settings;
  }
  // Named Constructor could look like this:
  // Options.withColor( this.color, this.boardSize, this.sequenceLength)
  // colorset get color => color;
  //This is a "getter" for the color value
//  int get boardSize => _boardSize;

  int get minBoardSize => _minBoardSize;
  int get maxBoardSize => _maxBoardSize;
  int get colorIndex => _colorIndex;
  int get minColorIndex => _minColorIndex;

  int get minSequenceLength => _minSequenceLength;
  int get maxSequenceLength => _maxSequenceLength;

  int get maxColorIndex{
    if (_maxColorIndex == null) {
      _maxColorIndex = 2;
    }
    return _maxColorIndex;
  }


  Sequence get sequence {
    if (_sequence == null) {
      _sequence = new Sequence(_sequenceLength, _boardSize);
    }
    return _sequence;
  }
  //List get sequenceIndexes => _sequenceIndexes;

  void freshBoardList() {
    _boardList = [];
    // developer.log("Inside freshBoardList: " + _boardSize.toString());
    for (var i = 0; i < (_boardSize * _boardSize); i++) {
      // developer.log("_boardList: " + _boardList.toString());
      _boardList.add(false);
    }
    _sequence = new Sequence(_sequenceLength, _boardSize);
    _sequence.generateRandomSequence(sequenceLength);
    // developer.log("_boardList: " + _boardList.toString());
  }

  void toggleTile(index) {
    _boardList[index] = !_boardList[index];
    // developer.log("toggleing tile.");
  }

  bool get showSequence {
    if (_showSequence == null) {
      _showSequence = false;
    }
    return _showSequence;
  }

  int get boardSize {
    if (_boardSize == null) {
      _boardSize = initialBoardSize;
    }
    return _boardSize;
  }

  bool get boardCreated {
    if (_boardCreated == null) {
      _boardCreated = false;
    }
    return _boardCreated;
  }

  List get boardList {
    if (_boardList == null) {
      _boardList = [];
    }

    return _boardList;
  }
  //  int get sequenceLength => _sequenceLength;

  int get sequenceLength {
    if (_sequenceLength == null) {
      _sequenceLength = initialSequenceLength;
    }
    return _sequenceLength;
  }

  Colorset get myColorSet {
    if (_myColorSet == null) {
      _myColorSet = new Colorset(_colorIndex);
    }
    return _myColorSet;
  }

  set colorIndex(newIndex) {
    _colorIndex = newIndex;
    _myColorSet = Colorset(_colorIndex);
  }

  set myColorSet(newSet) {
    _myColorSet = Colorset(newSet);
  }

  set boardSize(int newSize) {
    _boardSize = newSize;
    _sequence = null;
    _boardList = null;
  }


  set sequenceLength(int newSequenceLength) {
    if (newSequenceLength <=maxSequenceLength && newSequenceLength >= minSequenceLength) {
      _sequenceLength = newSequenceLength;
    }
    _sequence = null;
    _boardList = null;
  }

  set showSequence(bool newShowSequence) {
    _showSequence = newShowSequence;
  }

  set sequence(Sequence newSequence) {
    _sequence = newSequence;
    _boardCreated = true;
    developer.log("board created: true");
  }


  set boardCreated(bool newBoardCreated) {
    developer.log("Changing board created bool");
    _boardCreated = newBoardCreated;
  }


  void toggleShowSequence() {
    if (_showSequence == null) {
      _showSequence = false;
    }
    _showSequence = !_showSequence;
  }
// A Collection of key value pairs
// Maps can be iterated
// String is the key
// Dynamic data type as the value
// This method will transform our Options Class into a Map so that
// we can manipulate it and transform it
// This is more useful when using SQLite (database storage)

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["boardSize"] = _boardSize;
    map["sequenceLength"] = _sequenceLength;

    return map;
  }

  // This is the reverse of the map method

  // Another NAMED CONSTRUCTOR

  Settings.fromObject(dynamic o) {
    this._boardSize = o["boardSize"];
    this._sequenceLength = o["sequenceLength"];
  }
}
