with Interfaces.C;use Interfaces.C;
with Metax.Types;  use Metax.Types;
------------------------------------------------------------
--                       MetaX.SHA2                       --
------------------------------------------------------------
package Metax.Sha2 is
   subtype Md_Array is Byte_Array (1 .. 32);
   type Sha is tagged limited private;
   procedure Initialize (This : in out Sha);
   procedure Update (This : in out Sha; Data : in Byte_Array);
   function Finalize (This : in Sha) return Md_Array;
private
   type Sha256state_St is record
      H      : aliased Unsigned_Array (0 .. 7);
      Nl     : aliased unsigned;
      Nh     : aliased unsigned;
      Data   : aliased Unsigned_Array (0 .. 15);
      Num    : aliased unsigned;
      Md_Len : aliased unsigned;
   end record;
   pragma Convention (C_Pass_By_Copy, Sha256state_St);
   type Sha is tagged limited record
      State : aliased Sha256state_St;
   end record;
   Error : exception;
end Metax.Sha2;
