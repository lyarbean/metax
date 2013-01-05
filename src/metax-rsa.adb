with Ada.Streams.Stream_IO;
with Ada.Streams.Stream_IO.C_Streams;
------------------------------------------------------------
--                         MetaX.rsa                       --
------------------------------------------------------------
package body Metax.Rsa is

   function Rsa_Size (The_Dh : access constant Rsa_St) return int;
   pragma Import (C, Rsa_Size, "RSA_size");

   ------------------------------------------------------------
   --                         create                         --
   ------------------------------------------------------------
   function Create return Rsa is
   begin
      return (Context => Rsa_New);
   end Create;
   function Size (This : in Rsa) return Integer is
   begin
      if This.Context /= null then
         return Integer (Rsa_Size (This.Context));
      end if;
      return -1;
   end Size;
end Metax.Rsa;
