`define ADDRESS_WIDTH 32 // 32-bit address
`define DATA_WIDTH 64 // bits

`define CACHE_SIZE (128000) // FIXME
`define CACHE_ENTRIES (`CACHE_SIZE / `DATA_WIDTH)
`define LOG_BASE_CACHE_ENTRIES (12) // bits

`define NUM_WAYS 2 // 2 ways of cache