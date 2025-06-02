// Code your testbench here
// or browse Examples
module sync_fifo_tb;
  parameter width = 8;
  parameter depth = 64;
  parameter ptr_width = 6;
  
  reg clk,rst;
  reg w_en,r_en;
  reg [width-1:0]data_in;
  wire[width-1:0]data_out;
  
  wire [ptr_width:0]r_ptr,w_ptr;
  wire full,empty;
  wire [width-1:0]mem[depth-1:0];
  
  //instantiate of sync_fifo
  sync_fifo dut(.clk(clk), .rst(rst), .r_en(r_en), .w_en(w_en), .data_in(data_in), .data_out(data_out));
  
  //clock genetation
  initial
    begin
      clk =0;
      forever #5 clk = ~clk;
    end
  
  initial
    begin
      $monitor("simtime=%g, data_in=%b, data_out=%b, w_en=%b, r_en=%b", $time, data_in, data_out, w_en, r_en);
      $dumpfile("info.vcd");
      $dumpvars(0,sync_fifo_tb);
    end
  
  //test
  initial
    begin
      rst = 1;
      w_en = 0;
      r_en = 0;
      data_in = 0;
      #10;
      rst = 0;
      
      //write
       $display("Writing to FIFO...");
      repeat(10)
        begin @(posedge clk);
          w_en = 1;
          data_in=data_in+1;
        end
      @(posedge clk);
      w_en=0;
      
      #10;
      
      //read
      $display("Reading from FIFO...");
      repeat(10)
        begin@(posedge clk);
          r_en = 1;
        end
      @(posedge clk);
      r_en=0;
      
      #10;
      
      $stop;
    end
endmodule