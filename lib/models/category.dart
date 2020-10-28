class Category {
  String name;
  String imageUrl;

  Category({this.name, this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      imageUrl: json['category_image'],
    );
  }

  @override
  String toString() => "Category name: $name";
}