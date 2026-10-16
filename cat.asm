int main(void) {
    *VRAM_INDEX = 0;
    do {
        *VRAM_TILE = 0;
    } while (*VRAM_INDEX);
    while (1) {
        u16 ch;
        do {
            ch = *INPUT;
        } while (ch == 0xFFFF);
        *VRAM_TILE = ch;
        if (ch == '\n') {
            VRAM_ROW += 1;
            VRAM_COL = 0;
        }
        if (*VRAM_INDEX == 0) {
            do {
                *VRAM_ROW += 1;
                u8 tile = *VRAM_TILE;
                *VRAM_ROW -= 1;
                *VRAM_TILE = tile;
            } while (*VRAM_INDEX != 31 << 8);
            do {
                *VRAM_TILE = 0;
            } while (*VRAM_INDEX);
            *VRAM_INDEX = 31 << 8;
        }
    }
    return 0;
}

main:
    lia 0
    lib VRAM_INDEX
    stw
    main_l1:
        lib VRAM_TILE
        sto
        lib VRAM_INDEX
        lwb
        cmp
        jnz main_l1
    main_l2:
        lib 0xFFFF
        main_l2l1:
            lia INPUT
            lwa
            cmp
            jz main_l2l1
        lib VRAM_TILE
        sto
        lib 0xA
        cmp
        jnz main_l2l2
            lib VRAM_ROW
            mva
            lda
            inc
            sto
            lib VRAM_COL
            lia 0
            sto
        main_l2l2:
        lib 0
        lia VRAM_INDEX
        lwa
        cmp
        jnz main_l2
            main_l2l3l1:
                lib VRAM_ROW
                mva
                lda
                inc
                sto
                lia VRAM_TILE
                lda
                psh
                lib VRAM_ROW
                mva
                lda
                dec
                sto
                lib VRAM_TILE
                pop
                sto
                lia VRAM_INDEX
                lwa
                lib 31 << 8
                cmp
                jnz main_l2l3l1
            main_l2l3l2:
                lia 0
                lib VRAM_TILE
                sto
                lib VRAM_INDEX
                lwb
                cmp
                jnz main_l2l3l2
            lib VRAM_INDEX
            lia 31 << 8
            stw
        jmp main_l2

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
