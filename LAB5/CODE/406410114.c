#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct input{
	int type;
	int instruction;
	int index;
	int tag;
	int offset;
} input;


typedef struct cachetable{
	int ins;
	int valid;
	int dirty_bit;
    int tag;
    int data;
    int used;
} cachetable;




int instr_num=0,readData=0,writeData=0,cacheHit=0,cacheMiss=0,bytesFromMem =0,bytesToMem=0;
int FIFO_pointer[10000000] = {0};
input instr[10000000];
cachetable cachetb[10000000];
void ReadInput( char *filename,int tag,int index,int offset );
void process( int instructionIdx, char replace_policy[],int associativity,int blocksize  );
int replacePolicy( char replace_policy[], int cacheIdxBase, int associativity );
void clean_cache(int blocksize);


void boot();
int main(int argc, const char * argv[]) {
    //*********************************************************
    //input spec
    //argv[1]:int cachesize
    //argv[2]:int blocksize
    //argv[3]:char assoc   : 1 ,2,4,8,f
    //argv[4]:char replacePolicy   : FIFO,LRU
    //argv[5]:char filename
    //*********************************************************
    int i;
    //=========================================argv input process=========================//
    int cachesize = atoi(argv[1]);
    int blocksize = atoi(argv[2]);
    int associativity;
    char replace_policy[10];
    char filename[10];
    if ( strncmp(argv[3],"f",1) ==0 )
        associativity = cachesize*1024 /blocksize;  // cache has 1024 blocks
    else if ( strncmp(argv[3],"1",1) ==0 ||strncmp(argv[3],"2",1) ==0  //  1 ,2,4,8
             ||strncmp(argv[3],"4",1) ==0 ||strncmp(argv[3],"8",1) ==0 )
        associativity = atoi(argv[3]);
    strcpy(replace_policy,argv[4]);
    strcpy(filename,argv[5]);
    //=========================================argv input process=========================//

    //=========================================compute index ,tag ,offset  =========================//
    int index,tag,offset;
    int cacheTotIndex;
    index = log2((cachesize * 1024) / (blocksize * associativity));
    tag = 32 - ( index + (log2(blocksize) - 2) ); // offset ¬°2
    cacheTotIndex = pow( 2,index );
    //offset = 32-index-tag;
    offset = log2(blocksize);

    printf( "tag_bit:%d\n",tag );
    printf( "index_bit:%d\n",index );
    printf( "offset_bit:%d\n",offset );
    printf( "cacheTotIndex:%d\n",cacheTotIndex );

    //========================================= ReadInput and Reset =========================//
    ReadInput(filename,tag,index,offset );
    //printf( "boot\n" );
    boot();


    //========================================= compute =========================//
    //printf( "compute\n" );
    for ( i = 0 ;i<instr_num;i++ ){
        if ( instr[i].type == 0 )
            readData++;
        else if ( instr[i].type == 1 )
            writeData++;
        process( i, replace_policy,associativity,blocksize  );
    }//for

    clean_cache( blocksize );

    //printf( "output\n" );
    //========================================= Output =========================//
    printf("Input file = %s\n", filename);
    printf("Demand Fetch = %d\n", instr_num);
    printf("Cache hit = %d\n", cacheHit);
    printf("Cache miss = %d\n", cacheMiss);
    printf("Miss rate = %.4f\n", ((double)cacheMiss / (double)instr_num));
    printf("Read data = %d\n", readData);
    printf("Write data = %d\n", writeData);
    printf("Bytes from memory = %d\n", bytesFromMem);
    printf("Bytes to memory = %d\n", bytesToMem);

	return 0;



}//main()

void boot(){
    int i;
    for ( i = 0; i <10000000 ;i++ ){
        cachetb[i].data = 0;
        cachetb[i].dirty_bit = 0;
        cachetb[i].ins = 0;
        cachetb[i].tag = 0;
        cachetb[i].used = 0;
        cachetb[i].valid = 0;
    }//for
}//boot

int hit(int cacheIdxBase, int associativity, int instructionIdx){
    int i ;
    cacheIdxBase *= associativity;
    for ( i =0 ; i<associativity ;i++ ){
        if (cachetb[cacheIdxBase + i].tag == instr[instructionIdx].tag  )//&&cachetb[cacheIdxBase + i].valid ==1 )
            return cacheIdxBase + i;
    }//for

    return -1;
}//hit


