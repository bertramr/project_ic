%% Input Data
opts.imDistance = 0.5;
opts.MRFalg = 1;
i = 0;
for lambda = 0:50:150
    for nD = 128:32:256
        for smoothmax = 2
            %%
            i = i + 1;
            
            opts.smoothmax = smoothmax;
            opts.lambda = lambda;
            
            opts.nD = nD;
            opts.scale = 256/opts.nD;
            
            %%
            input.Folder = ('../video/frame/');
            input.Lfile = ('cam10_050.png');
            input.Rfile = ('cam06_050.png');
            
            output(i).Folder = ('./output/');
            output(i).Lfile = sprintf('disp/t2_dispL_050_%d_%d_%d.png',lambda,nD,smoothmax);
            output(i).Rfile = sprintf('disp/t2_dispR_050_%d_%d_%d.png',lambda,nD,smoothmax);
            output(i).syntLfile = sprintf('synt/t2_syntL_050_%d_%d_%d.png',lambda,nD,smoothmax);
            output(i).syntRfile = sprintf('synt/t2_syntR_050_%d_%d_%d.png',lambda,nD,smoothmax);
            output(i).File = sprintf('t2_synt_%03d.png',i);
            
                        
            tmp.Folder = './tmp/';
            tmp.dispRflipFile = ('dispRflip_050.png');
            tmp.LflipFile = ('Lflip_050.png');
            tmp.RflipFile = ('Rflip_050.png');
            
            synthesis(input,output(i),tmp,opts)
        end
    end
end
