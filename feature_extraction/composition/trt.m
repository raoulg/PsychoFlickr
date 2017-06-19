function[rt]=trt(im)
    [hsv]=rgb2hsv(im);
    [X,Y,Z]=size(hsv);
    
    for i=1:Z
        out=0; 
        out=sum(sum(hsv(floor(X/3):floor(2*X/3),floor(Y/3):floor(2*Y/3),i))); 
        rt(i)=9/(X*Y)*out;
    end

end