int replacePolicy( char replace_policy[], int cacheIdxBase, int associativity ){
    int i;
    cacheIdxBase *= associativity;

    if ( strcmp( replace_policy,"FIFO" ) ==0 ){

        //滿了得時候改成-1
        //printf( "FIFO\n" );
        if ((FIFO_pointer[cacheIdxBase] + 1) == associativity)
            FIFO_pointer[cacheIdxBase] = -1;
        FIFO_pointer[cacheIdxBase]++;
        return FIFO_pointer[cacheIdxBase] + cacheIdxBase;
    }//if

    else if ( strcmp( replace_policy,"LRU" ) ==0 ){
        int min = 1000000000, minChBk = -1;
        for (i = 0; i < associativity; i++) {
            if ( cachetb[cacheIdxBase+i].valid ==0 )
                return (cacheIdxBase + i);

            //valid !=0
            else if ( cachetb[cacheIdxBase+i].ins < min ){
                min = cachetb[cacheIdxBase+i].ins;
                minChBk = cacheIdxBase+i;
            }//else if

        }//for
        return minChBk;
    }//else if

    else {
        printf( "input policy error!!!\n" );
    }//else


}//replacePolicy

void process( int instructionIdx, char replace_policy[] ,int associativity,int blocksize   ){
    int cacheIdxBase = instr[instructionIdx].index;
    int hitIndex =  hit(cacheIdxBase, associativity, instructionIdx);

    //hit
    if ( hitIndex != -1 ){
        cacheHit++;
        cachetb[hitIndex].used++;
        cachetb[hitIndex].ins = instructionIdx;

        //read
        if ( instr[instructionIdx].type ==0 || instr[instructionIdx].type ==2 )
            return;

        // write
        else if ( instr[instructionIdx].type ==1 )
            cachetb[hitIndex].dirty_bit = 1;

    }//if


    //miss
    else{

        int targetBlock = replacePolicy( replace_policy, cacheIdxBase, associativity );
        //printf( "targetblock:%d\n",targetBlock );
        cacheMiss++;

        //dirty 需要先寫回記憶體
        if ( cachetb[targetBlock].dirty_bit == 1 )
            bytesToMem+=blocksize;

        //READ

        bytesFromMem +=blocksize;
        cachetb[targetBlock].valid =1;
        cachetb[targetBlock].tag = instr[instructionIdx].tag;
        cachetb[targetBlock].used =0;
        cachetb[targetBlock].ins =instructionIdx;

        //read
        if ( instr[instructionIdx].type ==0 || instr[instructionIdx].type ==2 )
            cachetb[targetBlock].dirty_bit = 0;

        // write
        else if ( instr[instructionIdx].type ==1 )
            cachetb[targetBlock].dirty_bit = 1;
    }//else
}//process



void clean_cache(int blocksize){
    int i;
    for ( i = 0 ;i<10000000;i++ ){
        if ( cachetb[i].dirty_bit == 1 )
            bytesToMem+=blocksize;

    }//for

}//clean_cache

void ReadInput( char *filename,int tag,int index,int offset ){
    int i,exp2_offset,exp2_index_add_offset;
    FILE *fin;
	fin=fopen(filename,"r");
    //printf( "test1\n" );

    while (feof(fin)== 0){
        fscanf(fin,"%d",&instr[instr_num].type);
        fscanf(fin,"%x",&instr[instr_num].instruction);
        if ( instr[instr_num].instruction != 0 )
            instr_num++;
        /*
        if ( instr_num%100 ==0 ){
            printf( "instr_num:%d\n",instr_num );
            printf( "%d ",instr[instr_num-1].type );
            printf( "%x\n",instr[instr_num-1].instruction );
        }//if
        */
    }//while

    //經過公式推倒得到如下
    //instruction / exp2_index_add_offset = (tag)10   ;
    //(instruction % exp2_index_add_offset)/exp2_offset = (index)10   ;
    //(instruction % exp2_index_add_offset)%exp2_offset = (offset)10   ;
    exp2_index_add_offset = pow(2,index+offset);
    exp2_offset = pow(2,offset);

    for ( i = 0 ;i<instr_num;i++ ){
        instr[i].tag = instr[i].instruction / exp2_index_add_offset;
        int mod = instr[i].instruction % exp2_index_add_offset;
        instr[i].index = mod / exp2_offset;
        instr[i].offset = mod % exp2_offset;
    }//for







    //printf( "%d ",instr[instr_num-1].type );
    //printf( "%x\n",instr[instr_num-1].instruction );
    //printf( "instr_num:%d\n",instr_num );

    /*
    for ( i = 0; i <instr_num;i+=1000  ){
        printf( "type:%d\n",instr[i].type );
        printf( "instruction:%x\n",instr[i].instruction );
        printf( "tag:%x\n",instr[i].tag );
        printf( "index:%x\n",instr[i].index );
        printf( "offset:%x\n",instr[i].offset );
    }//for
    */

    //printf( "test3\n" );
    fclose(fin);
}//ReadInput
