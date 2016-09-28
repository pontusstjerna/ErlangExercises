-module(exerc).
-compile(export_all).

reverse([]) -> [];
reverse([X|[]]) -> X;
reverse([X|XS]) ->
    reverseHelp([X|XS],[]).
    
reverseHelp([], List) -> List;
reverseHelp([X|XS], List) ->
    reverseHelp(XS, [X] ++ List).
    
find(_, []) -> not_found;
find(Elem, [X|XS]) -> 
    if
        X == Elem -> {found, Elem};
        true      -> find(Elem, XS)
    end.
    
delete(Elem, List) ->
    deleteHelp(Elem, List, []).
    
deleteHelp(_, [], List) -> List;
deleteHelp(Elem, [X|XS], List) ->
    if
        X == Elem -> List ++ XS;
        true -> deleteHelp(Elem, XS, List ++ [X])
    end.
    
flatten2([Elem1,Elem2|List]) ->
    flatten2([Elem1 ++ Elem2] ++ List);
flatten2([List]) -> List.

square1([]) -> [];
square1([Elem|List]) -> [Elem*Elem|square1(List)].
    
square2(List) -> [X*X || X <- List].

square3(List) -> lists:map(fun(A) -> A*A end,List).

filter1(Predicate, List) ->
    [X||X <- List, Predicate(X)].
    
happyReceiver() -> 
    receive
        X -> io:fwrite("Yeeees! Someone said ~p to me!!\n", [X])
    end, 
    if
        X == "quit" -> ok;
        true -> happyReceiver()
    end.
