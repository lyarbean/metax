----------------------------------------------------------
---
---
--                       MetaX.SHA2                       --
------------------------------------------------------------
package body Metax.Sha2 is
   function Sha256_Init (C : access Sha256state_St) return int;
   pragma Import (C, Sha256_Init, "SHA256_Init");
   function Sha256_Update
     (C    : access Sha256state_St;
      Data : in Byte_Array;
      Len  : size_t)
      return int;
   pragma Import (C, Sha256_Update, "SHA256_Update");
   procedure Sha256_Final
     (Md : in out Md_Array;
      C  : access constant Sha256state_St);
   pragma Import (C, Sha256_Final, "SHA256_Final");

   procedure Initialize (This : in out Sha) is
   begin
      if Sha256_Init (This.State'Access) /= 1 then
         raise Error;
      end if;
   end Initialize;

   procedure Update (This : in out Sha; Data : in Byte_Array) is
   begin
      if Sha256_Update (This.State'Access, Data, Data'Length) /=
         1 then
         raise Error;
      end if;
   end Update;

   function Finalize (This : in Sha) return Md_Array is
      Md : Md_Array;
   begin
      Sha256_Final (Md, This.State'Access);
      return Md;
   end Finalize;

end Metax.Sha2;
