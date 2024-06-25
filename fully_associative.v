module cache (
  input clk,
  input rst,
  input wren,
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

// A cache line = {valid, tag_array, memory}

logic [`CACHE_ENTRIES-1:0] valid;
logic [`CACHE_ENTRIES-1:0][`ADDRESS_WIDTH-1:0] tag_array; // for now tag array is the full address...
logic [`CACHE_ENTRIES-1:0][`DATA_WIDTH-1:0] memory;

logic [`LOG_BASE_CACHE_ENTRIES-1:0] wr_ptr;

initial begin
  for (int i = 0; i < `CACHE_ENTRIES; i++) begin
    valid[i] = 0;
    tag_array[i][`ADDRESS_WIDTH-1:0] = 0;
    memory[i][`DATA_WIDTH-1:0] = 0;
    wr_ptr = 0;
  end
end

// chatgpt said this would work - i don't trust
// assign match = |(addr == tag_array[i]);

// always @ (*) begin
//   for (int i = 0; i < `CACHE_ENTRIES; i++) begin
//     if (addr == tag_array[i])
//   end
// end

logic addr_found = |match;

genvar i;
generate
  logic match [`CACHE_ENTRIES-1:0];
  for (i = 0; i < `CACHE_ENTRIES; i++) begin
    assign match[i] = (addr == tag_array[i]);
  end
endgenerate

always @ (posedge clk) begin
  if (rst) begin
    // Is this possible?...
    for (int i = 0; i < `CACHE_ENTRIES; i++) begin
      valid[i] = 0;
      tag_array[i][`ADDRESS_WIDTH-1:0] = 0;
      memory[i][`DATA_WIDTH-1:0] = 0;
      wr_ptr = 0;
    end
  end else begin
    if (wren) begin
      // Need to do a boundary condition for if the cache is full...
      valid[wr_ptr] <= 1;
      tag_array[wr_ptr] <= addr;
      memory[wr_ptr] <= data;
      wr_ptr <= wr_ptr + 1;
    end else begin
      // If it's a read, see if the entry exists in the cache
      // If it exists, return the data associated with the provided addr
      // else return data from main-memory
      if (addr_found) begin

      end
    end
  end
end

endmodule
