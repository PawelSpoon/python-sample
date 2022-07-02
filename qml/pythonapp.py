# this is the main entry point into your python app
#
#

import pyotherside
from python.module1.controller import Controller


class App:

    # define your setup code here
    def setup(self,param1):
        self.param1 = param1
        print(param1);
        self.ctrl = Controller()
        pyotherside.send('init',[True,"awesome"])

    def doit(self, name):
        return self.ctrl.DoIt(name)
        
    def doitandsignal(self, name):
        # this could take now forever ...
        greeting = self.ctrl.DoIt(name)
        pyotherside.send('doit',greeting)


app = App()
