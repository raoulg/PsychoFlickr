
function visitato = visita(i,j,visitato,img,n)
 if n>992
     return
 else
     n=n+1;
 end
 
    visitato(i,j)=1;
    if i~=1 && j~=1 && visitato(i-1,j-1) == 0 && img(i-1,j-1) == 1 
        visitato=visita(i-1,j-1,visitato,img,n);
    end
    if i~=1 && visitato(i-1,j) == 0 && img(i-1,j) == 1
        visitato=visita(i-1,j,visitato,img,n);
    end
    if j~=1 && visitato(i,j-1) == 0 && img(i,j-1) == 1
        visitato=visita(i,j-1,visitato,img,n);
    end
    if i~=size(img,1) && j ~=size(img,2) && visitato(i+1,j+1) == 0 && img(i+1,j+1) == 1
        visitato=visita(i+1,j+1,visitato,img,n);
    end
    if j ~=size(img,2) && visitato(i,j+1) == 0 && img(i,j+1) == 1
        visitato=visita(i,j+1,visitato,img,n);
    end
    if i~=size(img,1) && j ~=1 && visitato(i+1,j-1) == 0 && img(i+1,j-1) == 1
        visitato=visita(i+1,j-1,visitato,img,n);
    end
    if i~=size(img,1) && visitato(i+1,j) == 0 && img(i+1,j) == 1
        visitato=visita(i+1,j,visitato,img,n);
    end
    if i~=1 && j ~=size(img,2) && visitato(i-1,j+1) == 0 && img(i-1,j+1) == 1
        visitato=visita(i-1,j+1,visitato,img,n);
    end
    
end