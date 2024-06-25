module cache (
  input clk,
  input [`ADDRESS_WIDTH-1:0] addr,
  input [`DATA_WIDTH-1:0] data,
  output cache_hit
);

// a cache is a local memory to some other device
// it allows your hardware to have faster memory accesses

// It is similar in-concept to a hash-map

// You provide a key (address) and it tells you whether or not
// the cache has a valid copy of the data at that address

// If you have a copy of the data, you have a cache hit
// If not, you have a cache miss

logic [`CACHE_LINES-1:0][`DATA_WIDTH-1:0] memory;

always @ (posedge clk) begin

end

endmodule
