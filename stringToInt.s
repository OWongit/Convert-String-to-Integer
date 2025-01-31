# Owen Wilhere
# 1/30/2025
# Converts a string into a integer.
#
#
.globl my_atoi
my_atoi:

    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    
    mv s1, a0
    li s0, 0
    li t0, 0
    
    # check for a null pointer
    beqz s1, end
    
    # check sign
    lb t1, 0(s1)
    li t2, 45
    bne t1, t2, if_plus
    li t0, 1
    addi s1, s1, 1
    j loop
    
if_plus:
    li t2, 43
    bne t1, t2, loop
    addi s1, s1, 1
    
loop:
    lb t1, 0(s1)
    beqz t1, apply_sign
    
    # Check if character is digit
    li t2, 48
    blt t1, t2, apply_sign
    li t2, 57
    bgt t1, t2, apply_sign
    
    slli t2, s0, 3       # result * 8
    slli t3, s0, 1       # result * 2
    add s0, t2, t3       # result = result * 10
    
    # Add current digit
    addi t1, t1, -48
    add s0, s0, t1
    
    addi s1, s1, 1
    j loop
    
apply_sign:
    beqz t0, end
    neg s0, s0
    
end:
    mv a0, s0
    
    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp)
    addi sp, sp, 16
    ret