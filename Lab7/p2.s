.text

## int
## vert_strncmp(const char* word, int start_i, int j) {
##     int word_iter = 0;
## 
##     for (int i = start_i; i < num_rows; i++, word_iter++) {
##         if (get_character(i, j) != word[word_iter]) {
##             return 0;
##         }
## 
##         if (word[word_iter + 1] == '\0') {
##             // return ending address within array
##             return i * num_columns + j;
##         }
##     }
## 
##     return 0;
## }

.globl vert_strncmp
vert_strncmp:

sub $sp, $sp, 28
sw $ra, 0($sp)  ##preserve for ra (return)
sw $s0, 4($sp)  ##preserve for $a0
sw $s1, 8($sp)	##preserve for a1
##sw $s2, 12($sp)	##preserve for a2
sw $s3, 16($sp) ##preserve for word_iter
sw $s4, 20($sp) ##preserve for num_rows
sw $s5, 24($sp) ##preserve for num_columns

move $s0, $a0  ##word
move $s1, $a1  ##start_i
##move $s2, $a2  ##int j


li $s3, 0   #word_iter
la $s4, num_rows #get the address of num_rows
lw $s4, 0($s4)   #get the num_rows

add $a0, $s1, $0  ##set i = start_i set i in the $a0
move $a1, $a2 ## set j in the $a1

loop_s:
bge $a0, $s4, done_1 ##check the for loop condition 
jal get_character   ##call the function
add $t1, $s3, $s0  ##get the address of the word[word_iter]  it is &
lb $t1, 0($t1)  ##get the character of the word[word_iter]
bne $v0, $t1, done_1  ##compare the condition
add $s3, $s3, 1  ##increment the word_iter counter
add $t2, $s3, $s0  ##get the address of the word[word_iter+1]  it is &
lb $t2, 0($t2)
beq $t2, $0, done_2
j loop_s

jr $ra


done_1:
li $v0, 0   ##set the stack pointer originally 
        lw      $ra, 0($sp)
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        lw      $s2, 12($sp)
        lw      $s3, 16($sp)
        lw      $s4, 20($sp)
        lw      $s4, 24($sp)
        add     $sp, $sp, 28
        jr      $ra

done_2: 
##li $v0,0  ##set the stack pointer originally  
mul $v0, $a0, $s5
add $v0, $v0, $a1
lw      $ra, 0($sp)
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        lw      $s2, 12($sp)
        lw      $s3, 16($sp)
        lw      $s4, 20($sp)
        lw      $s4, 24($sp)
        add     $sp, $sp, 28
	jr      $ra



## // assumes the word is at least 4 characters
## int
## horiz_strncmp_fast(const char* word) {
##     // treat first 4 chars as an int
##     unsigned x = *(unsigned*)word;
##     unsigned cmp_w[4];
##     // compute different offsets to search
##     cmp_w[0] = x;
##     cmp_w[1] = (x & 0x00ffffff); 
##     cmp_w[2] = (x & 0x0000ffff);
##     cmp_w[3] = (x & 0x000000ff);
## 
##     for (int i = 0; i < num_rows; i++) {
##         // treat the row of chars as a row of ints
##         unsigned* array = (unsigned*)(puzzle + i * num_columns);
##         for (int j = 0; j < num_columns / 4; j++) {
##             unsigned cur_word = array[j];
##             int start = i * num_columns + j * 4;
##             int end = (i + 1) * num_columns - 1;
## 
##             // check each offset of the word
##             for (int k = 0; k < 4; k++) {
##                 // check with the shift of current word
##                 if (cur_word == cmp_w[k]) {
##                     // finish check with regular horiz_strncmp
##                     int ret = horiz_strncmp(word, start + k, end);
##                     if (ret != 0) {
##                         return ret;
##                     }
##                 }
##                 cur_word >>= 8;
##             }
##         }
##     }
##     
##     return 0;
## }

.globl horiz_strncmp_fast
horiz_strncmp_fast:
	sub $sp, $sp,
	sw $ra, 0($sp)  ##preserve for ra (return address)
	sw $s0, 4($sp)  ##preserve for $a0 (word)
        sw $s1, 8($sp)  ##preserve for $cmp_w[0]
	sw $s2, 12($sp) ##preserve for $cmp_w[1]
	sw $s3, 16($sp) ##preserve for $cmp_w[2]
	sw $s4, 20[$sp) ##preserve for $cmp_w[2]

	##sw $s1, 8($sp)	##preserve for 

	li $v0, 0
	move $t1, $a0            	##let $t1 be x in this case	
	move $s1, $t0            	##store x into cmp_w[0]
	and $s2, $t0, 0x00ffffff   	##store x & 0x00ffffff into cmp_w[1]
	and $s3, $t0, 0x0000ffff	##store x & 0x0000ffff into cmp_w[2]
	and $s4, $t0, 0x000000ff  	##store x & 0x000000ff into cmp_w[3]
	

	lw $t2, num_rows   ##store the num_rows in $t2
	lw $t3, num_columns ##store the num_columns in $t3
	li $t4, 0          ##store the value 0 in $t4, initilized for i
for_loop1:	
	bge $t4, $t3, done_1 
	
	
	
	 
	


	jr	$ra


done_1:
	jr $ra
