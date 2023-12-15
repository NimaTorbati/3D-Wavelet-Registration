function [Xx,Xy,Xz,dx,dy,dz]=nim3D_nodes2grid(X, F, siz,cof,scale,filt,siz1,level,LoRa)
if LoRa(1)
    for k=LoRa(2):LoRa(3)
        LR=k;
    switch LR
        case 1
        Fx=F;
        cofx=cof(:,:,:,1);
        for i=1:scale
            if i==1
                Fx{1,i}{1,1}=reshape(cofx(1:siz(1)),size(Fx{1,i}{1,1}));

            else
                as=length(F{1,i});
                for j=1:as
                    Fx{1,i}{1,j}=reshape(cofx(sum(siz(1:i-1))+(j-1)*(siz(i)/as)+1:sum(siz(1:i-1))+j*(siz(i)/as)),size(Fx{1,i}{1,j}));

                end
            end
        end

        [C]=nim3d_vec2wav(Fx,level,siz1(4,:),siz1,filt);
        dx = waverec3(C);
        Xx=X(:,:,:,1)+dx;
        clear Fx C cofx;
        case 2
        Fy=F;
        cofy=cof(:,:,:,2);
        for i=1:scale
            if i==1
                Fy{1,i}{1,1}=reshape(cofy(1:siz(1)),size(Fy{1,i}{1,1}));

            else
                as=length(F{1,i});
                for j=1:as
                    Fy{1,i}{1,j}=reshape(cofy(sum(siz(1:i-1))+(j-1)*(siz(i)/as)+1:sum(siz(1:i-1))+j*(siz(i)/as)),size(Fy{1,i}{1,j}));

                end
            end
        end

        [C]=nim3d_vec2wav(Fy,level,siz1(4,:),siz1,filt);
        dy = waverec3(C);
        Xy=X(:,:,:,2)+dy;
        clear Fy C cofy;
        case 3
        Fz=F;
        cofz=cof(:,:,:,3);
        for i=1:scale
            if i==1
                Fz{1,i}{1,1}=reshape(cofz(1:siz(1)),size(Fz{1,i}{1,1}));

            else
                as=length(F{1,i});
                for j=1:as
                    Fz{1,i}{1,j}=reshape(cofz(sum(siz(1:i-1))+(j-1)*(siz(i)/as)+1:sum(siz(1:i-1))+j*(siz(i)/as)),size(Fz{1,i}{1,j}));

                end
            end
        end

        [C]=nim3d_vec2wav(Fz,level,siz1(4,:),siz1,filt);
        dz = waverec3(C);
        Xz=X(:,:,:,3)+dz;
        clear Fz C cofz;
    end
    end
        if ~exist('Xx','var')
            Xx=0;
            dx=0;
        end
        if ~exist('Xy','var')
            Xy=0;
            dy=0;
        end
        if ~exist('Xz','var')
            Xz=0;
            dz=0;
        end
    
else













Fx=F;
Fy=F;
Fz=F;
cofx=cof(:,:,:,1);
cofy=cof(:,:,:,2);
cofz=cof(:,:,:,3);
for i=1:scale
    if i==1
        Fx{1,i}{1,1}=reshape(cofx(1:siz(1)),size(Fx{1,i}{1,1}));
        Fy{1,i}{1,1}=reshape(cofy(1:siz(1)),size(Fy{1,i}{1,1}));
        Fz{1,i}{1,1}=reshape(cofz(1:siz(1)),size(Fz{1,i}{1,1}));
        
    else
        as=length(F{1,i});
        for j=1:as
            Fx{1,i}{1,j}=reshape(cofx(sum(siz(1:i-1))+(j-1)*(siz(i)/as)+1:sum(siz(1:i-1))+j*(siz(i)/as)),size(Fx{1,i}{1,j}));
            Fy{1,i}{1,j}=reshape(cofy(sum(siz(1:i-1))+(j-1)*(siz(i)/as)+1:sum(siz(1:i-1))+j*(siz(i)/as)),size(Fy{1,i}{1,j}));
            Fz{1,i}{1,j}=reshape(cofz(sum(siz(1:i-1))+(j-1)*(siz(i)/as)+1:sum(siz(1:i-1))+j*(siz(i)/as)),size(Fz{1,i}{1,j}));        

        end
    end
end

[C]=nim3d_vec2wav(Fx,level,siz1(4,:),siz1,filt);
dx = waverec3(C);
[C]=nim3d_vec2wav(Fy,level,siz1(4,:),siz1,filt);
dy = waverec3(C);
[C]=nim3d_vec2wav(Fz,level,siz1(4,:),siz1,filt);
dz = waverec3(C);
Xx=X(:,:,:,1)+dx;
Xy=X(:,:,:,2)+dy;
Xz=X(:,:,:,3)+dz;




end