class User {
  const User(this.name, this.age);
  final String name;
  final int age;

  @override
  String toString() {
    return 'Name: $name, age: $age';
  }
}
