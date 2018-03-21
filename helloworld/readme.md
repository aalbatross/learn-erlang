Compiling and running erlang code:

1. Compiling and running from erlang shell
 a. cd to helloworld folder
 b. run erl command
 c. c(hello).  //c(<module-name>). compiles the module
 d. hello:start(). //call start method from hello module
 e. halt(). //exit the shell

2. Compiling and running from terminal
 a. erlc hello.erl //compiles hello module and create hello.beam file
 b. erl -noshell -s hello start -s init stop //execute start method in hello module and then stops the session

erlc and erl -noshell is used for automation and make scripts
