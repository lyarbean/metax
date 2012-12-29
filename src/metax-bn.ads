with MetaX.Types;
use MetaX.Types;
with Interfaces.C;
package MetaX.Bn is
   pragma Elaborate_body;
   type bignumber is tagged limited private;
   function bytes_length(number : bignumber) return integer;
   function to_binary(number : bignumber) return byte_array;
   function from_binary(binary: byte_array) return bignumber;
   procedure clear(number : bignumber);
   procedure free(number : bignumber);
   procedure clear_free(number : bignumber);
   use Interfaces.C;
   type bignum_st is record
      d : access unsigned_long;
      top : aliased int;
      dmax : aliased int;
      neg : aliased int;
      flags : aliased int;
   end record;
   pragma Convention (C_Pass_By_Copy, bignum_st);
   private
   type bignumber is tagged limited record
      number : access bignum_st;
   end record;
end MetaX.Bn;
