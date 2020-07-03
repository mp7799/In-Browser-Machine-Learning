library common_js;

import 'dart:async';
import 'dart:js';

class Promise<T> {
//   external Promise(void executor(void resolve(T result), Function reject));

//   external Promise then(void onFulfilled(T result), [Function onRejected]);
// }

// Future<T> promiseToFuture<T>(promise) {
//   final c = Completer<T>();
//   final success = convertDartClosureToJS((r) => completer.complete(r), 1);
//   final error = convertDartClosureToJS((e) => completer.completeError(e), 1);

//   JS('', '#.then(#, #)', jsPromise, success, error);
//   promise.then(allowInterop(c.complete), allowInterop(c.completeError));
//   return c.future;
}