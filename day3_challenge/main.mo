import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycles "mo:base/ExperimentalCycles";
actor {
  public type Friend = Custom.Friends;
  public type Animal = Animal.Animal;
  let Man = {
    name = "Man";
    age = 10;
    gender = true;
  };
  let Tiger = {
    species = "Cat";
    energy = 100;
  };
  public func fun() : async Friend{
    return Man;
  };
  public func create_animal_that_take_a_break(spe : Text, egy : Nat) : async Animal{
    var pet = {
      species = spe;
      energy = egy;
    };
    return Animal.animal_sleep(pet);
  };
  var listAnimal : List.List<Animal> = List.nil();
  public func push_animal(ani : Animal) : async (){
    listAnimal := List.push(ani,listAnimal);
  };
  public func get_animal() : async [Animal]{
    return List.toArray(listAnimal);
  };
  public shared({caller}) func is_anonymous() : async Bool{
    return Principal.isAnonymous(caller);
  };
  var favoriteNumber = HashMap.HashMap<Principal,Nat>(0,Principal.equal,Principal.hash);
  public shared({caller}) func add_favorite_number(n : Nat) : async Text {
    var val : ?Nat = favoriteNumber.get(caller);
    switch(val){
      case null {
        favoriteNumber.put(caller,n);
        return "You've successfully registered your number";
      };
      case _ {
        return "You've already registered your number";
      };
    };
  };
  public shared({caller}) func show_favorite_number() : async ?Nat {
    return favoriteNumber.get(caller);
  };
  public shared({caller}) func update_favorite_number(num : Nat) : async (){
    var val : ?Nat = favoriteNumber.replace(caller,num);
  };
  public shared({caller}) func delete_favorite_number() : async Bool{
    switch(favoriteNumber.remove(caller)){
      case null return false;
      case _ return true;
    };
  };
};
