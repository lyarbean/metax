with Interfaces;
with Interfaces.C;
with Metax.Types;
with Metax.C2a;
package Metax.Bn is
   pragma Elaborate_Body;
   use Interfaces.C;
   use Metax.Types;
   use Metax.C2a;
   type Bignumber is tagged limited private;
   function Bytes_Length (Number : Bignumber) return Integer;
   function To_Binary (Number : Bignumber) return Byte_Array;
   function From_Binary (Binary : Byte_Array) return Bignumber;
   procedure Clear (Number : Bignumber);
   procedure Free (Number : Bignumber);
   procedure Clear_Free (Number : Bignumber);
private
   type Bignumber is tagged limited record
      Number : access Bignum_St;
   end record;
end Metax.Bn;
