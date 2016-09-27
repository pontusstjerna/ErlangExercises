-module(exerc).
-compile(export_all).

reverse([]) -> [];
reverse([X|[]]) -> X;
reverse([X|XS]) ->
    reverseHelp([X|XS],[]).
    
reverseHelp([], List) -> List;
reverseHelp([X|XS], List) ->
    reverseHelp(XS, [X] ++ List).
    
