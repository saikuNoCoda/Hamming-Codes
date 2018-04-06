%Hamming code simulation-JC-4/15/06
%To run hit F5 and observe command window
%Simulation for encoding and decoding of a [7,4] Hamming code. The decoder
%can correct one error as shown and as theory states. The table at the end
%of the file shows the various outputs with different error positions and
%message bits. One error can be placed at any of the 7 bit locations and
%corrections made.
clear
n = 7%# of codeword bits per block
k = 4%# of message bits per block
A = [ 1 1 1;1 1 0;1 0 1;0 1 1 ];%Parity submatrix-Need binary(decimal combination of 7,6,5,3)            
G = [ eye(k) A ]%Generator matrix
H = [ A' eye(n-k) ]%Parity-check matrix
% Encode %
msg = [ 1 1 1 1 ] %Message block vector-change to any 4 bit sequence
code = mod(msg*G,2)%Encode message
% CHANNEL ERROR(add one error to code)%
%code(1)= ~code(1);
 code(2)= ~code(2);
%code(3)= ~code(3);
%code(4)= ~code(4);%Pick one,comment out others
%code(5)= ~code(5);
%code(6)= ~code(6);
%code(7)= ~code(7);
recd = code %Received codeword with error
% Decode %
syndrome = mod(recd * H',2)
%Find position of the error in codeword (index)
find = 0;
for ii = 1:n
    if ~find
        errvect = zeros(1,n);
        errvect(ii) = 1;
        search = mod(errvect * H',2);
        if search == syndrome
            find = 1;
            index = ii;
        end
    end
end
disp(['Position of error in codeword=',num2str(index)]);
correctedcode = recd;
correctedcode(index) = mod(recd(index)+1,2)%Corrected codeword
%Strip off parity bits
msg_decoded=correctedcode;
msg_decoded=msg_decoded(1:4)