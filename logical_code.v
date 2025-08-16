`timescale 1ns / 1ps
module bcd_5(input clk,reset,
output reg [3:0]counter1,counter2,
output reg [3:0]counter1bar,counter2bar,
output reg [7:0]display,
output reg [3:0]control);
reg clkdiv,clkms,flag;
reg e120,e154,e204,e254,e15,e61,e55,e50,e86,e147;
integer temp1,temp2;
initial
begin
temp1=0;
temp2=0;
counter1=4'b1000;
counter2=4'b0111;
clkdiv=1'b0;
flag=0;
clkms=0;
end
always@(posedge clk)
begin
temp1=temp1+1;
temp2=temp2+1;
if(temp1==2000000)
begin
clkdiv=~clkdiv;
temp1=0;
end
if(temp2==200)
begin
clkms=~clkms;
temp2=0;
end
end
always@(posedge clkdiv)
begin
if(reset)
begin
counter1=4'b1000;
counter2=4'b0111;
end
else
begin
counter1bar=~counter1;
counter2bar=~counter2;
e120=counter2bar[3] & counter2[2] & counter2[1] &counter2[0] & counter1[3] &
counter1bar[2] & counter1bar[1] & counter1bar[0];
  
e154=counter2[3] & counter2bar[2] & counter2bar[1] &counter2[0] & counter1[3] &
counter1bar[2] & counter1[1] & counter1bar[0];
  
e204=counter2[3] & counter2[2] & counter2bar[1] &counter2bar[0] & counter1[3] &
counter1[2] & counter1bar[1] & counter1bar[0];
e254=counter2[3] & counter2[2] & counter2[1] &counter2[0] & counter1[3] & counter1[2] &
counter1bar[0] & counter1[1];
e15=counter2bar[3] & counter2bar[2] & counter2bar[1] &counter2bar[0] & counter1[3] &
counter1[2] & counter1[1] & counter1[0];
e61=counter2bar[3] & counter2bar[2] & counter2[1] & counter2[0] & counter1[3] &
counter1bar[1] & counter1[2] & counter1[0];
e55=counter2bar[3] & counter2bar[2] & counter2[1] &counter2[0] & counter1bar[3] &
counter1[2] & counter1[1] & counter1[0];

  e50=counter2bar[3] & counter2bar[2] & counter2[1] &counter2[0] & counter1bar[3] &
counter1bar[2] & counter1[1] & counter1bar[0];
e86=counter2bar[3] & counter2[2] & counter2bar[1] &counter2[0] & counter1bar[3] &
counter1[2] & counter1[1] & counter1bar[0];
e147=counter2[3] & counter2bar[2] & counter2bar[1] &counter2[0] & counter1bar[3] &
counter1bar[2] & counter1[1] & counter1[0];
counter2[3]= e120 | e154 | e204 | e86;
counter2[2]= e154 | e204 | e50 | e147;
counter2[1]=e204 | e15 | e61 | e55 | e147;
counter2[0]= e120 | e204 | e15 | e61 | e55 | e50 | e86 |e147;
counter1[3]=e120 | e154 | e204 | e254 | e15 | e147;
counter1[2]=e154 | e204 | e254 | e15 | e61 | e50;
counter1[1]=e120 | e204 | e254 | e61 | e55 | e50 |e86;
counter1[0]=e254 | e15 | e61 | e86 ;
end
end
always@(posedge clkms)
begin
if (flag==1'b0)
begin
control=4'b0111;
case(counter2)
0:display=8'b11111100;
1:display=8'b01100000;
2:display=8'b11011010;
3:display=8'b11110010;
4:display=8'b01100110;
5:display=8'b10110110;
6:display=8'b10111110;
7:display=8'b11100000;
8:display=8'b11111110;
9:display=8'b11110110;
10:display=8'b11111010;
11:display=8'b00111110;
12:display=8'b00011010;
13:display=8'b01111010;
14:display=8'b11011110;
15:display=8'b10001110;
endcase
flag=1'b1;
end
else
begin
control=4'b1011;
case(counter1)
0:display=8'b11111100;
1:display=8'b01100000;
2:display=8'b11011010;
3:display=8'b11110010;
4:display=8'b01100110;
5:display=8'b10110110;
6:display=8'b10111110;
7:display=8'b11100000;
8:display=8'b11111110;
9:display=8'b11110110;
10:display=8'b11111010;
11:display=8'b00111110;
12:display=8'b00011010;
13:display=8'b01111010;
14:display=8'b11011110;
15:display=8'b10001110;
endcase
flag=1'b0;
end
end
endmodule
