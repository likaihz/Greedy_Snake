`timescale 1ns / 1ps

module Seg_display(
	input clk,
	input reset,
	input add_cube,
	output reg [7:0] seg_out,
	output reg [3:0] sel
	);

	reg [15:0] point;
	reg [31:0] clk_cnt;

	always @( posedge clk ) begin
		if( !reset  ) begin	
			seg_out <= 0;
		   clk_cnt <= 0;
			sel <= 0;
		end

		else begin
			if( clk_cnt <= 200000 ) begin
				clk_cnt <= clk_cnt + 1;
				if( clk_cnt == 50000 ) begin
					sel <= 4'b1110;
					case( point[3:0] )
					4'b0000:seg_out <= 8'b00000011;
					4'b0001:seg_out <= 8'b10011111;
					4'b0010:seg_out <= 8'b00100101;
					4'b0011:seg_out <= 8'b00001101;
					4'b0100:seg_out <= 8'b10011001;
					4'b0101:seg_out <= 8'b01001001;
					4'b0110:seg_out <= 8'b01000001;
					4'b0111:seg_out <= 8'b00011111;
					4'b1000:seg_out <= 8'b00000001;
					4'b1001:seg_out <= 8'b00001001;
					default:;
					endcase
				end

				else if( clk_cnt == 100000 ) begin
					sel <= 4'b1101;				
					case( point[7:4] )
					4'b0000:seg_out <= 8'b00000011;
					4'b0001:seg_out <= 8'b10011111;
					4'b0010:seg_out <= 8'b00100101;
					4'b0011:seg_out <= 8'b00001101;
					4'b0100:seg_out <= 8'b10011001;
					4'b0101:seg_out <= 8'b01001001;
					4'b0110:seg_out <= 8'b01000001;
					4'b0111:seg_out <= 8'b00011111;
					4'b1000:seg_out <= 8'b00000001;
					4'b1001:seg_out <= 8'b00001001;
					default:;		
					endcase 
				end

				else if( clk_cnt == 150000 ) begin
					sel <= 4'b1011;
					case( point[11:8] )
					4'b0000:seg_out <= 8'b00000011;
					4'b0001:seg_out <= 8'b10011111;
					4'b0010:seg_out <= 8'b00100101;
					4'b0011:seg_out <= 8'b00001101;
					4'b0100:seg_out <= 8'b10011001;
					4'b0101:seg_out <= 8'b01001001;
					4'b0110:seg_out <= 8'b01000001;
					4'b0111:seg_out <= 8'b00011111;
					4'b1000:seg_out <= 8'b00000001;
					4'b1001:seg_out <= 8'b00001001;
					default:;
					endcase 
				end

				else if( clk_cnt == 200000 ) begin
					sel <= 4'b0111;
		   		case( point[15:12] )
					4'b0000:seg_out <= 8'b00000011;
					4'b0001:seg_out <= 8'b10011111;
					4'b0010:seg_out <= 8'b00100101;
					4'b0011:seg_out <= 8'b00001101;
					4'b0100:seg_out <= 8'b10011001;
					4'b0101:seg_out <= 8'b01001001;
					4'b0110:seg_out <= 8'b01000001;
					4'b0111:seg_out <= 8'b00011111;
					4'b1000:seg_out <= 8'b00000001;
					4'b1001:seg_out <= 8'b00001001;
					default:;
					endcase
				end
			end

			else 
				clk_cnt <= 0;
		end 
	end

	reg addcube_state;
	always @( posedge clk  ) begin
		if( reset == 0 ) begin
			point <= 0;
			addcube_state <= 0;
		end

		else begin
			case( addcube_state )
			0: begin
				if( add_cube ) begin	
					if( point[3:0] < 9 )
						point[3:0] <= point[3:0] + 1;
						
					else begin
						point[3:0] <= 0;
						if( point[7:4] < 9 )
							point[7:4] <= point[7:4] + 1;

						else begin
							point[7:4] <= 0;
							if( point[11:8] < 9 ) 
								point[11:8] <= point[11:8] + 1;
							else begin
								point[11:8] <= 0;
								point[15:12] <= point[15:12] + 1;
							end
						end
					end
					
					addcube_state <= 1;
				end
			end
		

			1: begin
				if(!add_cube)
					addcube_state <= 0;
			end
			endcase
		end
	end

endmodule

