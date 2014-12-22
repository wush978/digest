#include <Rconfig.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include "pmurhash.h"

static const R_CallMethodDef callMethods [] = {
  { "PMurHash32", (DL_FUNC) &PMurHash32, 3 },
  { NULL, NULL, 0 }
};

void R_init_digest(DllInfo *info) {
    R_RegisterCCallable("digest", "PMurHash32",
                        (DL_FUNC) &PMurHash32);

    R_registerRoutines(info,
                       NULL,    /* slot for .C */
                       callMethods,   /* slot for .Call */
                       NULL,            /* slot for .Fortran */
                       NULL);     /* slot for .External */

    R_useDynamicSymbols(info, TRUE);    /* controls visibility */
}

