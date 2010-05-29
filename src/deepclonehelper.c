/*
 * deepclonehelper.c - helper functions for DeepClone
 */

/*
 * These functions horribly break encapsulation on PMCs. Yes, I'm a horrible person.
 *
 * P.S.: HORRIBLE!!!
 */
#include <parrot/parrot.h>

PARROT_DYNEXT_EXPORT
INTVAL
pmc_addr(PARROT_INTERP, PMC *obj) {
    return (INTVAL)obj;
}

PARROT_DYNEXT_EXPORT
PMC *
pmc_get_meta(PARROT_INTERP, PMC *obj) {
    return PMC_metadata(obj);
}

PARROT_DYNEXT_EXPORT
void
pmc_set_meta(PARROT_INTERP, PMC *obj, PMC *meta) {
    PMC_metadata(obj) = meta;
}

PARROT_DYNEXT_EXPORT
INTVAL
pmc_typenum(PARROT_INTERP, PMC *obj) {
    return obj->vtable->base_type;
}

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
