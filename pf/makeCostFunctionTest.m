function f = makeCostFunctionTest(EVector, b, Mean, idealLandmarks)
%makeCostFunctionTest Makes a cost function that compares the differences
% to the ideal landmarks

    f = @costFunction;

    function c = costFunction(params)
        
        shape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));
        
        c = sum(sum(abs(shape-idealLandmarks)));
    end
end