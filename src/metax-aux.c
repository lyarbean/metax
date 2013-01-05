#include <openssl/evp.h>

// Get a ref, not deep copy
DH * get_DH (struct evp_pkey_st *pkey)
{
    if (pkey->type != EVP_PKEY_DH)
    {
        return 0;
    }
    return pkey->pkey.dh;
}



