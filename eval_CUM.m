function [res]=eval_CUM(sizi,dimax1,i,j,rm,tf,rf,Xx,Xy,Xz)
Labels = [0;    %      Left  Cerebral Exterior    (0) Left Cerebral Exterior          
0;    %      Right Cerebral Exterior         (0) Right Cerebral Exterior         
3;    %      Left  Cerebellum Exterior       Left Cerebellum Exterior                
4;    %      Right Cerebellum Exterior       Right Cerebellum Exterior               
5;    %      Left  Cerebral White Matter     Left Cerebral White Matter              
6;    %      Right Cerebral White Matter     Right Cerebral White Matter             
7;    %      Left  Cerebellum White Matter   Left Cerebellum White Matter            
8;    %      Right Cerebellum White Matter   Right Cerebellum White Matter           
9;    %      Left  Lateral Ventricle         Left Lateral Ventricle          
10;    %      Right Lateral Ventricle         Right Lateral Ventricle         
11;    %      4th Ventricle                   4th Ventricle           
12;    %      Brain Stem                      Brain Stem              
13;    %      Left  Inf Lat Vent              Left Inf Lat Vent               
14;    %      Right Inf Lat Vent              Right Inf Lat Vent              
15;    %      Left  Hippocampus               Left Hippocampus
16;    %      Right Hippocampus               Right Hippocampus
17;    %      Left  Thalamus Proper           Left Thalamus Proper
18;    %      Right Thalamus Proper           Right Thalamus Proper
19;    %      Left  VentralDC                 Left VentralDC
20;    %      Right VentralDC                 Right VentralDC
21;    %      3rd Ventricle                   3rd Ventricle
22;    %      CSF                             CSF
23;    %      Left Caudate                    Left Caudate
24;    %      Right Caudate                   Right Caudate
25;    %      Left Putamen                    Left Putamen
26;    %      Right Putamen                   Right Putamen
27;    %      Left Pallidum                   Left Pallidum
28;    %      Right Pallidum                  Right Pallidum
29;    %      Left Amygdala                   Left Amygdala
30;    %      Right Amygdala                  Right Amygdala
31;    %      Left vessel                     Left vessel     
32;    %      Right vessel                    Right vessel    
33;    %      Left Accumbens area             Left Accumbens area     
34;    %      Right Accumbens area            Right Accumbens area    
35;    %      Left OP                         L Occipital Pole        o
36;    %      Right OP                        R Occipital Pole        o
37;    %      Left CN                         L Cuneal Cortex o
38;    %      Right CN                        R Cuneal Cortex o
39;    %      Left OLs                        "L Lateral Occipital Cortex, superior"  o
40;    %      Right OLs                       "R Lateral Occipital Cortex, superior"  o
41;    %      Left SCLC                       L Supracalcarine Cortex p @rno
42;    %      Right SCLC                      R Supracalcarine Cortex p @rno
43;    %      Left CALC                       L Intracalcarine Cortex p @rno
44;    %      Right CALC                      R Intracalcarine Cortex p @rno
45;    %      Left OLi                        "L Lateral Occipital Cortex, inferior"  o
46;    %      Right OLi                       "R Lateral Occipital Cortex, inferior"  o
47;    %      Left OF                         L Occipital Fusiform Gyrus      o
48;    %      Right OF                        R Occipital Fusiform Gyrus      o
49;    %      Left LG                         L Lingual Gyrus o           (*extends into OL)
50;    %      Right LG                        R Lingual Gyrus o           (*extends into OL)
51;    %      Left PCN                        L Precuneous Cortex  p @rno (*extends into OL)
52;    %      Right PCN                       R Precuneous Cortex  p @rno (*extends into OL)
53;    %      Left AG                         L Angular Gyrus p
54;    %      Right AG                        R Angular Gyrus p
55;    %      Left SPL                        L Superior Parietal Lobule      p
56;    %      Right SPL                       R Superior Parietal Lobule      p
57;    %      Left TO2                        "L Middle Temporal Gyrus, temporooccipital part"        t
58;    %      Right TO2                       "R Middle Temporal Gyrus, temporooccipital part"        t
59;    %      Left TOF                        L Temporal Occipital Fusiform Cortex    t
60;    %      Right TOF                       R Temporal Occipital Fusiform Cortex    t
61;    %      Left TO3                        "L Inferior Temporal Gyrus, temporooccipital part"      t
62;    %      Right TO3                       "R Inferior Temporal Gyrus, temporooccipital part"      t
63;    %      Left POG                        L Postcentral Gyrus     p       
64;    %      Right POG                       R Postcentral Gyrus     p       
65;    %      Left SGp                        "L Supramarginal Gyrus, posterior"      p       
66;    %      Right SGp                       "R Supramarginal Gyrus, posterior"      p       
67;    %      Left CGp                        "L Cingulate Gyrus, posterior"  p       MedialParalimbic
68;    %      Right CGp                       "R Cingulate Gyrus, posterior"  p       MedialParalimbic
69;    %      Left PRG                        L Precentral Gyrus      f       
70;    %      Right PRG                       R Precental Gyrus       f       
71;    %      Left SGa                        "L Supramarginal Gyrus, anterior"       p       
72;    %      Right SGa                       "R Supramarginal Gyrus, anterior"       p       
73;    %      Left PO                         L Parietal Operculum Cortex     p       Intrasylvian
74;    %      Right PO                        R Parietal Operculum Cortex     p       Intrasylvian
75;    %      Left PT                         L Planum Temporale t       Intrasylvian @rno
76;    %      Right PT                        R Planum Temporale      t       Intrasylvian @rno
77;    %      Left T1p                        "L Superior Temporal Gyrus, posterior"  t       
78;    %      Right T1p                       "R Superior Temporal Gyrus, posterior"  t       
79;    %      Left T2p                        "L Middle Temporal Gyrus, posterior"    t       
80;    %      Right T2p                       "R Middle Temporal Gyrus, posterior"    t       
81;    %      Left PHp                        "L Parahippocampal Gyrus, posterior"    t       MedialParalimbic
82;    %      Right PHp                       "R Parahippocampal Gyrus, posterior"    t       MedialParalimbic
83;    %      Left TFp                        "L Temporal Frontal Cortex, posterior"  t       
84;    %      Right TFp                       "R Temporal Frontal Cortex, posterior"  t       
85;    %      Left T3p                        "L Inferior Temporal Gyrus, posterior"  t       
86;    %      Right T3p                       "R Inferior Temporal Gyrus, posterior"  t       
87;    %      Left INS                        L Insular Cortex        t       Intrasylvian
88;    %      Right INS                       R Insular Cortex        t       Intrasylvian
89;    %      Left  H1                        L Heschl's Gyrus        t       Intrasylvian
90;    %      Right H1                        R Heschl's Gyrus        t       Intrasylvian
91;    %      Left  PP                        L Planum Polare t       Intrasylvian
92;    %      Right PP                        R Planum Polare t       Intrasylvian
93;    %      Left  CO                        L Central Opercular Cortex      f       Intrasylvian
94;    %      Right CO                        R Central Opercular Cortex      f       Intrasylvian
95;    %      Left  PHa                       "L Parahippocampal Gyrus, anterior"     t       MedialParalimbic
96;    %      Right PHa                       "R Parahippocampal Gyrus, anterior"     t       MedialParalimbic
97;    %      Left  F1                        L Superior Frontal Gyrus        f       "PFC,DLPFC"
98;    %      Right F1                        R Superior Frontal Gyrus        f       "PFC,DLPFC"
99;    %      Left  SMC                       L Supplementary Motor Cortex    f       
100;    %      Right SMC                       R Supplementary Motor Cortex    f       
101;    %      Left  CGa                       "L Cingulate Gyrus, anterior"   f       MedialParalimbic
102;    %      Right CGa                       "R Cingulate Gyrus, anterior"   f       MedialParalimbic
103;    %      Left  T1a                       "L Superior Temporal Gyrus, anterior"   t       
104;    %      Right T1a                       "R Superior Temporal Gyrus, anterior"   t       
105;    %      Left  T2a                       "L Middle Temporal Gyrus, anterior"     t       
106;    %      Right T2a                       "R Middle Temporal Gyrus, anterior"     t       
107;    %      Left  TFa                        "L Temporal Frontal Cortex, anterior"   t       
108;    %      Right TFa                       "R Temporal Frontal Cortex, anterior"   t       
109;    %      Left  T3a                       "L Inferior Temporal Gyrus, anterior"   t       
110;    %      Right T3a                       "R Interior Temporal Gyrus, anterior"   t       
111;    %      Left  F2                        L Middle Frontal Gyrus  f       "PFC,DLPFC"
112;    %      Right F2                        R Middle Frontal Gyrus  f       "PFC,DLPFC"
113;    %      Left  BFsbcmp                    L Basal Forebrain       t       
114;    %      Right BFsbcmp                   R Basal Forebrain       t       
115;    %      Left  PAC                        L Paracingulate Gyrus   f       MedialParalimbic
116;    %      Right PAC                       R Paracingulate Gyrus   f       MedialParalimbic
117;    %      Left  F3o                        "L Inferior Frontal Gyrus, pars opercularis"    f       
118;    %      Right F3o                       "R Interior Frontal Gyrus, pars opercularis"    f       
119;    %      Left  FO                         L Frontal Operculum Cortex      f       Intrasylvian
120;    %      Right FO                        R Frontal Operculum Cortex      f       Intrasylvian
121;    %      Left  TP                         L Temporal Pole t       
122;    %      Right TP                        R Temporal Pole t       
123;    %      Left  SC                         L Subcallosal Cortex    f       MedialParalimbic
124;    %      Right SC                        R Subcallosal Cortex    f       MedialParalimbic
125;    %      Left  FOC                        L Frontal Orbital Cortex        f       PFC
126;    %      Right FOC                       R Frontal Orbital Cortex        f       PFC
127;    %      Left  F3t                        "L Inferior Frontal Gyrus, pars triangularis"   f       PFC
128;    %      Right F3t                       "R Inferior Frontal Gyrus, pars triangularis"   f       PFC
129;    %      Left  FMC                        L Frontal Medial Cortex f       PFC
130;    %      Right FMC                       R Frontal Medial Cortex f       PFC
131;    %      Left  FP                         L Frontal Pole  f       PFC
132];    %      Right FP                        R Frontal Pole  f       PFC
% clear all;close all;
% dimax1=256;
% dimin1=256;
% sizi=main.sizi;



