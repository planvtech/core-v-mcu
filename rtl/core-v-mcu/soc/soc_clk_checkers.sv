module soc_clk_checkers
#(
    parameter REF_CLK_PERIOD_NS = 200,
    parameter ETH_CLK_PERIOD_NS = 20
)
(
    input ref_clk,
    input ref_clk_locked,
    input eth_clk,
    input eth_clk_locked,
    output ld_ref_clk_lock,
    output reg ld_ref_clk_blink,
    output ld_eth_clk_lock,
    output reg ld_eth_clk_blink
);

integer ref_clk_cnt = 0;
integer eth_clk_cnt = 0;

localparam REF_CLK_COUNT_LIMIT = 1000000000/REF_CLK_PERIOD_NS - 1;
localparam ETH_CLK_COUNT_LIMIT = 1000000000/ETH_CLK_PERIOD_NS - 1;

assign ld_ref_clk_lock = ref_clk_locked;
assign ld_eth_clk_lock = eth_clk_locked;

always @(posedge ref_clk)
begin
    if(ref_clk_cnt >= REF_CLK_COUNT_LIMIT)
    begin
        ref_clk_cnt <= 0;
        ld_ref_clk_blink <= ~ld_ref_clk_blink;
    end
    else
    begin
        ref_clk_cnt <= ref_clk_cnt + 1;
    end
end

always @(posedge eth_clk)
begin
    if(eth_clk_cnt >= ETH_CLK_COUNT_LIMIT)
    begin
        eth_clk_cnt <= 0;
        ld_eth_clk_blink <= ~ld_eth_clk_blink;
    end
    else
    begin
        eth_clk_cnt <= eth_clk_cnt + 1;
    end
end

endmodule