function [res1,res2]=nim3D_register_wav_cum(main, optim,i,j,ofilt,oreg,osim,oalpha,iters)
% Original image size
if exist('iters','var')
     main.steps=[100 100 100 100 100 100 100 100 50 100 100 100]*iters;
end

[main.im,main.refim,main.tf,main.rm,main.rf]=im_rigid_read_cum(i,j,main.sizi);
optim.alpha=oalpha;
main.pfilt = ofilt;%'sym4'; %fun{bas_fun};
optim.reg=oreg;
main.similarity=osim;  % similarity measure, e.g. SSD, CC, SAD, RC, CD2, MS,
[dimn]=size(main.im)/(2^(main.hier-1)*main.scll);
[Fj,siz,filt,siz1,level2w,nlevsw]=init_wavv(main.hier,dimn(1),dimn(3),dimn(2),main.scale,main.pfilt);
main.Fw=Fj;
main.msizw=siz;
main.filter=filt;
main.sizes=siz1;
main.level2w=level2w;
main.nlevsw=nlevsw;

% main.refim=refim;
% main.im=im;
% main.rm=rm;main.tf=tf;main.rf=rf;




M2=main.sizes{end}(end,:);


% gammma=optim.gamma;
%%%%%%%%%%%%%%%%%%%%%%%%%%%% for a full mode you should change main.hier-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%% to main.hier
sizi=main.sizi;

pp=0;
for hier=1:main.hier
%     if exist('jkl','var')
%     hcof=jkl;
%     end
%     optim.alpha=optim.alpha*2^(hier-1);
% if main.regg
%     main.reg=main.rreg{hier};
% end
    main.F=main.Fw{hier};
    main.subim=hier;
    main.filt=main.filter{hier};
    main.siz1=main.sizes{hier};
    main.level=main.level2w{hier};
    main.ssiz=main.msizw{hier};
    im=nim3D_imresize(main.im, [M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%     im=mirt3D_imresize(im1,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)]);
    refim=nim3D_imresize(main.refim, [M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
  
%     refim=mirt3D_imresize(refim1,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)]);
    
    M=M2/2^(main.hier-hier);
%     main.steps=round(main.steps/2);
% 
%     if M(1)==256
%     main.LoRa=[0 0 0];
%           % initial optimization step size
% %     main.level=main.level2w{hier}(end-1:end);
%      end
%     main.steps(main.level(end))=2*main.steps(main.level(end));
    main.siz=M;
    main.nlevss=main.nlevsw{hier};
% at the smallest hierarchical level (the smallest image size)
    [x, y ,z]=meshgrid(1:M(2), 1:M(1) ,1:M(3));
% if hier==1
%     dx=zeros(size(x));
%     dy=zeros(size(y));
%     dz=zeros(size(z));
    dx2=zeros(size(x));
    dy2=zeros(size(y));
    dz2=zeros(size(z));

% end

% the size of the B-spline mesh is in (main.mg, main.ng) at the smallest
% hierarchival level.
    main.X=cat(4,x,y,z);  % Put x and y control point positions into a single mg x ng x 2 3Dmatrix
    main.Xgrid=main.X;
%           cof1=jkl;
% if hier==main.hier
%             main.MIbins=2*main.MIbins;
% end
main.f=size(im,1)*size(im,2)*size(im,3);
dimax1=main.sizes{hier}(end);
[xe, ye ,ze]=meshgrid(1:124+sizi, 1:256+sizi ,1:256+sizi);
for level=main.level
%      level

        optim.maxsteps=main.steps(level);
%         optim.fundif = optim.fundif/optim.a
        aa=main.level2w{hier};
        siz=sum(main.ssiz(1:aa(end)));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        main.level1=level;
        
        % evaluate curvelet cofs
        if pp==1
            
%             
                
%                 dx=(256+sizi)/dimax1*nim3D_imresize(dx,[256 128 256]+sizi,'cubic');
%                 dy=(256+sizi)/dimax1*nim3D_imresize(dy,[256 128 256]+sizi,'cubic');
%                 dz=(256+sizi)/dimax1*nim3D_imresize(dz,[256 128 256]+sizi,'cubic');
% 
%                 Xx=xe+dx;
%                 Xy=ye+dy;
%                 Xz=ze+dz;

