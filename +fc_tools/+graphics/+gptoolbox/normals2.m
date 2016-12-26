function [ N ] = normals2(V,F,varargin)
  % NORMALS Compute *unnormalized* normals per face
  %
  % N = normals(V,F)
  % N = normals(V,F,'ParameterName',ParameterValue, ...)
  %
  % Inputs:
  %  V  #V x 3 matrix of vertex coordinates
  %  F  #F x 3  matrix of indices of triangle corners
  %  Optional:
  %    'Stable' followed by whether to compute normals in a way stable with
  %      respect to vertex order: constant factor more expensive {false}
  %    'UseSVD' followed by whether to use SVD, slow {false}
  % Output:
  %  N  #F x 3 list of face normals
  %

  stable = false;
  use_svd = false;
  
  p1 = V(F(:,1),:);
  p2 = V(F(:,2),:);
  p3 = V(F(:,3),:);
  
  if use_svd
    N = zeros(size(F,1),3);
    BC = fc_tools.graphics.gptoolbox.barycenter(V,F);
    for f = 1:size(F,1)
      Uf = bsxfun(@minus,V(F(f,:),:),BC(f,:));
      [~,~,sV] = svd(Uf);
      N(f,:) = sV(:,3);
    end
    NN = fc_tools.graphics.gptoolbox.normals2(V,F,'UseSVD',false);
    N(sum(N.*NN,2)<0,:) = N(sum(N.*NN,2)<0,:)*-1;
  else
    % ,2 is necessary because this will produce the wrong result if there are
    % exactly 3 faces
    N1 = cross(p2 - p1, p3 - p1,2);
    if stable
      N2 = cross(p3 - p2, p1 - p2,2);
      N3 = cross(p1 - p3, p2 - p3,2);
      N = sum3(N1,N2,N3)/3;
    else
      N = N1;
    end
  end
end

function D = sum3(A,B,C)
  % SUM3 Entrywise sum of three matrices in a stable way: sorting entries by
  % value and summing 
  shape = size(A);
  ABC = [A(:) B(:) C(:)];
  [~,I] = sort(abs(ABC),2,'descend');
  sABC = reshape( ...
    ABC(sub2ind(size(ABC),repmat(1:size(ABC,1),size(ABC,2),1)',I)),size(ABC));
  D = reshape(sum(sABC,2),shape);
end

