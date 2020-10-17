
// with this, we can join the chat without segfault
// and get the faulty access-violation context.
Process.setExceptionHandler(function (details) {
  try {
    sleep(1);
    // details.address is a NativePointer
    switch (details.address.toInt32()) {

      case 0x572a58:
        console.log('Known access-violation 0x572a58\r');
        break;
      case 0x573667:
        console.log('Known access-violation 0x573667\r');
        break;
      default:
        console.log(JSON.stringify(details));
        console.log(details.address.sub(moduleBase));
    }
  } catch (e) { } // send (2);
  return true;
});