%                 dx=2*dimax1/(256+sizi)*nim3D_imresize(dx,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dy=2*dimax1/(256+sizi)*nim3D_imresize(dy,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dz=2*dimax1/(256+sizi)*nim3D_imresize(dz,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 if hier==2
%                 dx=2*nim3D_imresize(dx,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dy=2*nim3D_imresize(dy,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dz=2*nim3D_imresize(dz,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dx2=dx+dx2;
%                 dy2=dy+dy2;
%                 dz2=dz+dz2;
%                 else                
%                 dx2=2*nim3D_imresize(dx2,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dy2=2*nim3D_imresize(dy2,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dz2=2*nim3D_imresize(dz2,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
% %                 end
%                 
% 
%                 
%                 Xx=((256+sizi)/dimax1)*(main.X(:,:,:,1)+dx2);
%                 Xy=((256+sizi)/dimax1)*(main.X(:,:,:,2)+dy2);
%                 Xz=((256+sizi)/dimax1)*(main.X(:,:,:,3)+dz2);
% 
% 
% 
%                 im=interp3(xe,ye,ze,main.im,Xx,Xy,Xz,'cubic');
                imsmall=im;
%                 imsmall=nim3D_imresize(imsmall, [M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');

%                 if min(imsmall(:))<0
%                     imsmall=imsmall+abs(min(imsmall(:)));
%                 end
% %                 imsmall(imsmall<0)=0;
%                 imsmall=imsmall/max(imsmall(:));
                imsmall(imsmall>1)=1;

                imsmall(imsmall<0)=0;

                main.refimsmall=refim;
                [gradx, grady , gradz]=gradient(imsmall);
                main.imsmall=cat(4,imsmall, gradx,grady ,gradz);
                cofx=zeros(siz,1);
                cofy=zeros(siz,1);
                cofz=zeros(siz,1);
%                 dx=zeros(size(x));
%                 dy=zeros(size(y));
%                 dz=zeros(size(z));

                pp=0;
        elseif exist('cof1','var');

%                 Xx=main.X(:,:,:,1)+dx;
%                 Xy=main.X(:,:,:,2)+dy;
%                 Xz=main.X(:,:,:,3)+dz;
%             [Xx,Xy]=nim2D_nodes2grid(main.X, main.F,main.siz,cof1,main.level1-1);
%             main.X=cat(3,Xx,Xy);
%                 [Xx,Xy,Xz]=nim3D_nodes2grid(main.X, main.F, main.ssiz,main.cof,main.level1,main.filt,main.siz1,main.nlevss,main.LoRa);
%                 Xx=mirt3D_imresize(Xx,[M(1) M(2) M(3)]);
%                 Xy=mirt3D_imresize(Xy,[M(1) M(2) M(3)]);
%                 Xz=mirt3D_imresize(Xz,[M(1) M(2) M(3)]);

% %                 imsmall=interp3(x,y,z,im,main.X(:,:,:,1)+dx,main.X(:,:,:,2)+dy,main.X(:,:,:,3)+dz,'cubic');
                  imsmall=result;
%                    imsmall=im;
%                 if min(imsmall(:))<0
%                     imsmall=imsmall+abs(min(imsmall(:)));
%                 end
%                 dx=(256+sizi)/dimax1*nim3D_imresize(dx,[256 128 256]+sizi,'cubic');
%                 dy=(256+sizi)/dimax1*nim3D_imresize(dy,[256 128 256]+sizi,'cubic');
%                 dz=(256+sizi)/dimax1*nim3D_imresize(dz,[256 128 256]+sizi,'cubic');
% 
% %                 Xx=main.X(:,:,:,1)+dx;
% %                 Xy=main.X(:,:,:,2)+dy;
% %                 Xz=main.X(:,:,:,3)+dz;
%                 Xx=xe+dx;
%                 Xy=ye+dy;
%                 Xz=ze+dz;
% 
%                 dx=dimax1/(256+sizi)*nim3D_imresize(dx,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dy=dimax1/(256+sizi)*nim3D_imresize(dy,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
%                 dz=dimax1/(256+sizi)*nim3D_imresize(dz,[M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');
% 
% 
% 
%                 imsmall=interp3(xe,ye,ze,main.im,Xx,Xy,Xz);
%                 imsmall=nim3D_imresize(imsmall, [M2(1)/2^(main.hier-hier) M2(2)/2^(main.hier-hier) M2(3)/2^(main.hier-hier)],'cubic');





                imsmall(imsmall>1)=1;

                imsmall(imsmall<0)=0;
%                 imsmall=imsmall/max(imsmall(:));
                [gradx, grady , gradz]=gradient(imsmall);
                main.imsmall=cat(4,imsmall, gradx,grady ,gradz);

%                  main.imsmall=cat(4,result, dx1,dy1 ,dz1);




%                 imsmall = im; 
%             imsmall(imsmall<0)=0;
%             imsmall(imsmall>1)=1;
%             [gradx, grady ,gradz]=gradient(imsmall);
%             main.imsmall=cat(4,imsmall, gradx,grady, gradz);
            cofx(1:length(cof1(:,:,1)),1)=0*cof1(:,:,1);
            cofy(1:length(cof1(:,:,2)),1)=0*cof1(:,:,2);
            cofz(1:length(cof1(:,:,3)),1)=0*cof1(:,:,3);
            clear cof1;
        else
   
            imsmall=im; 
            main.refimsmall=refim; % resize images
%                 if min(imsmall(:))<0
%                     imsmall=imsmall+abs(min(imsmall(:)));
%                 end
% %                 imsmall(imsmall<0)=0;
%                 imsmall=imsmall/max(imsmall(:));
                 imsmall(imsmall>1)=1;

                imsmall(imsmall<0)=0;

            [gradx, grady, gradz]=gradient(imsmall);
            main.imsmall=cat(4,imsmall, gradx,grady,gradz);
            cofx=zeros(siz,1);
            cofy=zeros(siz,1);
            cofz=zeros(siz,1);

        end
        main.cof=cat(4,cofx,cofy,cofz);
    clear cofx cofy cofz gradx grady gradz imsmall dx1 dy1 dz1;

    [result,cof1,f1,dx1,dy1,dz1]=nim3D_registration_wav(main, optim);
%     dx=dx+dx1;
%     dy=dy+dy1;
%     dz=dz+dz1;

%         optim.gamma=optim.gamma/;
%     dx=dx1;dy=dy1;dz=dz1;
%     if hier==1
%     [res]=eval_IBSR(sizi,dimax1,i,j,main.rm,main.tf,main.rf,main.X(:,:,:,1)+dx,main.X(:,:,:,2)+dy,main.X(:,:,:,3)+dz);
% 
%     res1{hier}=res;
%     disp(res{4})
%     else
    dx2=dx1+dx2;
    dy2=dy1+dy2;
    dz2=dz1+dz2;
 
        
%         
%     [res]=eval_CUM(sizi,dimax1,i,j,main.rm,main.tf,main.rf,main.X(:,:,:,1)+dx2,main.X(:,:,:,2)+dy2,main.X(:,:,:,3)+dz2);
% 
%     res2{hier,level}=f1;
%     res1{hier,level}=res;
%     disp([j hier level res{4}]);
%     end        


%     if hier==main.hier
%     save('1last_cof.mat','cof1');
%     save('level.mat','level');
%     end
main.f=f1;
% figure(1);imagesc(result(:,:,round(size(result,3)/2)));colormap('gray');drawnow;
% figure(2);imagesc(refim(:,:,round(size(result,3)/2)));colormap('gray');drawnow;

% [res]=eval_IBSR(sizi,dimax1,i,j,main.rm,main.tf,main.rf,Xx,Xy,Xz);

% res1{hier,level}=res;
end
        
    [res]=eval_CUM(sizi,dimax1,i,j,main.rm,main.tf,main.rf,main.X(:,:,:,1)+dx2,main.X(:,:,:,2)+dy2,main.X(:,:,:,3)+dz2);

    res2{hier,level}=f1;
    res1{hier,level}=res;
    disp([j hier level res{4}]);

%     dx=dx+dx1;
%     dy=dy+dy1;
%     dz=dz+dz1;
%     
%     Xx=main.X(:,:,:,1)+dx;
%     Xy=main.X(:,:,:,2)+dy;
%     Xz=main.X(:,:,:,3)+dz;

% optim.gamma=gammma;
%     [Xx,Xy,Xz]=nim3D_nodes2grid(main.X, main.F, main.ssiz,main.cof,main.level1,main.filt,main.siz1,main.nlevss,main.LoRa);
       %     Xx=Xx-main.X(:,:,1);
%     Xy=Xy-main.X(:,:,2);
%     optim.gamma =optim.gamma/2; 
        main.MIbins=main.MIbins*2;

f{hier}=f1;
pp=1;
% X=main.X;rm=main.rm;tf=main.tf;rf=main.rf;
% clearvars -except X dx dy dz i j dimax1 sizi rm tf rf hier res1
% [res]=eval_IBSR(sizi,dimax1,i,j,main.rm,main.tf,main.rf,main.X(:,:,:,1)+dx2,main.X(:,:,:,2)+dy2,main.X(:,:,:,3)+dz2);
% 
% res1{hier}=res;
% disp(res{4})
% if M(1)==128
% end
end
% 
% dimax1=main.sizes{end}(end);
% 
% eval_IBSR(Xx,Xy,Xz,dimax1,main.rm,main.tf,main.rf)
