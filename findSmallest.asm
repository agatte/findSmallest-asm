.data
min:        .word       0
xyz:        .word       -8,16,-32,64,928,256
msg_min:    .asciiz     "min: "
msg_tot:    .asciiz     " total: "
crlf:     .asciiz     "\n"
 .text
    .globl  findSmallest

findSmallest:
    la      $s0,xyz                 # p = foo
    addi    $s1,$s0,24              # end = p + 6
    add     $s3,$0,$0         # total = 0
    la      $s2,min                 # point to min
    lw      $t4,0($s0)              # fetch xyz[0]
    sw      $t4,0($s2)              # store in min

iterate:
    beq     $s0,$s1,main_done       # if (p == end) goto L2

    lw      $t0,0($s0)              # $t0 = *p
    addi    $s0,$s0,4               # p++

    lw      $t4,0($s2)              # fetch min
    sgt     $t2,$t4,$t0             # *p < min?
    bne     $t2,$zero, iterate    # no, loop

    sw      $t0,0($s2)              # store new/better min value
    j       iterate

main_done:
    li      $v0,4
    la      $a0,msg_min
    syscall

    li      $v0,1
    lw      $a0,0($s2)              # get min value
    syscall

    li      $v0,4
    la      $a0, crlf
    syscall

    # exit program
    li      $v0,10
    syscall