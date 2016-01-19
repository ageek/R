#!/bin/python
# @ahmed 


t = raw_input('New name for template file? ')
file_path = "./" + str(t)
f = file(file_path, 'a+')

n = raw_input('How many attributes ? ')
for x in range(1,int(n)+1) :
	f.write("@attribute att_%d numeric \n" % (x))

print "Successfully created template file: " + str(t)  +"\n"
