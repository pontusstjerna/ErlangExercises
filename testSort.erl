-module(testSort).
-compile(export_all).

sort(List) -> 
    DummyProcess = spawn(testSort, dummy, []),
    sortHelp(List ++ [0], DummyProcess, []).

dummy() ->
        receive
            0 -> io:fwrite("------------\nYay, we're done!\n")
        end.

sortHelp(List, RightChannel, Processes) ->
    io:fwrite("Spawning. Current processes: ~p\n", [Processes]),
    NewRC = spawn(testSort, process, [RightChannel, 0]),
    if 
        length(Processes) == length(List) -1 -> 
            sortHelp(List, NewRC, Processes ++ NewRC),
            startSorting(List, NewRC);
        length(Processes) < length(List) -> sortHelp(List, NewRC, Processes ++ [NewRC]);
        true -> ok
    end.
    
startSorting(List, P1) -> [P1 ! X || X <- List].

process(RightChannel, Di) ->
    io:fwrite("My current number: ~p\n", [Di]),
    receive
        0 -> RightChannel ! 0,
             io:fwrite("Termination, I got: ~p\n",[Di]);
        X ->
            if
                Di == 0 -> process(RightChannel, X); %Set initial value
                X < Di ->                      %Update value, send old value
                    RightChannel ! Di,
                    process(RightChannel, X);
                true -> 
                    RightChannel ! X,          %Simply pass the value to the right
                    process(RightChannel, Di)
            end
    end.