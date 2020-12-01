class Post{
  int _userID;
  int _id;
  String _title;
  String _body;

  Post(this._userID, this._id, this._title, this._body);

  Map toJson(){
    return  {
      "userId": this._userID,
      "id": this._id,
      "title": this.title,
      "body": this.body,
    };
  }

  String get body => _body;

  set body(String value) {
    _body = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get userID => _userID;

  set userID(int value) {
    _userID = value;
  }


}