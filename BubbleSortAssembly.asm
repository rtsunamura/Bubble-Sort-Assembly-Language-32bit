INCLUDE Irvine32.inc

.data
array dword 10 dup(?)
LastVal dword ?
PrevVal dword ?
count dword ?
prompt byte " Enter a value ",0
prompt1 byte " Before sort: ",0
prompt2 byte " After sort: ",0
.code
main proc
mov eax,0
mov ebx,0
mov ecx,0
mov edx,0
mov esi,offset array
mov ecx,lengthof array
mov ebx,type array
call StoreValue
call crlf
mov edx,offset prompt1
call WriteString
call DumpMem ;Show memory
call sort ;sort 
call crlf
mov edx,offset prompt2
call WriteString
call DumpMem
exit
main endp
;***************************************************
StoreValue proc USES esi eax ebx ecx edx
mov eax,0
mov ebx,0
L1:
mov edx,offset prompt
call WriteString
add ebx,1
call ReadInt
mov [esi],eax
add esi,type array
loop L1
ret
StoreValue endp
;***************************************************
sort proc USES esi eax ebx ecx edx
mov eax,0 ;EAX = Item 1
mov ebx,0 ;EBX = Item 2 (array[i] = EAX, array[i - 1] = EBX)
mov ecx,0 ;ECX = Counter
mov edx,lengthof array
dec edx ;EDX = Number of loops 
.WHILE ecx < edx
mov esi,offset array 
add esi,36 ;For Get Last item
mov count,ecx ;PUSH ECX
mov ecx,0
push edx ;PUSH EDX
sub edx,count ;Set the range of movement
.WHILE ecx < edx 
mov eax,[esi]
push esi ;PUSH ESI
sub esi,4 
mov ebx,[esi] 
.IF eax < ebx 
mov [esi],eax
pop esi ;POP ESI
mov [esi],ebx
.ELSE
pop esi ;POP ESI
.ENDIF
sub esi,4
Inc ecx 
.ENDW
pop edx ;POP EDX
mov ecx,count ;POP ECX
Inc ecx
.ENDW
ret
sort endp
;*********************************************************
End main