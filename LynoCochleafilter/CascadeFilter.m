function F = CascadeFilter(Fb, Fa)

    assert(size(Fb.B, 1)==1,["size(Fb.B, 1) should==1, but size(Fb.B, 1)==", num2str(size(Fb.B,1))]);
    assert(size(Fb.A, 1)==1,["size(Fb.A, 1) should==1, but size(Fb.A, 1)==", num2str(size(Fb.A,1))]);
    assert(size(Fa.B, 1)==1,["size(Fa.B, 1) should==1, but size(Fa.B, 1)==", num2str(size(Fa.B,1))]);
    assert(size(Fa.A, 1)==1,["size(Fa.A, 1) should==1, but size(Fa.A, 1)==", num2str(size(Fa.A,1))]);


    % lb = (length(Fb.B)-1) * (length(Fa.B)-1);
    % la = (length(Fb.A)-1) * (length(Fa.A)-1);
    % if (lb==0) 
    %     lb = max(length(Fb.B), length(Fa.B));
    % else 
    %     lb = lb + 1;
    % end
    % if (la==0)
    %     la = max(length(Fb.A), length(Fa.A));
    % else
    %     la = la + 1;
    % end

    lb = length(Fb.B) + length(Fa.B) - 1;
    la = length(Fb.A) + length(Fa.A) - 1;
    B = zeros(1, lb);
    A = zeros(1, la);
    G = Fb.G .* Fa.G;

    mB = Fb.B' * Fa.B;
    mA = Fb.A' * Fa.A;

    for i = 1 : length(Fb.B)
        for j = 1 : length(Fa.B)
            B(i+j-1) = B(i+j-1) + mB(i,j);
        end
    end
    for i = 1 : length(Fb.A)
        for j = 1 : length(Fa.A)
            A(i+j-1) = A(i+j-1) + mA(i,j);
        end
    end
    F.B = B;
    F.A = A;
    F.G = G;

end