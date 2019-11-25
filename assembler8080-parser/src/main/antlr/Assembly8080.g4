grammar Assembly8080;

program : line* EOF ;
line: label colon (opcode | directive)
    | opcode
    | directive
    | eol ;

label: Label;
colon: ':';
eol: NEWLINE ;
directive: assignment | org | dw | db | ds
 | set | end | if | endif | macro | endm ;

opcode : nop | jmp | call | lxi
    | ora | rz | mov | dad | sui | cpi | cmc
    | rc | inx | mvi | jnz | sta | jc | jz | pop
    | push | shld | cma | stc | inr | dcr | stax | ldax | daa
     | add | adc | sub | sbb | ana | xra | cmp | rlc | rrc | ral | rar | push
     | pop | inx | dcx | xchg | xthl | sphl
     | aci | sui | sbi | ani | xri | ori | cpi | adi
     | lda | lhld | pchl | rst
		| call | cc | cnc | cz | cnz | cm | cp | cpe | cpo
		| ret| rc| rnc| rz| rnz| rm| rp| rpe| rpo
		    | jmp |jnz |jz |jnc |jc |jpo |jpe |jp |jm
		    | ei | di | in | out | hlt;

list: (value8 ( ',' value8 ) *) | string ;
dw: 'DW' list;
db: 'DB' list;
ds: 'DS' value16;
assignment: 'EQU' value16 ;
org: 'ORG' value16;
set: 'SET' expression;
end: 'END';
if: 'IF' expression;
endif: 'ENDIF' ;
macro: 'MACRO' list;
endm: 'ENDM';

cma: 'CMA';
cmc: 'CMC' ;

ret : 'RET';
rc : 'RC';
rnc : 'RNC';
rz : 'RZ';
rnz : 'RNZ';
rm : 'RM';
rp : 'RP';
rpe : 'RPE';
rpo : 'RPO';

daa: 'DAA';
xchg: 'XCHG';
xthl: 'XTHL';
sphl: 'SPHL';
pchl: 'PCHL';

adi: 'ADI' value8;
cpi: 'CPI' value8;
ori: 'ORI' value8;
aci: 'ACI' value8;
sui: 'SUI' value8;
sbi: 'SBI' value8;
ani: 'ANI' value8;
xri: 'XRI' value8;

jmp: 'JMP' value16;
jnz: 'JNZ' value16;
jz: 'JZ' value16;
jnc: 'JNC' value16;
jc: 'JC' value16;
jpo: 'JPO' value16;
jpe: 'JPE' value16;
jp: 'JP' value16;
jm: 'JM' value16;

sta: 'STA' value16;
lda: 'LDA' value16;
shld: 'SHLD' value16;
lhld: 'LHLD' value16;

in: 'IN' value8;
out: 'OUT' value8;

hlt: 'HLT';

push: 'PUSH' (register16 | aPlusStatus);
pop: 'POP' (register16 | aPlusStatus);
dad: 'DAD' register16;
dcx: 'DCX' register16;
inx: 'INX' register16;
add: 'ADD' register8;
adc: 'ADC' register8;
ana: 'ANA' register8;
xra: 'XRA' register8;
ora: 'ORA' register8;
cmp: 'CMP' register8;
rlc: 'RLC' register8;
rrc: 'RRC' register8;
ral: 'RAL' register8;
rar: 'RAR' register8;
dcr: 'DCR' register8;
inr: 'INR' register8;
lxi: 'LXI' (register8 | register16) ',' value8 ;
mov: 'MOV' register8 ',' register8;
mvi: 'MVI' register8 ',' value8;
nop: 'NOP' ;
sbb: 'SBB' register8;
stax: 'STAX' (register8 | register16);
sub: 'SUB' register8;
ldax: 'LDAX' (register8 | register16);
stc: 'STC' ;

rst: 'RST' value3;

call: 'CALL' value16;
cc: 'CC' value16;
cnc: 'CNC' value16;
cz: 'CZ' value16;
cnz: 'CNZ' value16;
cm: 'CM' value16;
cp: 'CP' value16;
cpe: 'CPE' value16;
cpo: 'CPO' value16;

ei: 'EI';
di: 'DI';

value8: expression ;
value3: expression ;
value16: expression;
expression: term ( (Plus|Minus) term) * ;
term: atom ((Times|Divide) atom) * ?;
atom: '$' | Literal | Label | char | '(' value8 ')' ;
register16: bc | de | hl | sp ;
bc: 'B' | 'BC';
de: 'D' | 'DE';
hl: 'H' | 'HL';
sp: 'SP';
char: '\'' Char '\'';
string: '"' Char * '"';
aPlusStatus: 'PSW';
register8: 'A' | 'B' | 'C' | 'D' | 'E' | 'M' | 'H' | 'L' ;

Plus: '+';
Minus: '-';
Times: '*';
Divide: '/';
Literal: [0-9]+[H]?;
Label: [A-Z][A-Z0-9]* ;
WS: [ \t] -> skip;
Comment :  ';' ~( '\r' | '\n' )* -> skip;
NEWLINE: [\n\r]+  ;
Char: .;