% hiern=log2(dimax1)-log2(dimin1);
% dimax1=size(Xx,1);
% dimax2=size(Xx,2);
% dimax3=size(Xx,3);
dimax2=dimax1;dimax3=size(Xx,2);

%   dimax1=158;dimax2=158;dimax3=118;
            
            
refim_name=['ml' num2str(i)];
im_name=['ml' num2str(j)];

[TRUE] = load_nii(refim_name);

[im_lab] = load_nii(im_name);
[xe, ye ,ze]=meshgrid(1:124+sizi(2), 1:256+sizi(1) ,1:256+sizi(3));
[xe1, ye1 ,ze1]=meshgrid(1:dimax3, 1:dimax2 ,1:dimax1);

% im_lab.img=flipdim(im_lab.img,1);
im_lab.img=permute(im_lab.img,[2 3 1]);
imme1=int16(zeros([256 124 256]+sizi));
imme1(sizi(1)/2+1:end-sizi(1)/2,sizi(2)/2+1:end-sizi(2)/2,sizi(3)/2+1:end-sizi(3)/2)=im_lab.img;
clear im_lab
% imm=nim3D_imresize((im_lab.img),[dimax1 dimax3 dimax2],'nearest');
% im_name=['c' num2str(2)];
% 
% [im_lab1] = load_nii(im_name);
% imm=permute(im_lab.img,[1 3 2]);
% imm=zeros(size(im_lab.img));
% imm=im_lab.img;

