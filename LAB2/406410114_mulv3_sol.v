//以前者(1ns)為單位，以後者(1ps)的時間，查看一次電路的行為
`timescale 1ns/1ps

//宣告module名稱,輸出入名稱
module lab(
	CLK, 
	RST, 
	in_a, 
	in_b, 
	Product, 
	Product_Valid
);
// in_a * in_b = Product
// in_a is Multiplicand , in_b is Multiplier
					
//定義port, 包含input, output
input 			CLK, RST;
input 	[15:0]	in_a;			// Multiplicand
input 	[15:0]	in_b;			// Multiplier
output 	[31:0]  Product;
output  		Product_Valid;

reg 	[15:0]	Mplicand;		//被乘數  優化只需要15bit
reg 	[31:0]	Product;
reg 			Product_Valid;
reg 	[7:0]	Counter ;
reg				sign;	//isSigned
//reg		 		turn;
//Counter
always @(posedge CLK or posedge RST)
begin
	if (RST)
		Counter <= 7'b0;
	else
		Counter <= Counter + 7'b1;
end

//Product
always @(posedge CLK or posedge RST)
begin
	//初始化數值
	if (RST) begin
		Product  <= 31'b0;
		Mplicand <= 16'b0;
		/*
			正負號判斷
			write your code here
		*/
		sign <= (in_a[15]) ^ (in_b[15]);
	end

	//輸入結果與被乘數
	else if (Counter == 7'd0 ) begin
		//負數做二補數轉換
		if ((in_b[15] == 1) && (in_a[15] == 0) )begin
			Mplicand 	<= in_a; 
			Product	 	<= {16'b0, ~in_b+1'b1};
		end
		else if ( (in_b[15] == 0) && (in_a[15] == 1) )begin
			Mplicand 	<= ~in_a+1;
			Product	 	<= {16'b0, in_b};
		end
		else if ( (in_b[15] == 1) && (in_a[15] == 1) ) begin
			Mplicand 	<= ~in_a+1;
			Product	 	<= {16'b0, ~in_b+1'b1};
		end
		else begin
			Mplicand 	<= in_a;
			Product	 	<= {16'b0, in_b};
		end


	end
	
	//乘法與數值移位
	//奇數回合 如果尾數是1  Product	<= {Mplicand,16'b0} + Product
	else if ( (Counter < 7'd32) && ( Counter % 7'd2 == 7'd1 ) )begin
		if (Product[0] == 1'b1)begin
			//write your code here
			Product 	<= {Mplicand,16'b0} + Product  ;
		end
	end
	
	//偶數回合作右移
	else if ( (Counter > 7'd0 ) && (Counter % 7'd2 == 7'd0) )begin
	//else if ( Counter == 7'd32  )begin
		Product <= Product >> 1'b1;
	end
		
		//write your code here
		//if (sign == 1'b1)
			//write your code here
			
	else begin
		//正數換成負數
		if (sign == 1'b1 ) begin
			Product <= ~(Product-1'b1)  ;
			Mplicand	<= Mplicand;
		end
		else begin 
			Product <= Product  ;
			Mplicand<= Mplicand;
		end
	end
end

//Product_Valid
always @(posedge CLK or posedge RST)
begin
	if (RST)
		Product_Valid <=1'b0;
	else if (Counter== 7'd33)
		Product_Valid <=1'b1;
	else
		Product_Valid <=1'b0;
end

endmodule
