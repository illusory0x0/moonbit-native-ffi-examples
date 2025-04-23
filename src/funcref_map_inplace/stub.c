#include <moonbit.h>

typedef void *moonbit_closure_t;

// `call` indicates how to consume `closure`
void register_callback(void (*call)(moonbit_closure_t),
                       moonbit_closure_t closure) {
  moonbit_incref(closure);
  // call closure before must insert `moonbit_incref`
  // https://github.com/moonbitlang/moonbit-docs/issues/664
  call(closure); // call closure directly

  moonbit_incref(closure);
  call(closure);

  moonbit_incref(closure);
  call(closure);
}

typedef void *moonbit_point_t;

void ffi_map_inplace(moonbit_point_t *xs,
                     moonbit_point_t (*call)(moonbit_closure_t,
                                             moonbit_point_t),
                     moonbit_closure_t closure) {
  int len = Moonbit_array_length(xs);

  for (int i = 0; i < len; ++i) {
    moonbit_incref(closure);

    xs[i] = call(closure, xs[i]);
    
    moonbit_incref(closure);
    xs[i] = call(closure, xs[i]);
  }
}