module{
    public type List<T> = ?(T,List<T>);
    public func is_null<T>(list : List<T>) : Bool {
        switch(list){
            case (null) return true;
            case (_) return false;
        };
    };
    public func last<T>(list : List<T>) : ?T {
        switch(list){
            case (null) return null;
            case (?(z,null)) return ?z;
            case (?(_,next_list)) return last(next_list);
        };
    };
    public func size<T>(list : List<T>) : Nat {
        var n : Nat = 0;
        switch(list){
            case null return n;
            case (?(_,null)) return n + 1;
            case (?(_,next_list)) return 1 + size(next_list);            
        };
    };
    public func get<T>(list : List<T>, num : Nat) : ?T {
        switch(list, num){
            case (null,_) return null;
            case (?(f,next),0) return ?f;
            case (?(_,next),_) return get<T>(next,num - 1);
        };
    };
}