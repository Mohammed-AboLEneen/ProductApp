class AvaiableProperties {
  AvaiableProperties({
    String? property,
    List<Values>? values,}){
    _property = property;
    _values = values;
  }

  AvaiableProperties.fromJson(dynamic json) {
    _property = json['property'];
    if (json['values'] != null) {
      _values = [];
      json['values'].forEach((v) {
        _values?.add(Values.fromJson(v));
      });
    }
  }
  String? _property;
  List<Values>? _values;

  String? get property => _property;
  List<Values>? get values => _values;
}

class Values {
  Values({
    String? value,
    num? id,}){
    _value = value;
    _id = id;
  }

  Values.fromJson(dynamic json) {
    _value = json['value'];
    _id = json['id'];
  }
  String? _value;
  num? _id;

}