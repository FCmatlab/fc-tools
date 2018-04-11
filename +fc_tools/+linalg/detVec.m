function D=detVec(A)
% A : N-by-d-by-d
% D : N-by-1
% D(i) = det A(i,:,:)
  D=fc_tools.linalg.detVec_v04(A);
end
