function [im,refim,tf,rm,rf]=im_rigid_read_cum(i,j,sizi)
im=uint16(zeros([256 124 256]+sizi));
refim=uint16(zeros([256 124 256]+sizi));
refim_name=['m' num2str(i)];
refim_seg=['mm' num2str(i)];                
im_name=['m' num2str(j)];
im_seg=['mm' num2str(j)];


[im1] = load_nii(im_name);
im1.img=permute(im1.img,[2 3 1]);
[imMask] = load_nii(im_seg);
imMask.img=permute(imMask.img,[2 3 1]);
% imMask.img=flipdim(imMask.img,3);
im(sizi(1)/2+1:end-sizi(1)/2,sizi(2)/2+1:end-sizi(2)/2,sizi(3)/2+1:end-sizi(3)/2)=(im1.img).*(imMask.img);
[im1] = load_nii(refim_name);
im1.img=permute(im1.img,[2 3 1]);
[imMask] = load_nii(refim_seg);
imMask.img=permute(imMask.img,[2 3 1]);

% imMask.img=flipdim(imMask.img,1);
refim(sizi(1)/2+1:end-sizi(1)/2,sizi(2)/2+1:end-sizi(2)/2,sizi(3)/2+1:end-sizi(3)/2)=(im1.img).*(imMask.img);
clear imMask im1;


[opt,mte]=imregconfig('monomodal');
opt.MaximumIterations=50;
GradientMagnitudeTolerance=0.1;
opt.MinimumStepLength= 0.05;
opt.MaximumStepLength= 0.08;

opt.RelaxationFactor=0.05;
for ggg=1
[tf,rm,rf]=imregister1(im,refim,'affine',opt,mte);
% tf.T=eye(4);
 [im] = imwarp((im),rm,tf,'OutputView',rf);

end

im=double(im);
im=im/max(max(max(im)));
refim=double(refim);
refim=refim/max(max(max(refim)));
end
