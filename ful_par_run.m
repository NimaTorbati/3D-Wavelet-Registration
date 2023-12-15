%%%%%%%%%%%%55

clear all;close all;fclose('all');
addpath(genpath('D:\reg_Curv\curve_3d'));
% dimax1=156;dimax2=156;dimax3=120;

% matlabpool('close');
% a=parcluster;
% a.NumWorkers=6;
% matlabpool(a,'open');

scll=4;
sizi=40;%24;

main.nam{1}={'m'};main.nam{2}={'mm'};%CUM 'mm' ISBR 'cm'
main.imsiz=[256 256 124];% CUM %% [256 256 128]; ISBR

dimax1=(main.imsiz(1)+sizi)/scll;
dimax2=(main.imsiz(2)+sizi)/scll;
dimax3=(main.imsiz(3)+sizi)/scll;

hiern=0;%log2(dimax1)-log2(dimin1);

% dimax2=dimax1;dimax3=dimax1/2;

dimin1=dimax1/2^(hiern);dimin2=dimax2/2^(hiern);dimin3=dimax3/2^(hiern);


iters=[0.01 0.25 0.5 0.75 1];
num=cell(1,4);
fun=cell(1,4);
fun{1}='db2';fun{2}='sym4';fun{3}='coif2';fun{4}='bior2.2';
fun1{1}='ssd';fun1{2}='cc';fun1{3}='sad';
fun2{1}='diff';fun2{2}='curv';fun2{3}='elas';

% num{1,1}='IBSR_12_ana.img';num{1,2}='IBSR_13_ana.img';num{1,3}='IBSR_14_ana.img';num{1,4}='IBSR_07_ana.img';
% segnum{1}='IBSR_12_seg_ana.img';segnum{2}='IBSR_13_seg_ana.img';segnum{3}='IBSR_14_seg_ana.img';segnum{4}='IBSR_07_seg_ana.img';
jt=1:12;

iter_num=1;
% im=uint16(zeros([256 128 256]+sizi));
% refim=uint16(zeros([256 128 256]+sizi));


ofilt={'db2','db2','db2','db8','db2'};
oreg={'diff','elas','curv','diff','diff'};
osim={'ssd','sad','cc','ssd','cc'};
oalpha=[0.06 0.08 0.1 0.15 0.2];
% ress=cell(1,5);resalp=cell(1,5);
re2=cell(1,11);
re1=cell(1,11);
        kk1=jt(jt~=7);

for bas_fun=11
    for i=3
        i
        kk=jt(jt~=i);
        for j=[7]
            
            j
            scale=3;%log2((dimax1*scll-sizi)/(scll*2^hiern));
            % % % % ISBR data
            
            
            
%                 refim_name=['c' num2str(i)];
%                 refim_seg=['cm' num2str(i)];                
%                 im_name=['c' num2str(j)];
%                 im_seg=['cm' num2str(j)];
%             
%             
%             [im1] = load_nii(im_name);
%             [imMask] = load_nii(im_seg);
%             imMask.img=flipdim(imMask.img,1);
%             im(sizi/2+1:end-sizi/2,sizi/2+1:end-sizi/2,sizi/2+1:end-sizi/2)=(im1.img).*(imMask.img);
%             [im1] = load_nii(refim_name);
%             [imMask] = load_nii(refim_seg);
%             imMask.img=flipdim(imMask.img,1);
%             refim(sizi/2+1:end-sizi/2,sizi/2+1:end-sizi/2,sizi/2+1:end-sizi/2)=(im1.img).*(imMask.img);
%             clear imMask im1;
%                 [opt,mte]=imregconfig('monomodal');
%                 opt.MaximumIterations=5;
%  GradientMagnitudeTolerance=0.1;
%   opt.MinimumStepLength= 0.05;
%              opt.MaximumStepLength= 0.08;
% 
%               opt.RelaxationFactor=0.1;
%             for ggg=1
%                 [im,ytr,tf,rm,rf]=imregister(im,refim,'affine',opt,mte);
%             end
%             
%             im=im(47:end-50,1:end-8,47:end-50);
%             refim=refim(47:end-50,1:end-8,47:end-50);            
            
            % Main settings
            %% 
            main.scale=scale;
            main.scll=scll;
            main.pfilt='db2';
            main.landa=0.5;
            main.hier=hiern+1;
            
            main.mio=0.5;
            main.step=4;
            main.alpha=1;
            main.subdivide=4;       % use 3 hierarchical levels
            main.nscale=4;
            main.ro=0.1;
            main.lambda = 0.0;    % regularization weight, 0 for none
            main.single=0;          % show mesh transformation at every iteration
            main.mode=1;
            main.f=1e6;
            main.MIbins=16;
            main.steps=[100 100 100 100 100 100 100 100 50 100 100 100]*iters(i);
            main.dwx=0;
            main.dwy=0;
            main.LoRa=[0 0 0];
            main.regg=1;
            main.dfilt = main.pfilt;
            
            % Optimization settings
            optim.maxsteps = 100;   % maximum number of iterations at each hierarchical level
            optim.fundif = 1e-10;    % tolerance (stopping criterion)
            optim.a=1;
            optim.gamma = 0.25;       % initial optimization step size
            optim.anneal=0.5;       % annealing rate on the optimization step
            optim.lambda = 0;   % regularization neighboring weigth

%             optim.alpha=0.09;
            
          
%              main.level2w{hj}=([1:5]);
            
            
%             im=double(im);
%             im=im/max(max(max(im)));
%             refim=double(refim);
%             refim=refim/max(max(max(refim)));
% 
%             [opt,mte]=imregconfig('monomodal');
%                 opt.MaximumIterations=5;
%                 GradientMagnitudeTolerance=0.1;
%                 opt.MinimumStepLength= 0.05;
%                 opt.MaximumStepLength= 0.08;
% 
%                 opt.RelaxationFactor=0.1;
%                 for ggg=1
%                 [im,ytr,tf,rm,rf]=imregister(im,refim,'affine',opt,mte);
%                 end
                

