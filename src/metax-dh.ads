with Metax.Types;
with Metax.C2a;
package Metax.Dh is
   pragma Elaborate_Body;
   use Types;
   type Dh is tagged limited private;
   function Create return Dh;
   function From_Pem (Path : String) return Dh;
   procedure Free (This : in out Dh);
   procedure Set_Private_Key (This : in out Dh; Pem : String);
   procedure Generate_Parameters
     (This              : in out Dh;
      Length, Generator : Integer);
   procedure Generate_Key (This : in out Dh);
   function Compute_Key
     (This : in Dh;
      Y    : in Byte_Array)
      return Byte_Array;

   procedure Set_P (This : in out Dh; P : in Byte_Array);
   function P (This : in Dh) return Byte_Array;
   procedure Set_G (This : in out Dh; G : in Byte_Array);
   function G (This : in Dh) return Byte_Array;
   procedure Set_Y (This : in out Dh; Y : in Byte_Array);
   function Y (This : in Dh) return Byte_Array;
   function Size (This : in Dh) return Integer;

private
   type Dh is tagged limited record
      Context : access C2a.Dh_St;
   end record;
end Metax.Dh;
