function f = makeCostFunctionTest(EVector, b, Mean)
    f = @costFunction;

    function c = costFunction(params)
        good = [1;-0.05;73;160];
        
        d = params-good;
        c = sum(abs(d));
        %disp(num2str(c));
    end
end