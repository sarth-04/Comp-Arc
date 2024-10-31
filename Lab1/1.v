module bcd_to_gray_gate(input [3:0] bcd, output [3:0] gray);
    // Assign Gray bits based on BCD bits using XOR gates
    assign gray[3] = bcd[3];
    xor g1(gray[2], bcd[3], bcd[2]);
    xor g2(gray[1], bcd[2], bcd[1]);
    xor g3(gray[0], bcd[1], bcd[0]);
endmodule

module bcd_to_gray_df(input [3:0] bcd, output [3:0] gray);
    assign gray[3] = bcd[3];
    assign gray[2] = bcd[3] ^ bcd[2];
    assign gray[1] = bcd[2] ^ bcd[1];
    assign gray[0] = bcd[1] ^ bcd[0];
endmodule

module testbench();
    // Declare 'bcd' as a 4-bit register to represent the BCD input
    reg [3:0] bcd;
    
    // Declare 'gray_gate' and 'gray_df' as 4-bit wires to capture the Gray code outputs
    // from the Gate Level and Dataflow models, respectively.
    wire [3:0] gray_gate;
    wire [3:0] gray_df;

    // Instantiate the Gate Level Model of the BCD to Gray code converter.
    // This model takes 'bcd' as input and produces 'gray_gate' as output.
    bcd_to_gray_gate gate_model (.bcd(bcd), .gray(gray_gate));

    // Instantiate the Dataflow Model of the BCD to Gray code converter.
    // This model also takes 'bcd' as input and produces 'gray_df' as output.
    bcd_to_gray_df df_model (.bcd(bcd), .gray(gray_df));

    // The initial block starts the test procedure
    initial begin
        // Display header for clarity in the output
        $display("Time\tBCD\tGate_Gray\tDF_Gray");

        // Monitor displays the values of BCD input, Gate Level Gray output, and Dataflow Gray output
        // whenever they change during the simulation. '%0t' denotes time, '%b' formats as binary.
        $monitor("%0t\t%b\t%b\t\t%b", $time, bcd, gray_gate, gray_df);

        // Test all valid BCD values (0000 to 1001 in binary, representing 0 to 9 in decimal)
        for (bcd = 4'b0000; bcd <= 4'b1001; bcd = bcd + 1) begin
            #10; // Wait for 10 time units before applying the next BCD value
        end

        // End the simulation after all values have been tested
        #10 $finish;
    end
endmodule
