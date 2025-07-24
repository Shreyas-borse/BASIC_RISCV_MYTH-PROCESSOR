\m5_TLV_version 1d: tl-x.org
\m5
   
   // ============================================
   // Welcome, new visitors! Try the "Learn" menu.
   // ============================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $valid_or_reset = $valid | $reset;

   |calc
      ?$valid_or_reset
         @1
            $val1[31:0] = >>2$out;
            $val2[31:0] = $rand2[3:0];

            $sum = $val1 + $val2 ;
            $diff = $val1 - $val2 ;
            $prod = $val1 * $val2 ;
            $qout = $val1 / $val2 ;

         @2
            $op[2:0] == 3'b000 ? $out1 = $sum : ($op[2:0] = 3'b001) ? $out1 = $diff : ($op[2:0] = 3'b010) ? $out1 = $prod : ($op[2:0] = 3'b011) ? $out1 = $qout : ($op[2:0] = 3'b100) ? $out = >>2$mem  : ($op[2:0] = 3'b101) ? $mem[31:0] = >>2$out[31:0] : $mem[31:0] = >>2$mem[31:0];

            $out = $valid_or_reset ? 32'b0 : $out1;
            $mem[31:0] = $valid_or_reset ? 32'b0 : >>2$mem;

   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
