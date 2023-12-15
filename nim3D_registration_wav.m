function [im,cof,f2,dx,dy,dz,gamma]=nim3D_registration_wav(main, optim)

%% normalize the initial optimization step size
% compute the gradient of the similarity measure
X=main.X;

% [Xx,Xy,Xz]=nim3D_nodes2grid(main.X, main.F, main.ssiz,main.cof,main.level1,main.filt,main.siz1,main.nlevss,main.LoRa);
% % converting cofs to u and v
% [f, ddx, ddy ,ddz]=nim3D_similarity(main, Xx, Xy,Xz);
% clear Xx Xy Xz;
% % divide the initial optimization step size by the std of the gradient
% % this somewhat normalizes the initial step size for different possible
% % similarity measures used

[~, ~,~,~,~,~,ddx,ddy,ddz]=nim3D_grad_wav(X,main.cof,  main,optim);

% if optim.level==1
optim.gamma=(optim.gamma/std([ddx(:); ddy(:); ddz(:)],0));
% optim.gamma=1;
% end
clear ddx ddy ddz;

%% Start the main registration
% compute the objective function and its gradient
cof=main.cof;
[f, Gr,~,dx,dy,dz]=nim3D_grad_wav(X,cof,  main,optim);
%  [cofp]=nim3d_cof_update_wav(main.level1,cof,Gr,main.ssiz,optim.gamma);
 cof=main.cof;   im=main.imsmall; 
f2=f;
 
 
 
 % [fe, T, im]=nim3D_grad(X,cof,main);
% 
% [cofp, fr]=nim3D_regsolve(main.cof,T,main, optim, main.ssiz);   % compute the regularization term and update the transformation
% f=fe+fr                                      % compute the value of the total objective function (similarity + regularization)
fchange=optim.fundif+1; % some big number
iter=0;
% k=1;
% on=0;
% if main.level==1
% mxk=4;
% else
% %f=main.f;
% mxk=20;
% end
% do while the relative function difference is below the threshold and
% the meximum number of iterations has not been reached
Grp=Gr;
        gamma=optim.gamma;
while (abs(fchange)>optim.fundif) && (iter<optim.maxsteps) && optim.gamma>0.01
    % find the new positions of B-spline control points,
    % given their currect positions (X) and gradient in (T)
    [cofp]=nim3d_cof_update_wav(main.level1,cof,Grp,main.ssiz,optim.gamma);

    [fp, Gr,imb,dx,dy,dz,~,~,~]=nim3D_grad_wav(X,cofp,  main,optim);
% 
%     [cofp, fr]=nim3D_regsolve(cof,T,main, optim,main.ssiz);    % compute the regularization term and update the transformation
%     
%     % compute new function value and new gradient
%     [fe, Tp, imb,dx,dy,dz]=nim3D_grad(X,cofp,  main);        % compute the similarity measure and its gradient
%     fp=fe+fr;
    
    % compute the relative objective function change
    fchange=(fp-f)/f;
    % check if the step size is appropriate
    if ((fp-f)>-0.1)
%         k=k+1;
        % if the new objective function value does not decrease,
        % then reduce the optimization step size and
        % slightly increase the value of the objective function
        % (this is an optimization heuristic to avoid some local minima)
%         if k==mxk && on==1
%             [fd, ddx, ddy]=nim2D_similarity(main, Xx, Xy);
%             optim.gamma=optim.gamma/std([ddx(:); ddy(:)],0)/10;
%             on=0;
%             k=1;
%         else
            optim.gamma=optim.anneal*optim.gamma;
%             f=f+0.00001*abs(f);

        %end
    else

%         on=1;
%         k=1;
        % divide the initial optimization step size by the std of the gradient
        % this somewhat normalizes the initial step size for different possible
        % similarity measures used
        % if the new objective function value decreased
        % then accept all the variable as true and show the progress
%         main.F1{1}=Fxp;main.F1{2}=Fyp;main.F1{3}=Fzp;
        cof=cofp; f=fp;  im=imb; Grp=Gr;
        main.lambda=0.8*main.lambda;
%            disp([upper(main.similarity) '=' num2str(f) ' iter ' num2str(iter) ' lambda = ' num2str(optim.gamma)]); 
        
        
        
        if main.single
            figure(1);imagesc(squeeze(im(round(size(im,3)/2),:,:)));%drawnow;%colormap('gray');
            figure(2);imagesc(squeeze(main.refimsmall(round(size(im,3)/2),:,:)));drawnow;%colormap('gray');
%             pause
%             bm=isnan(im);
%             im(bm)=0;
%             imwrite(im,'im2.png','png');
            %subplot(2,2,4,'align'),imshow(im);hold on; quiver(Y1(:,:,1),Y1(:,:,2),upp,vpp,0.5,'y');drawnow;
        end
        % show progress
        gamma=optim.gamma;
    end
    iter=iter+1;
     disp([upper(main.similarity) '=' num2str(f) ' iter ' num2str(iter) ' lambda = ' num2str(optim.gamma)]); 
    
end
%         cof=cofp; f=fp;  im=imb; 

%  disp([upper(main.similarity) '=' num2str(f) ' iter ' num2str(iter) ' lambda = ' num2str(optim.gamma)]); 
end