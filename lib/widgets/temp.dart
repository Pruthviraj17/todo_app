enum weeks {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

abstract class Parent {
  void helloBoloBeta() {
    print("Hello Uncle");
  }

  void uncleHarami();
}

abstract interface class HiddenGalliya {
  void nikalYahaSe();
  void saleKamine() {
    print("Uncle Kamine");
  }
}

class Child extends Parent implements HiddenGalliya {
  static const String name = 'Uncle';

  @override
  void uncleHarami() {
    print("Uncle Harami Hai");
  }

  @override
  void nikalYahaSe() {
    print("Uncle harami chal nikal yaha se");
  }

  @override
  void saleKamine() {
    print("Uncle sale kamine");
  }
}

void main() {
  // print("Hello World");
  // List<String> list = [];
  // list.addAll(
  //   weeks.values.map(
  //     (e) => e.name.toString(),
  //   ),
  // );
  // print(list);

  Child child = Child();
  child.helloBoloBeta();
  child.uncleHarami();
  child.nikalYahaSe();
  child.saleKamine();
  print(Child.name);
}
