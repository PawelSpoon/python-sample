import QtQuick 2.0
import io.thp.pyotherside 1.5

/***
 the needed wrapper to flaten method calls
 */

Python {
  id: python

  Component.onCompleted: {
    // connect error handler method with signal error
    setHandler('error', error_handler);
    // connect init handler method with signal init
    setHandler('init', init_handler);
    // connect 
    setHandler('doit', doit_handler);
    // needed for correct file resolution
    addImportPath(Qt.resolvedUrl('.'));
    // this imports a module (not needed here as pythonapp does it too)
    importModule('python.module1', function () {});
    // this imports a module and call setup function at once
    importModule('pythonapp', function () {
      // call with callback for longer lasting functions
      // modulename.object.method, params
      call_sync('pythonapp.app.setup', ['hello']);
      // modulename.object.method, params, callback fu
      //call('pythonapp.app.setup', ['hello'], function() {});
    });
  }

  Component.onDestruction: {

  }

  onError: {
    console.log('ERROR - unhandled error received:', traceback);
  }

  onReceived: {
    console.log('ERROR - unhandled data received:', data);
  }

  function error_handler(module_id, method_id, description) {
    console.log('Module ERROR - source:', module_id, method_id, 'error:', description);
    // do whatever you want here
  }

  function init_handler(success, message) {
    console.log(success,message);
    // you could tell your app that all is initialized
  }

  function doit_handler(success, message) {
    console.log(success,message);
    // you could tell your app that all is initialized
  }

  // here are your wrapper methods
  function doItSync(name) {
    console.log(call_sync('pythonapp.app.doit', [name]))
  }

  function doItAsync(name) {
    // the order shows the async behaviour
    console.log("immediate response: " + call('pythonapp.app.doit', [name], function(result) {
        console.log("callback response: " + result)
    }))
  }

  function doItWitSignal(name) {
    call('pythonapp.app.doit', ['hello'])
  }

}
