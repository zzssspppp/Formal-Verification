`define s_IO_READ         ($fell (framen) && (cxben[3:0] == 4'b0010))
`define s_IO_WRITE        ($fell (framen) && (cxben[3:0] == 4'b0011))
`define s_MEM_READ        ($fell (framen) && (cxben[3:0] == 4'b0110))
`define s_MEM_WRITE       ($fell (framen) && (cxben[3:0] == 4'b0111))
`define s_CONFIG_READ     ($fell (framen) && (cxben[3:0] == 4'b1010))
`define s_CONFIG_WRITE    ($fell (framen) && (cxben[3:0] == 4'b1011))
`define s_DUAL_ADDR_CYCLE ($fell (framen) && (cxben[3:0] == 4'b1101))
`define s_MEM_READ_LINE   ($fell (framen) && (cxben[3:0] == 4'b1110))
`define s_MEM_WRITE_INV   ($fell (framen) && (cxben[3:0] == 4'b1111))
`define s_BUS_IDLE        (farmen && irdyn)

property p_mchk1;
  @(posedge clk) $rose (framen) |-> (irdyn == 0);
endproperty
a_mchk1: assert property(p_mchk1);
c_mchk1: cover property(p_mchk1);  
