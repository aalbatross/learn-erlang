Steps to run the program:
a. erl
b. c(fileserver).
c. c(fileclient).
d. FileServer = fileserver:start(".").
e. fileclient:ls(FileServer).
f. fileclient:get_file(FileServer,"myfile").
