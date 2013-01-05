-----------------------------------------------------------
---
--                         MetaX.dh                       --
------------------------------------------------------------
package body Metax.Dh is

   ------------------------------------------------------------
   --                         create                         --
   ------------------------------------------------------------
   function Create return Dh is
   begin
      return (Context => Dh_New);
   end Create;
   ------------------------------------------------------------
   --                        from_pem                        --
   ------------------------------------------------------------
   function From_Pem (Path : String) return Dh is
      F : Assio.File_Type;
      R : Ics.FILEs;
   begin
      Assiocs.Open (F, Assio.In_File, R, Path);
      return
        (Context => Pem_Read_Dhparams
                      (R,
                       System.Null_Address,
                       null,
                       System.Null_Address));
   end From_Pem;
   ------------------------------------------------------------
   --                          Free                          --
   ------------------------------------------------------------
   procedure Free (This : in out Dh) is
   begin
      if This.Context /= null then
         Dh_Free (This.Context);
      end if;
   end Free;
   ------------------------------------------------------------
   --                    Set_Private_Key                     --
   ------------------------------------------------------------
   procedure Set_Private_Key (This : in out Dh; Pem : String) is
      F   : Assio.File_Type;
      R   : Ics.FILEs;
      P   : access Evp_Pkey_St;
      Ref : access Dh_St;
   begin
      Assiocs.Open (F, Assio.In_File, R, Pem);
      P   :=
         Pem_Read_Privatekey
           (R,
            System.Null_Address,
            null,
            System.Null_Address);
      Ref := Get_Dh (P);
      if Ref /= null then
         This.Context.Priv_Key := Bn_Dup (Ref.Priv_Key);
      end if;
      Evp_Pkey_Free (P);
   end Set_Private_Key;
   ------------------------------------------------------------
   --                  generate_parameters                   --
   ------------------------------------------------------------
   procedure Generate_Parameters
     (This              : in out Dh;
      Length, Generator : Integer)
   is
   begin
      if Dh_Generate_Parameters_Ex
            (This.Context,
             int (Length),
             int (Generator),
             System.Null_Address) /=
         1 then
         raise Error;
      end if;
   end Generate_Parameters;

   ------------------------------------------------------------
   --                      generate_key                      --
   ------------------------------------------------------------
   procedure Generate_Key (This : in out Dh) is
   begin
      null;
   end Generate_Key;
   ------------------------------------------------------------
   --                      compute_key                       --
   ------------------------------------------------------------
   function Compute_Key
     (This : in Dh;
      Y    : in Byte_Array)
      return Byte_Array
   is
      Z : Byte_Array (1 .. Integer (Dh_Size (This.Context)));
      N : access Bignum_St;
   begin
      N := Bn_Bin2bn (Y, Y'Length, null);
      if Dh_Compute_Key (Z, N, This.Context) = -1 then
         raise Error;
      end if;
      Bn_Free (N);
      return Z;
   end Compute_Key;

   procedure Set_P (This : in out Dh; P : in Byte_Array) is
   begin
      This.Context.P := Bn_Bin2bn (P, P'Length, null);
   end Set_P;
   function P (This : in Dh) return Byte_Array is
      P : Byte_Array (
         1 .. Integer (Bn_Num_Bits (This.Context.P) + 7) / 8);
   begin
      Bn_Bn2bin (This.Context.P, P);
      return P;
   end P;
   procedure Set_G (This : in out Dh; G : in Byte_Array) is
   begin
      This.Context.G := Bn_Bin2bn (G, G'Length, null);
   end Set_G;
   function G (This : in Dh) return Byte_Array is
      G : Byte_Array (
         1 .. Integer (Bn_Num_Bits (This.Context.G) + 7) / 8);
   begin
      Bn_Bn2bin (This.Context.G, G);
      return G;
   end G;
   procedure Set_Y (This : in out Dh; Y : in Byte_Array) is
   begin
      This.Context.Pub_Key := Bn_Bin2bn (Y, Y'Length, null);
   end Set_Y;
   function Y (This : in Dh) return Byte_Array is
      Y : Byte_Array (
         1 .. Integer (Bn_Num_Bits (This.Context.Pub_Key) + 7) / 8);
   begin
      Bn_Bn2bin (This.Context.Pub_Key, Y);
      return Y;
   end Y;
   function Size (This : in Dh) return Integer is
   begin
      if This.Context /= null then
         return Integer (Dh_Size (This.Context));
      end if;
      return -1;
   end Size;
end Metax.Dh;
