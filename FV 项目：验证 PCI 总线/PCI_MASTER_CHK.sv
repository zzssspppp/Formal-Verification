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




// master_chk1
// 如果在某个时钟边沿，监测到 framen 的上升沿，则 irdyn 在同一时刻：
//     1. 可能为 0：framen 上升表示数据阶段的最后一部分即将开始，
//                 如果主机在前一个数据阶段不忙碌，则 irdyn 信号为 0；
//     2. 可能出现下降沿
//                 如果主机在前一个数据阶段忙碌，直到新的数据阶段才解除，
//                 那么 irdyn 信号应该出现下降沿
property p_mchk1;
    @(posedge clk) $rose (framen) |-> ((irdyn == 0) || $fell(irdyn));
endproperty
a_mchk1: assert property(p_mchk1);
c_mchk1: cover property(p_mchk1);  




// master_chk2
// 如果在某个时钟边沿，监测到 framen 的上升沿，
// 那么在接下来的1到8个时钟周期内，
// irdyn 和 trdyn 信号必须在其中的某个时钟周期内发生上升沿，
// 且这个上升沿可以在framen保持不变的任何时钟周期内发生。
property p_mchk2;
    @(posedge clk)
    $rose (framen) |-> framen[*1:8] ##0 $rose(irdyn && trdyn);
endproperty
a_mchk2: assert property(p_mchk2);
c_mchk2: cover property(p_mchk2);  
