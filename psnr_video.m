function frame = psnr_video(PSNR)
Nframes = length(PSNR);


for i = 1:Nframes
    figure('Position', [0 0 512 150]);
    plot(PSNR, 'Color', 'black','LineWidth',2)
    text(Nframes/2,max(PSNR), sprintf('PSNR = %3.2f dB',PSNR(i)),...
        'Color', 'red','FontSize',36, 'HorizontalAlignment','center');
    hold on
    plot([i i], [min(PSNR) max(PSNR)],...
        'Color','red',...
        'LineWidth',2);
    
    print(sprintf('./tmp/psnr_%03d.png',i),'-dpng');

    close();
    
    frame(:,:,:,i) =imresize(...
        imread(sprintf('./tmp/psnr_%03d.png',i)) ,...
        [384 512]);
    
    
end

end
