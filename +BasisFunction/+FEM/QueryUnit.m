classdef QueryUnit < handle
    %QUERYUNIT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        query_protocol_     % FEM: {region, element_id}
        non_zero_id_ = []
        evaluate_basis_ = []
    end
    
    methods
        function this = QueryUnit()
            this.query_protocol_ = {[], []};
        end
    end
    
end

