with Interfaces.C;use Interfaces.C;
with Metax.Types;  use Metax.Types;
------------------------------------------------------------
--                       MetaX.RC4                        --
------------------------------------------------------------
package Metax.Rc4 is
   type Rc is tagged limited private;
   procedure Setup (This : in out Rc; Key : in Byte_Array);
   procedure Crypt
     (This : in out Rc;
      From : in Byte_Array;
      To   : in out Byte_Array);
private
   type Rc4_Key_St is record
      X    : aliased unsigned;
      Y    : aliased unsigned;
      Data : aliased Unsigned_Array (0 .. 255);
   end record;
   pragma Convention (C_Pass_By_Copy, Rc4_Key_St);
   type Rc is tagged limited record
      Key : aliased Rc4_Key_St;
   end record;
   Error : exception;
end Metax.Rc4;
