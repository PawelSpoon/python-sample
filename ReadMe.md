# General
this template is just an update of the existing provided by jolla
jolla's template demonstrates background threads and signals, but it does not demonstrate
how to implement the main part in python and link it with qml

# How to use
the template does not include any python tests
in my case i have python files + scripts elsewhere and just copy the .py modules (== folders) into qml
i do preffer a single point of entry, that's why applicationWindow has python property, but you can declare the python interpreter on each page
 (as the jolla exampledoes ). according to docu they share the context. and this seems to be true: click on the upload button, python handler 
 receives the events and complains they are not handled
 
- you have your python logic with one or more main objects
- extend pythonapp.py and create an object of each (in my case it was app=App())


# Tips
- you can not do that with pyotherside: call('pythonapp.app.getcontroller('x').createsomething('b')
 so while your python object can look like that, your py wrapper needs to flatten in into something like:
 call('pythonapp.app.createsomething_withcontroller('x','b')
- check the data structures, dict() list() conversion is quite funny
 it is eaier to stick to just one, preferably dict() imho
- as last: keep in mind that there is no byref concept in python !
  app.controller and the controller that you use in qml may ran out of sync


# Issues
my feeling is: python scripts get only updated when you deploy as RPM, not via copy
