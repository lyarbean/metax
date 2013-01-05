with System;
with Interfaces;
with Interfaces.C;
with Interfaces.C_Streams;
with Interfaces.C.Strings;
with Metax.Types;
package Metax.C2a is
   use Interfaces;
   use Interfaces.C;
   use Metax.Types;
   --  BIGNUM
   type Bignum_St is record
      D     : access unsigned_long;
      Top   : aliased int;
      Dmax  : aliased int;
      Neg   : aliased int;
      Flags : aliased int;
   end record;
   pragma Convention (C, Bignum_St);

   function Bn_Num_Bits (A : access constant Bignum_St) return int;
   pragma Import (C, Bn_Num_Bits, "BN_num_bits");

   function Bn_Bin2bn
     (S    : Byte_Array;
      Len  : int;
      Ret  : access Bignum_St)
      return access Bignum_St;
   pragma Import (C, Bn_Bin2bn, "BN_bin2bn");

   procedure Bn_Bn2bin
     (A  : access constant Bignum_St;
      To : in out Byte_Array);
   pragma Import (C, Bn_Bn2bin, "BN_bn2bin");

   procedure Bn_Free (A : access Bignum_St);
   pragma Import (C, Bn_Free, "BN_free");

   procedure Bn_Clear (A : access Bignum_St);
   pragma Import (C, Bn_Clear, "BN_clear");

   procedure Bn_Clear_Free (A : access Bignum_St);
   pragma Import (C, Bn_Clear_Free, "BN_clear_free");

   function Bn_Dup
     (A    : access constant Bignum_St)
      return access Bignum_St;
   pragma Import (C, Bn_Dup, "BN_dup");
   --  DH

   type Crypto_Ex_Data_St is record
      Sk    : access System.Address;
      Dummy : aliased int;
   end record;
   pragma Convention (C_Pass_By_Copy, Crypto_Ex_Data_St);

   type Dh_St is record
      Pad           : aliased int;
      Version       : aliased int;
      P             : access Bignum_St;
      G             : access Bignum_St;
      Length        : aliased long;
      Pub_Key       : access Bignum_St;
      Priv_Key      : access Bignum_St;
      Flags         : aliased int;
      Method_Mont_P : access System.Address;
      Q             : access Bignum_St;
      J             : access Bignum_St;
      Seed          : access unsigned_char;
      Seedlen       : aliased int;
      Counter       : access Bignum_St;
      References    : aliased int;
      Ex_Data       : aliased Crypto_Ex_Data_St;
      Meth          : access constant System.Address;
      The_Engine    : System.Address;
   end record;
   pragma Convention (C_Pass_By_Copy, Dh_St);
   type Anon_26 (Discr : unsigned := 0) is record
      case Discr is
         when 0 =>
            Ptr : Interfaces.C.Strings.chars_ptr;
         when 1 =>
            Rsa : System.Address;
         when 2 =>
            Dsa : System.Address;
         when 3 =>
            Dh : System.Address;
         when others =>
            Ec : System.Address;
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, Anon_26);
   type Evp_Pkey_St is record
      C_Type          : aliased int;
      Save_Type       : aliased int;
      References      : aliased int;
      Ameth           : System.Address;
      The_Engine      : System.Address;
      Pkey            : Anon_26;
      Save_Parameters : aliased int;
      Attributes      : System.Address;
   end record;
   pragma Convention (C_Pass_By_Copy, Evp_Pkey_St);

   procedure Evp_Pkey_Free (Pkey : access Evp_Pkey_St);
   pragma Import (C, Evp_Pkey_Free, "EVP_PKEY_free");

   function Dh_New return access Dh_St;
   pragma Import (C, Dh_New, "DH_new");

   procedure Dh_Free (The_Dh : access Dh_St);
   pragma Import (C, Dh_Free, "DH_free");

   function Dh_Size (The_Dh : access constant Dh_St) return int;
   pragma Import (C, Dh_Size, "DH_size");

   function Pem_Read_Dhparams
     (Fp   : Interfaces.C_Streams.FILEs;
      X    : System.Address;
      Cb   : access function
     (Arg1 : Interfaces.C.Strings.chars_ptr;
      Arg2 : int;
      Arg3 : int;
      Arg4 : System.Address)
      return int;
      U    : System.Address)
      return access Dh_St;
   pragma Import (C, Pem_Read_Dhparams, "PEM_read_DHparams");

   function Dh_Generate_Parameters_Ex
     (The_Dh    : access Dh_St;
      Prime_Len : int;
      Generator : int;
      Cb        : System.Address)
      return      int;
   pragma Import
     (C,
      Dh_Generate_Parameters_Ex,
      "DH_generate_parameters_ex");

   function Dh_Compute_Key
     (Key     : Byte_Array;
      Pub_Key : access constant Bignum_St;
      The_Dh  : access Dh_St)
      return    int;
   pragma Import (C, Dh_Compute_Key, "DH_compute_key");
   function Pem_Read_Privatekey
     (Fp   : Interfaces.C_Streams.FILEs;
      X    : System.Address;
      Cb   : access function
     (Arg1 : Interfaces.C.Strings.chars_ptr;
      Arg2 : int;
      Arg3 : int;
      Arg4 : System.Address)
      return int;
      U    : System.Address)
      return access Evp_Pkey_St;
   pragma Import (C, Pem_Read_Privatekey, "PEM_read_PrivateKey");
   --  AUX
   function Get_Dh (Pkey : access Evp_Pkey_St) return access Dh_St;
   pragma Import (C, Get_Dh, "get_DH");
   --  RSA
   type Rsa_St is record
      Pad            : aliased int;
      Version        : aliased long;
      Meth           : System.Address;
      The_Engine     : System.Address;
      N              : access Bignum_St;
      E              : access Bignum_St;
      D              : access Bignum_St;
      P              : access Bignum_St;
      Q              : access Bignum_St;
      Dmp1           : access Bignum_St;
      Dmq1           : access Bignum_St;
      Iqmp           : access Bignum_St;
      Ex_Data        : aliased System.Address;
      References     : aliased int;
      Flags          : aliased int;
      U_Method_Mod_N : System.Address;
      U_Method_Mod_P : System.Address;
      U_Method_Mod_Q : System.Address;
      Bignum_Data    : Strings.chars_ptr;
      Blinding       : System.Address;
      Mt_Blinding    : System.Address;
   end record;
   pragma Convention (C_Pass_By_Copy, Rsa_St);  --  /usr/include/openssl
                                                --/rsa.h:129
   function Rsa_New return access Rsa_St;
   pragma Import (C, Rsa_New, "RSA_new");
 --  RC4
   procedure Rc4_Set_Key
     (Key  : access Rc4_Key_St;
      Len  : int;
      Data : Byte_Array);
   pragma Import (C, Rc4_Set_Key, "RC4_set_key");

   procedure Rc4
     (Key     : access Rc4_Key_St;
      Len     : size_t;
      Indata  : Byte_Array;
      Outdata : in out Byte_Array);
   pragma Import (C, Rc4, "RC4");
end Metax.C2a;
