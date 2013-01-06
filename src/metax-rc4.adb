-----------------------------------------------------------
---
--                       MetaX.RC4                        --
------------------------------------------------------------
package body Metax.Rc4 is
   procedure Setup (This : in out Rc; Key : in Byte_Array) is
   begin
      C2a.Rc4_Set_Key (This.Key'Access, Key'Length, Key);
   end Setup;

   procedure Crypt
     (This : in out Rc;
      From : in Byte_Array;
      To   : in out Byte_Array)
   is
   begin
      C2a.Rc4 (This.Key'Access, From'Length, From, To);
   end Crypt;
end Metax.Rc4;
