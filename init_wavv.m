function  [Fw,msizw,filter,sizes,level2w,nlevsw]=init_wavv(hiern,dimin1,dimin2,dimin3,scale,pfilt)
            for hj=1:hiern
                dim1=dimin1*2^(hj-1);
                dim2=dimin2*2^(hj-1);
                dim3=dimin3*2^(hj-1);
                
                step=2*dim1;
                nlevs=scale;
                [Fj,siz,filt,siz1]=init_curv1(dim1,dim3,dim2,nlevs,pfilt);
                Fw{hj}=Fj;
                msizw{hj}=siz;
                filter{hj}=filt;
                sizes{hj}=siz1;
%                 
                
                if hj==1
                    level2w{hj}=1:scale;
                else
                    level2w{hj}=1:scale;
                end
                
                
                nlevsw{hj}=nlevs;
                
                scale=scale+1;
                
            end