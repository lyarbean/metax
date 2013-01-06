with Metax.Types, Metax.C2a;
------------------------------------------------------------
--                       MetaX.RC4                        --
------------------------------------------------------------
package Metax.Rc4 is
   use Types;
   type Rc is tagged limited private;
   procedure Setup (This : in out Rc; Key : in Byte_Array);
   procedure Crypt
     (This : in out Rc;
      From : in Byte_Array;
      To   : in out Byte_Array);
private
   type Rc is tagged limited record
      Key : aliased C2a.Rc4_Key_St;
   end record;
end Metax.Rc4;
