with System;
package body Metax.Bn is
   function Bytes_Length (Number : Bignumber) return Integer is
   begin
      return Integer (Bn_Num_Bits (Number.Number) + 7) / 8;
   end Bytes_Length;

   function To_Binary (Number : Bignumber) return Byte_Array is
      Binary : Byte_Array (1 .. Bytes_Length (Number));
   begin
      Bn_Bn2bin (Number.Number, Binary);
      return Binary;
   end To_Binary;

   function From_Binary (Binary : Byte_Array) return Bignumber is
   begin
      return (Number => Bn_Bin2bn (Binary, Binary'Length, null));
   end From_Binary;

   procedure Clear (Number : Bignumber) is
   begin
      Bn_Clear (Number.Number);
   end Clear;

   procedure Free (Number : Bignumber) is
   begin
      Bn_Free (Number.Number);
   end Free;

   procedure Clear_Free (Number : Bignumber) is
   begin
      Bn_Clear_Free (Number.Number);
   end Clear_Free;
   function Reference
     (Number : Bignumber)
      return   access  constant Bignum_St is
   begin
      return Number.Number;
   end Reference;
end Metax.Bn;
