module sync_fifo(clk,rst,r_en,w_en,data_in,data_out);
  parameter width = 8;
  parameter depth = 64;
  parameter ptr_width = 6;
  
  input clk,rst;
  input w_en,r_en;
  input [width-1:0]data_in;
  output[width-1:0]data_out;
  
  reg [width-1:0]data_out;
  reg [ptr_width:0]r_ptr,w_ptr;
  reg full,empty;
  reg [width-1:0]mem[depth-1:0];
  
  //status flag
  always@(posedge clk)
  begin
    if(rst)
      begin
      full <= 0;
      empty <= 1;
      end
    else 
      begin
        full <= (w_ptr[ptr_width] != r_ptr[ptr_width]) && (w_ptr[ptr_width-1:0] == r_ptr[ptr_width-1:0]) ;
      empty <= w_ptr==r_ptr;
      end
  end
      
   //write operation
  always@(posedge clk)
  begin
  if (rst)
    begin
    w_ptr <= 0;
    end
    else if(w_en && !full)
      begin
        mem[w_ptr[ptr_width-1:0]]<=data_in;
      w_ptr <= w_ptr+1;
      end
   end
               
    //read operation
  always@(posedge clk)
  begin
  if(rst)
    begin
    r_ptr <= 0;
    data_out <= 0;
    end
    else if(r_en && !empty)
      begin
        data_out <= mem[r_ptr[ptr_width-1:0]];
      r_ptr <= r_ptr+1;
      end
   end
endmodule
                