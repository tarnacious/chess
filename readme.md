Description
-----------

Building out the ["Learning Haskell with Chess"][tutorial] tutorial as a very slow chess engine.
It can currently make moves (badly) and return possible moves.

ZeroMQ binding have been added so it can used by a socket server that coordinates players and games.

I intend to extend it to validate moves and eventually play ["Transfer Chess"][bughouse].

Dependencies
------------

Depends on the [zeromq-haskell][zmq-haskell] package.

Usage 
-----

An example of the format is parses and returns 

    $ cat start.json
    { 
      "Turn" : "White", 
      "Board" : [
                ["RB", "NB", "BB", "QB", "KB", "BB", "NB", "RB"], 
                ["PB", "PB", "PB", "PB", "PB", "PB", "PB", "PB"], 
                ["--", "--", "--", "--", "--", "--", "--", "--"], 
                ["--", "--", "--", "--", "--", "--", "--", "--"], 
                ["--", "--", "--", "--", "--", "--", "--", "--"], 
                ["--", "--", "--", "--", "--", "--", "--", "--"], 
                ["PW", "PW", "PW", "PW", "PW", "PW", "PW", "PW"], 
                ["RW", "NW", "BW", "QW", "KW", "BW", "NW", "RW"] 
                ]
    }

Play a couple of moves from the shell. Output no longer pretty formated :(

    $ cat start.json | runhaskell CliMove.hs | runhaskell CliMove.hs
    {"Turn":"White","Board":[["RB","NB","BB","QB","KB","BB","NB","RB"],["PB","PB","PB","PB","PB","PB","PB","--"],["--","--","--","--","--","--","--","PB"],["--","--","--","--","--","--","--","--"],["--","--","--","--","--","--","--","--"],["--","--","--","--","--","NW","--","--"],["PW","PW","PW","PW","PW","PW","PW","PW"],["RW","NW","BW","QW","KW","BW","--","RW"]]}

Start a zmq client

    $ runhaskell Client.hs

Start a zmq Server

    $ runhaskell Server.hs


[bughouse]: http://en.wikipedia.org/wiki/Bughouse_chess
[zmq-haskell]: http://hackage.haskell.org/package/zeromq-haskell
[tutorial]: http://www.haskell.org/haskellwiki/Learning_Haskell_with_Chess