% imm(im_lab.img==99)=im_lab.img(im_lab.img==99);

[imme] = imwarp((imme1),rm,tf,'OutputView',rf,'InterpolationMethod','nearest');



% imm=nim3D_imresize((imm),[dimax1 dimax3 dimax2],'nearest');





    
% imm=nim3D_imresize((imm),[256 128 256],'nearest');

   %    imm(imm>=99/2)=99;
%    imm(imm<99/2)=0;
   %     imm=imm(49:end-50,49:end-50,1:end-10);
% dxaf=
% dyaf=
% dzaf=
dxe1=((256+sizi(1))/dimax1)*nim3D_imresize((Xx-xe1),[256 124 256]+sizi,'cubic');
dye1=((256+sizi(1))/dimax1)*nim3D_imresize((Xy-ye1),[256 124 256]+sizi,'cubic');
dze1=((256+sizi(1))/dimax1)*nim3D_imresize((Xz-ze1),[256 124 256]+sizi,'cubic');
clear Xx Xy Xz xe1 ye1 ze1   
   imme=interp3(xe,ye,ze,(imme),xe+dxe1,ye+dye1,ze+dze1,'nearest');
%    clear dxe1 dye1 dze1 xe ye ze
   
%    imm(imm>=99/2)=99;
%    imm(imm<99/2)=0;



