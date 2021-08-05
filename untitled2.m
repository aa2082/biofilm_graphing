 I=im2double(imread('img1.png'));
 I2 = I(301:600,301:600,1:3);
 %b
 %F=fftshift(fft2(I));    % surface(abs(F))
 F = fft2(I);
 F2 = fft2(I2);
 %c
 %plot(abs(F))     %  plot not surf
 %e
 subplot(2,2,1);
 imshow(I);
 title('full image');
 subplot(2,2,2);
 imshow(I2)
 title('centre of image');
 subplot(2,2,3);
 imshow(F)
 title('full image fft2');
 subplot(2,2,4);
 imshow(F2)
 title('centre image fft2');
 %figure, imshow(F)