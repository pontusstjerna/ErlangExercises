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