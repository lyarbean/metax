with Metax.Types;
with Metax.C2a;
------------------------------------------------------------
--                       MetaX.SHA2                       --
------------------------------------------------------------
package Metax.Sha2 is
   use types;
   type Sha is tagged limited private;
   procedure Initialize (This : in out Sha);
   procedure Update (This : in out Sha; Data : in Byte_Array);
   function Finalize (This : in Sha) return Md_Array;
private
   type Sha is tagged limited record
      State : aliased C2a.Sha256state_St;
   end record;
end Metax.Sha2;
