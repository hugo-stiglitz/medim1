function f = makeCostFunctionTest(EVector, b, Mean, idealLandmarks)
    f = @costFunction;

    function c = costFunction(params)
        
        shape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));
        
        c = sum(sum(abs(shape-idealLandmarks)));
    end
end