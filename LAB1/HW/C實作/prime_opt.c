#include <stdio.h>
#include <math.h>

int isPrime(int n)
{	//返回1表示判断为质数，0为非质数，在此没有进行输入异常检测
	float n_sqrt;
	if ( n==0 || n==1 ) return -1;
	if(n==2 || n==3) return 1;
	if(n%6!=1 && n%6!=5) return 0;
	n_sqrt=floor(sqrt((float)n));  //取平方後整數
	//printf( "n_sqrt:%f ",n_sqrt );
	for(int i=5;i<=n_sqrt;i+=6)
	{
	    if(n%(i)==0 | n%(i+2)==0) return 0;
	}
        return 1;
}
int main()
{
	int num;
	int num_smaller = 0,num_biger = 0;
	printf( "please input number:" ) ;
	scanf( "%d",&num ) ;
	for ( int i = num+1 ; i > 0 ; i++ ){
        if (isPrime(i) == 1 ){
            //printf( "i:%d\n",i );
            num_biger = i;
            break;
        }//if
	}//for

    for ( int i = num-1 ; i > 0 ; i-- ){
        if (isPrime(i) == 1 ){
            num_smaller = i;
            break;
        }//if
	}//for

    if (num_smaller == 0 )
        printf( "num_smaller:null\n" );
	else
        printf( "num_smaller:%d\n",num_smaller );

    if (num_biger == 0 )
        printf( "num_biger:null\n" );
	else
        printf( "num_biger:%d\n",num_biger );
	return 0;

}
