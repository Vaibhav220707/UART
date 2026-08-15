`timescale 1ns / 1ps

module uart_rx(
    input rst,
    input rx,
    input baud_tick,
    input clk,
    output reg [7:0] dout,
    output reg rx_done
);

reg [1:0] state, nextstate;
reg [2:0] bitcounter;
reg [7:0] shiftreg;

parameter IDLE  = 2'b00,
          START = 2'b01,
          DATA  = 2'b10,
          STOP  = 2'b11;

// State register
always @(posedge clk) begin
    if (rst)
        state <= IDLE;
    else
        state <= nextstate;
end

// Next-state logic
always @(*) begin
    case (state)

        IDLE: begin
            if (rx == 1'b0)
                nextstate = START;
            else
                nextstate = IDLE;
        end

        START: begin
            if (baud_tick) begin
                if (rx == 1'b0)
                    nextstate = DATA;
                else
                    nextstate = IDLE;
            end
            else
                nextstate = START;
        end

        DATA: begin
            if (baud_tick && bitcounter == 3'd7)
                nextstate = STOP;
            else
                nextstate = DATA;
        end

        STOP: begin
            if (baud_tick)
                nextstate = IDLE;
            else
                nextstate = STOP;
        end

        default:
            nextstate = IDLE;

    endcase
end

// Data receiving logic
always @(posedge clk) begin

    if (rst) begin
        shiftreg  <= 8'b0;
        bitcounter <= 3'b0;
        dout      <= 8'b0;
        rx_done   <= 1'b0;
    end

    else begin

        // Default: rx_done is only high for one clock
        rx_done <= 1'b0;

        case (state)

            IDLE: begin
                bitcounter <= 3'b0;
            end

            START: begin
                if (baud_tick) begin
                        bitcounter <= 3'b0;
                end
            end

            DATA: begin
                if (baud_tick) begin

                    // UART receives LSB first
                    shiftreg <= {rx, shiftreg[7:1]};

                    bitcounter <= bitcounter + 1'b1;

                end
            end

            STOP: begin
                if (baud_tick) begin

                    // Stop bit must be HIGH
                    if (rx == 1'b1) begin
                        dout    <= shiftreg;
                        rx_done <= 1'b1;
                    end

                end
            end

        endcase
    end
end

endmodule