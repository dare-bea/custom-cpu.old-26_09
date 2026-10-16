; SP[2] = dest
; SP[4] = src
; SP[6] = count
; returns dest
memcpy:
    LSA 2
    LWA
    PSH
; SP[0] = old dest
; SP[2] = return address
; SP[4] = dest
; SP[6] = src
; SP[8] = count
memcpy_loop:
    LSA 8
    LWA
    LIB 0
    CMP
    JBE memcpy_end
    DEC
    LSB 8
    STW
    LSA 6
    LWA
    LDA
    LSB 4
    LWB
    STO
    LSA 6
    MVB
    LWA
    INC
    STW
    LSA 4
    MVB
    LWA
    INC
    STW
    JMP memcpy_loop
memcpy_end:
    POP
    RET