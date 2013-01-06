with Interfaces.C; use Interfaces.C;
------------------------------------------------------------
--                       MetaX.SHA2                       --
------------------------------------------------------------
package body Metax.Sha2 is
   procedure Initialize (This : in out Sha) is
   begin
      if C2a.Sha256_Init (This.State'Access) /= 1 then
         raise Error;
      end if;
   end Initialize;

   procedure Update (This : in out Sha; Data : in Byte_Array) is
   begin
      if C2a.Sha256_Update (This.State'Access, Data, Data'Length) /=
         1 then
         raise Error;
      end if;
   end Update;

   function Finalize (This : in Sha) return Md_Array is
      Md : Md_Array;
   begin
      C2a.Sha256_Final (Md, This.State'Access);
      return Md;
   end Finalize;

end Metax.Sha2;
