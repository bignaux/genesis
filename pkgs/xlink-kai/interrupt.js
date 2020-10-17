
// with this, we can join the chat without segfault
// and get the faulty access-violation context.
Process.setExceptionHandler(function (details) {

  // stop on undocumented or non-recoverable interruptions
  var bcontinue = Boolean(false);

  try {
    // details.address is a NativePointer
    switch (details.address.toInt32()) {

      case 0x572a58:
        // occurs after kai engine started.
        console.log('Known access-violation 0x572a58');
        bcontinue = true;
        // console.log(JSON.stringify(Process.findModuleByAddress(details.address)));
        // console.log(details.address.sub(moduleBase));
        break;
      case 0x573667:
        // Occurs when access to an arena with active server.
        // this make the webserver trashed ? so we exit.
        console.log('Known access-violation 0x573667');
        break;
      default:
        console.log(JSON.stringify(details));
        console.log(details.address.sub(moduleBase));
    }
    sleep(1);
  } catch (e) { console.error(error); } // send (2);
  return bcontinue;
});

// TODO : write example how deal with software write/read stuff in /nix/store
// using Interceptor.replace()
// getExportByName('libc.so',...) doesnt work ?
Interceptor.attach(Module.findExportByName(null, 'open'), {
  onEnter: function(args) {
    this.flag = false;
    var filename = Memory.readCString(ptr(args[0]));
    // var filename = args[0].readPointer().readCString();
    console.log('filename =', filename);
    // if (filename.endsWith(".xml")) {
    //   this.flag = true;
    //   var backtrace = Thread.backtrace(this.context, Backtracer.ACCURATE).map(DebugSymbol.fromAddress).join("\n\t");
    //   console.log("file name [ " + Memory.readCString(ptr(args[0])) + " ]\nBacktrace:" + backtrace);
    // }
  },
  onLeave: function(retval) {
    if (this.flag) // passed from onEnter
      console.warn("\nretval: " + retval);
  }
});
