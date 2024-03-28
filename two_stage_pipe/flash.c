int main(){
    int n=1;
    int* led_data = (int*) 0x0;  // the output of led is the value from the first address of data_memory 	
    while (1){
    	*led_data = n;
    	n++;
    	for ( int i =0; i<12500000;i++);
    }
    return 0;
}

// The assebmly code
	.file	"flash.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	    s0,28(sp)
	addi	s0,sp,32
	li	    a5,1
	sw	    a5,-20(s0)
	sw	    zero,-28(s0)
.L4:
	lw	    a5,-28(s0)    
	lw	    a4,-20(s0)
	sw	    a4,0(a5)
	lw	    a5,-20(s0)
	addi	a5,a5,1
	sw	    a5,-20(s0)
	sw	    zero,-24(s0)
	j	    .L2
.L3:
	lw	    a5,-24(s0)
	addi	a5,a5,1
	sw	    a5,-24(s0)
.L2:
	lw	    a4,-24(s0)
	li	    a5,12500992
	addi	a5,a5,-993
	ble	    a4,a5,.L3
	j	    .L4

    // The diassembly code:
 Disassembly of section .text:
0000000000000000 <_boot>:
   0:	01c10113          	addi	sp,sp,32
   4:	00010413          	addi    so, sp, 0
   8:	00178793          	li	a5,1					//addi a5 a5 1
   c:	fef42623          	sw	a5,-20(s0)
  10:	fe042223          	sw	zero,-28(s0)
  14:	fe442783          	lw	a5,-28(s0)
  18:	fec42703          	lw	a4,-20(s0)
  1c:	00e7a023          	sw	a4,0(a5)
  20:	fec42783          	lw	a5,-20(s0)
  24:	00178793          	addi	a5,a5,1
  28:	fef42623          	sw	a5,-20(s0)
  2c:	fe042423          	sw	zero,-24(s0)
  30:	010000ef          	jal	ra,10 <_boot+0x10> 		//jal x1, +16
  34:	fe842783          	lw	a5,-24(s0)
  38:	00178793          	addi	a5,a5,1
  3c:	fef42423          	sw	a5,-24(s0)
  40:	fe842703          	lw	a4,-24(s0)		
  44:	000f47b7          	lui	a5,0xf4
  48:	23f78793          	addi	a5,a5,575            
  4c:	fee7d0e3          	bge	a5,a4,-24            
  50:	fc5ff0ef          	jal     x1, -60             //jump to 14   
