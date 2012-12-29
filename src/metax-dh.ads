with System;
with Interfaces.C;
with Interfaces.C.Strings;
with interfaces.C_Streams;
with MetaX.Types;
with MetaX.Bn;
use MetaX.Types;
use MetaX.Bn;
use Interfaces.C;
package MetaX.Dh is
   pragma Elaborate_body;
   type dh is tagged limited private;

   function create return dh;
   function from_pem(path : string) return dh;


--  
   type crypto_ex_data_st is record
      sk : access System.Address;
      dummy : aliased int;
   end record;
   pragma Convention (C_Pass_By_Copy, crypto_ex_data_st);

   type dh_st is record
      pad : aliased int;
      version : aliased int;
      p : access bignum_st;
      g : access bignum_st;
      length : aliased long;
      pub_key : access bignum_st;
      priv_key : access bignum_st;
      flags : aliased int;
      method_mont_p : access System.Address;
      q : access bignum_st;
      j : access bignum_st;
      seed : access unsigned_char;
      seedlen : aliased int;
      counter : access bignum_st;
      references : aliased int;
      ex_data : aliased crypto_ex_data_st; 
      meth : access constant System.address;
      the_engine : System.Address;
   end record;
   pragma Convention (C_Pass_By_Copy, dh_st);

   function DH_new return access dh_st;
   pragma Import (C, DH_new, "DH_new");

   procedure DH_free (the_dh : access dh_st);
   pragma Import (C, DH_free, "DH_free");

   function DH_size (the_dh : access constant dh_st) return int;
   pragma Import (C, DH_size, "DH_size");

   function PEM_read_DHparams
      (fp : access Interfaces.C_Streams.FILEs;
      x : System.Address;
      cb : access function (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : int; arg3 : int; arg4 : System.Address) return int;
      u : System.Address) return access dh_st;
      pragma Import (C, PEM_read_DHparams, "PEM_read_DHparams");
      private
      type dh is tagged limited record
         context : access dh_st;
      end record;
end MetaX.Dh;
