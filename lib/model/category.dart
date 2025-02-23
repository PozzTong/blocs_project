enum Category {
  all,
  grocery,
  food,
  work,
  entertainment,
  traveling,
  other;

  String toJson ()=> name;
  static Category fromJson(String json)=>values.byName(json);
}

extension CategoryX on Category{
  String get toName => switch(this){
    Category.all => 'All',
    Category.entertainment =>'Entertainment',
    Category.food => 'Food',
    Category.grocery => 'Grocery',
    Category.work => 'Work',
    Category.traveling => 'Traveling',
    Category.other => 'Other',
  };
}