%               if size(im,1)~=dimax1
%              im=nim3D_imresize(im, [dimax1 dimax3 dimax2],'cubic');
%               end
%             
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               if size(refim,1)~=dimax1
%               refim=nim3D_imresize(refim, [dimax1 dimax3 dimax2],'cubic');
%               end
%                 main.refim=refim;
%                 main.im=im;
% %                 [opt,mte]=imregconfig('monomodal');
% %                 opt.MaximumIterations=5;
% %                 GradientMagnitudeTolerance=0.1;
% %                 opt.MinimumStepLength= 0.05;
% %                 opt.MaximumStepLength= 0.08;
% % 
% %                 opt.RelaxationFactor=0.1;
% %                 for ggg=1
% %                 [im,ytr,tf,rm,rf]=imregister(im,refim,'affine',opt,mte);
% %                 end
% %                 
%             main.rm=rm;main.tf=tf;main.rf=rf;
            % %%%%%%%%%warper version
                       main.sizi=sizi;
ofilt={'db2','db4','db6','db8','db10'};
oreg={'diff','elas','curv'};
osim={'ssd','sad','cc'};
oalpha=[0.06 0.08 0.1 0.15 0.2];
oreg1=oreg{2};                       
osim1=osim{3};
ofilt1='db6';%ofilt{1};
oalpha1=0.1;
kkj=kk;%kkj{1}=kk(5:8);kkj{1}=kk(9:11);kkj{1}=kk(12:14);kkj{1}=kk(15:17);
            disp(1);
            disp(2);
            osim={'ssd','sad','cc','cc','cc'};
            oreg={'elas','elas','elas','diff','curv'};
            tic
            for kjh=1:5
%                     [res,res1]=nim3D_register_wav(main, optim,i,j,ofilt1,oreg{kjh},osim{kjh},oalpha1);
                    [res,res1]=nim3D_register_wav_cum(main, optim,kk1(kjh),j,ofilt1,oreg1,osim1,oalpha1);
%                     [res,res1]=nim3D_register_wav_cum(main, optim,i,kk(kjh),ofilt1,oreg1,osim1,oalpha1);
                    re1{kjh}=res;
                    re2{kjh}=res1;
            end
            re2{12}=toc;
            parfor kjh=6:11
%                     [res,res1]=nim3D_register_wav(main, optim,i,j,ofilt1,oreg{kjh},osim{kjh},oalpha1);
                    [res,res1]=nim3D_register_wav(main, optim,kk1(kjh),j,ofilt1,oreg1,osim1,oalpha1);
%                     [res,res1]=nim3D_register_wav_cum(main, optim,i,kk(kjh),ofilt1,oreg1,osim1,oalpha1);
                    re1{kjh}=res;
                    re2{kjh}=res1;
            end
%             toc;

            
%             parfor kjh=10:17
% %                         [res,res1]=nim3D_register_wav(main, optim,i,j,ofilt{kjh},oreg1,osim1,oalpha1);
%                         [res,res1]=nim3D_register_wav(main, optim,i,kk(kjh),ofilt1,oreg1,osim1,oalpha1);
% %                     [res,res1]=nim3D_register_wav_cum(main, optim,i,kk(kjh),ofilt1,oreg1,osim1,oalpha1);
%                     
%                     re1{kjh}=res;
%                     re2{kjh}=res1;
%             end
%             parfor kjh=11:15
%                     [res,res1]=nim3D_register_wav(main, optim,i,kk(kjh),ofilt1,oreg1,osim1,oalpha1);
% %                     [res,res1]=nim3D_register_wav_cum(main, optim,i,2,ofilt{kjh},oreg1,osim1,oalpha1);
%                     re1{kjh}=res;
%                     re2{kjh}=res1;
%             end
% 
            %             disp(3);
%             parfor kjh=16:17
%                     [res,res1]=nim3D_register_wav(main, optim,i,kk(kjh),ofilt1,oreg1,osim1,oalpha1);
% %                     [res,res1]=nim3D_register_wav_cum(main, optim,i,2,ofilt1,oreg{kjh},osim1,oalpha1);
% 
%                     re5{kjh}=res;
%                     re6{kjh}=res1;
%             end
%             disp(4);           
%             parfor kjh=10:11
% %                     [res,res1]=nim3D_register_wav(main, optim,i,kkj(kjh),ofilt1,oreg1,osim1,oalpha1);
%                     [res,res1]=nim3D_register_wav_cum(main, optim,i,kkj(kjh),ofilt1,oreg1,osim1,oalpha1);
%                     
%                     re1{kjh}=res;
%                     re2{kjh}=res1;
%             end
%             disp(6);           
%             parfor kjh=13:15
%                     [res,res1]=nim3D_register_wav(main, optim,i,kkj(kjh),ofilt1,oreg1,osim1,oalpha1);
%                     re1{kjh}=res;
%                     re2{kjh}=res1;
%             end
%             disp(7);           
%             parfor kjh=16:17
%                     [res,res1]=nim3D_register_wav(main, optim,i,kkj(kjh),ofilt1,oreg1,osim1,oalpha1);
%                     re1{kjh}=res;
%                     re2{kjh}=res1;
%             end
% 
                       

            
        end
        fclose('all');
        ress1{i}=re1;
        ress2{i}=re2;
        save('ress1','ress1');save('ress2','ress2');
    end
end
save('ress1','ress1');save('ress2','ress2');
% save('re3','re3');save('re4','re4');
% save('re5','re6');save('re6','re6');