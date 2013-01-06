------------------------------------------------------------
--                         MetaX.rsa                       --
------------------------------------------------------------
package body Metax.Rsa is
   ------------------------------------------------------------
   --                         create                         --
   ------------------------------------------------------------
   function Create return Rsa is
   begin
      return (Context => C2a.Rsa_New);
   end Create;
   function Size (This : in Rsa) return Integer is
   begin
      if This.Context /= null then
         return Integer (C2a.Rsa_Size (This.Context));
      end if;
      return -1;
   end Size;
end Metax.Rsa;
