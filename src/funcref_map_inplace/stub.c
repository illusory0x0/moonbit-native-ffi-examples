#include <moonbit.h>

typedef void *moonbit_closure_t;

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