% TEST=im_lab.img;
%     TEST=interp3(x,y,z,im_lab.img,defField.Xx,defField.Xy,defField.Xz,'nearest');
% imm=permute(im_lab.img,[1 3 2]);
% 
%    [imm] = imwarp(imm,defField.rm,defField.tf,'OutputView',defField.rf,'InterpolationMethod','nearest');
%     imm=imm(49:end-50,49:end-50,1:end-10);
% 
% 
% 
%         imm=interp3(x,y,z,imm,defField.Xx,defField.Xy,defField.Xz,'nearest');

% refimm=permute(TRUE.img,[1 3 2]);
% TRUE.img=flipdim(TRUE.img,1);
refimme=int16(zeros([256 124 256]+sizi));
TRUE.img=permute(TRUE.img,[2 3 1]);
refimme(sizi(1)/2+1:end-sizi(1)/2,sizi(2)/2+1:end-sizi(2)/2,sizi(3)/2+1:end-sizi(3)/2)=TRUE.img;

% refimm=permute(TRUE.img,[1 3 2]);
% refimm=nim3D_imresize(TRUE.img,[dimax1 dimax3 dimax2],'nearest');

clear TRUE
% refimm=refimm(49:end-50,49:end-50,1:end-10);

    
    
    
[label_nTEST_nTRUE_nAND_nOR,...
          label_ANDoverTRUE_ANDoverOR_ANDovermean_FP_FN,...
          nTEST_nTRUE_nAND_nOR,...
          ANDoverTRUE_ANDoverOR_ANDovermean_FP_FN,...
          totalAND, totalOR, ndiff1,ITEST1,ITRUE1] = evaluate_warps( int16(imme), refimme, Labels, 1);
      
            clear imme refimme xe1 ye1 ze1 xe ye ze
      %%
[gradx1, grady1, gradz1]=gradient(dxe1,3);
[gradx2, grady2, gradz2]=gradient(dye1,3);
[gradx3, grady3, gradz3]=gradient(dze1,3);
Dj=(1+gradx1).*(1+grady2).*(1+gradz3)+(grady1).*(gradz2).*(gradx3)+ ...
    (gradz1).*(gradx2).*(grady3)- ... 
    ((1+gradx1).*(gradz2).*(grady3)-(1+grady2).*(gradz1).*(gradx3)+(1+gradz3).*(grady1).*(gradx2));
 r1=std(Dj(:));
%%
      res{1}=label_nTEST_nTRUE_nAND_nOR;
      res{2}=label_ANDoverTRUE_ANDoverOR_ANDovermean_FP_FN;
      res{3}=nTEST_nTRUE_nAND_nOR;
      res{4}=ANDoverTRUE_ANDoverOR_ANDovermean_FP_FN;
      res{5}=r1;
%       res{1}=label_nTEST_nTRUE_nAND_nOR;
%       res{2}=label_ANDoverTRUE_ANDoverOR_ANDovermean_FP_FN;
%       res{3}=nTEST_nTRUE_nAND_nOR;
%       res{4}=ANDoverTRUE_ANDoverOR_ANDovermean_FP_FN;