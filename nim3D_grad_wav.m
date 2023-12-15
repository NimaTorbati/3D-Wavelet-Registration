% MIRT2D_grad computes the value of the similarity measure and its gradient
function  [f, Gr,imsmall,dx,dy,dz,ddx,ddy,ddz]=nim3D_grad_wav(X,cof,  main,optim)

% find the dense transformation for a given position of B-spline control
% points (X).
[Xx,Xy,Xz,dx,dy,dz]=nim3D_nodes2grid(X, main.F, main.ssiz,cof,main.level1,main.filt,main.siz1,main.nlevss,main.LoRa);
clear X;
% Compute the similarity function value (f) and its gradient (dd) at Xx, Xy
[f,ddx,ddy,ddz,imsmall]=nim3D_similarity(main.imsmall, Xx,Xy,Xz,main.refimsmall,main.similarity);
if main.regg
[divx,divy,divz,fr]=nim3D_regular(dx,dy,dz,main.X,optim,main.landa,main.mio);
ddx=ddx-optim.alpha*divx;
ddy=ddy-optim.alpha*divy;
ddz=ddz-optim.alpha*divz;
else
    fr=0;
end
clear Xx Xy Xz;

% Find the gradient at each B-spline control point
[Gr]=nim3D_grid2nodes(ddx, ddy,ddz,main.ssiz,main.siz, main.F, main.level1,main.pfilt,main.nlevss,main.LoRa);
% [cof]=nim3d_cof_update_wav(main.level1,cof,Gr,main.ssiz,optim.gamma);
f=f+fr;


                        