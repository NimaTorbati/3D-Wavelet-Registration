function [cof]=nim3d_cof_update_wav(level1,cof,T,siz,gamma)
a1=sum(siz(1:level1));
cofx=cof(:,:,1);cofy=cof(:,:,2);cofz=cof(:,:,3);
    %%%%%%%%%%%%%%%%%%%%%%
    
cofx(1:a1,:)=-(gamma)*(T(1:a1,1))+cof(1:a1,:,1);
cofy(1:a1,:)=-(gamma)*(T(1:a1,2))+cof(1:a1,:,2);
cofz(1:a1,:)=-(gamma)*(T(1:a1,3))+cof(1:a1,:,3);
cof=cat(4,cofx(:),cofy(:),cofz(:));
